# binaries -- lintian check script -*- perl -*-

# Copyright (C) 1998 Christian Schwarz and Richard Braakman
# Copyright (C) 2012 Kees Cook
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, you can find it on the World Wide
# Web at http://www.gnu.org/copyleft/gpl.html, or write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
# MA 02110-1301, USA.

package Lintian::binaries;
use strict;
use warnings;
use autodie;

use constant NUMPY_STRING => 'module compiled against ABI version %x'
  . ' but this version of numpy is %x';

use Lintian::Check qw(check_spelling);
use Lintian::Data;
use Lintian::Relation qw(:constants);
use Lintian::Tags qw(tag);
use Lintian::Output qw(debug_msg);
use Lintian::Util qw(fail slurp_entire_file strip);

use File::Spec;

my $ARCH_REGEX = Lintian::Data->new('binaries/arch-regex', qr/\s*\~\~/o,
    sub { return qr/$_[1]/ });
my $ARCH_64BIT_EQUIVS
  = Lintian::Data->new('binaries/arch-64bit-equivs', qr/\s*\=\>\s*/);

sub _embedded_libs {
    my ($key, $val, undef) = @_;
    my $result = {'libname' => $key,};
    my ($opts, $regex) = split m/\|\|/, $val, 2;
    if (!$regex) {
        $regex = $opts;
        $opts = '';
    } else {
        strip($opts);
        foreach my $optstr (split m/\s++/, $opts) {
            my ($opt, $val) = split m/=/, $optstr, 2;
            if ($opt eq 'source' or $opt eq 'libname') {
                $result->{$opt} = $val;
            } elsif ($opt eq 'source-regex') {
                $result->{$opt} = qr/$val/;
            } else {
                fail(   "Unknown option $opt used for $key"
                      . ' (in binaries/embedded-libs)');
            }
        }
    }

    if (defined $result->{'source'} and $result->{'source-regex'}) {
        fail(   "Both source and source-regex used for $key"
              . ' (in binaries/embedded-libs)');
    } else {
        $result->{'source'} = $key unless defined $result->{'source'};
    }

    $result->{'match'} = qr/$regex/;

    return $result;
}

our $EMBEDDED_LIBRARIES
  = Lintian::Data->new('binaries/embedded-libs', qr/\s*+\|\|/,
    \&_embedded_libs);

our $MULTIARCH_DIRS = Lintian::Data->new('common/multiarch-dirs', qr/\s++/,
    sub { return { 'dir' => $_[1], 'match' => qr/\Q$_[1]\E/ } });

sub _split_hash {
    my (undef, $val) = @_;
    my $hash = {};
    map { $hash->{$_} = 1 } split m/\s*,\s*/o, $val;
    return $hash;
}

our $HARDENING= Lintian::Data->new('binaries/hardening-tags', qr/\s*\|\|\s*/o,
    \&_split_hash);
our $LFS_SYMBOLS = Lintian::Data->new('binaries/lfs-symbols');

our $ARCH_32_REGEX;

sub run {
    my ($pkg, $type, $info, $proc, $group) = @_;

    my $madir;
    my $gnu_triplet_re;
    my $ruby_triplet_re;
    my $dynsyms = 0;
    my $needs_libc = '';
    my $needs_libcxx = '';
    my $needs_libc_file;
    my $needs_libcxx_file;
    my $needs_libc_count = 0;
    my $needs_libcxx_count = 0;
    my $needs_depends_line = 0;
    my $has_perl_lib = 0;
    my $has_php_ext = 0;
    my $uses_numpy_c_abi = 0;

    my %SONAME;

    my $arch = $info->field('architecture', '');
    my $multiarch = $info->field('multi-arch', 'no');
    my $srcpkg = $proc->pkg_src;

    foreach my $file (sort keys %{$info->objdump_info}) {
        my $objdump = $info->objdump_info->{$file};
        my $has_lfs = undef;
        my $is_profiled = 0;
        # Only 32bit ELF binaries can lack LFS.
        $ARCH_32_REGEX = $ARCH_REGEX->value('32')
          unless defined $ARCH_32_REGEX;
        $has_lfs = 1 unless $info->file_info($file) =~ m/$ARCH_32_REGEX/o;
        # We don't care if it is a debug file
        $has_lfs = 1 if $file =~ m,^usr/lib/debug/,;

        if (defined $objdump->{SONAME}) {
            foreach my $soname (@{$objdump->{SONAME}}) {
                $SONAME{$soname} ||= [];
                push @{$SONAME{$soname}}, $file;
            }
        }
        foreach my $symbol (@{$objdump->{SYMBOLS}}) {
            my ($foo, $sec, $sym) = @{$symbol};

            unless (defined $has_lfs) {
                if ($LFS_SYMBOLS->known($sym)) {
                    # Using a 32bit only interface call, some parts of the
                    # binary are built without LFS.
                    $has_lfs = 0;
                }
            }
            next if $is_profiled;
            # According to the binutils documentation[1], the profiling symbol
            # can be named "mcount", "_mcount" or even "__mcount".
            # [1] http://sourceware.org/binutils/docs/gprof/Implementation.html
            if ($sec =~ /^GLIBC_.*/ and $sym =~ m{\A _?+ _?+ mcount \Z}xsm){
                $is_profiled = 1;
            } elsif ($arch ne 'hppa') {
                # This code was used to detect profiled code in Wheezy
                # (and earlier)
                if (    $foo eq '.text'
                    and $sec eq 'Base'
                    and$sym eq '__gmon_start__') {
                    $is_profiled = 1;
                }
            }
            tag 'binary-compiled-with-profiling-enabled', $file
              if $is_profiled;
        }
        tag 'binary-file-compressed-with-upx', $file if $objdump->{'UPX'};
        tag 'apparently-corrupted-elf-binary', $file
          if $objdump->{'ERRORS'};
        tag 'binary-file-built-without-LFS-support', $file
          if defined $has_lfs and not $has_lfs;
        if ($objdump->{'BAD-DYNAMIC-TABLE'}) {
            tag 'binary-with-bad-dynamic-table', $file
              unless $file =~ m%^usr/lib/debug/%;
        }
    }

    # For the package naming check, filter out SONAMEs where all the
    # files are at paths other than /lib, /usr/lib, or /usr/X11R6/lib.
    # This avoids false positives with plugins like Apache modules,
    # which may have their own SONAMEs but which don't matter for the
    # purposes of this check.  Also filter out nsswitch modules
    if (defined($MULTIARCH_DIRS->value($arch))) {
        $madir = $MULTIARCH_DIRS->value($arch)->{'dir'};
    } else {
        # In the case that the architecture is "all" or unknown (or we do
        # not know the multi-arch path for a known architecture) , we assume
        # it the multi-arch path to be this (hopefully!) non-existent path to
        # avoid warnings about uninitialized variables.
        $madir = './!non-existant-path!/./';
    }

    $madir = './!non-existant-path!/./' unless defined $madir;

    $gnu_triplet_re = quotemeta $madir;
    $gnu_triplet_re =~ s,^i386,i[3-6]86,;
    $ruby_triplet_re = $gnu_triplet_re;
    $ruby_triplet_re =~ s,linux\\-gnu$,linux,;
    $ruby_triplet_re =~ s,linux\\-gnu,linux\\-,;

    sub lib_soname_path {
        my ($dir, @paths) = @_;
        foreach my $path (@paths) {
            next
              if $path
              =~ m%^(?:usr/)?lib(?:32|64)?/libnss_[^.]+\.so(?:\.[0-9]+)$%;
            return 1 if $path =~ m%^lib/[^/]+$%;
            return 1 if $path =~ m%^usr/lib/[^/]+$%;
            return 1 if defined $dir && $path =~ m%lib/$dir/[^/]++$%;
            return 1 if defined $dir && $path =~ m%usr/lib/$dir/[^/]++$%;
        }
        return 0;
    }
    my @sonames
      = sort grep { lib_soname_path($madir, @{$SONAME{$_}}) } keys %SONAME;

    # try to identify transition strings
    my $base_pkg = $pkg;
    $base_pkg =~ s/c102\b//o;
    $base_pkg =~ s/c2a?\b//o;
    $base_pkg =~ s/\dg$//o;
    $base_pkg =~ s/gf$//o;
    $base_pkg =~ s/-udeb$//o;
    $base_pkg =~ s/^lib64/lib/o;

    my $match_found = 0;
    foreach my $expected_name (@sonames) {
        $expected_name =~ s/([0-9])\.so\./$1-/;
        $expected_name =~ s/\.so(?:\.|\z)//;
        $expected_name =~ s/_/-/g;

        if (   (lc($expected_name) eq $pkg)
            || (lc($expected_name) eq $base_pkg)) {
            $match_found = 1;
            last;
        }
    }

    tag 'package-name-doesnt-match-sonames', "@sonames"
      if @sonames && !$match_found;

    my %directories;
    for my $file ($info->sorted_index) {
        my $name = $file->name;
        next unless $file->is_dir || $file->is_symlink;
        $name =~ s,/\z,,;
        $directories{"/$name"}++;
    }

    my $src = $group->get_source_processable();
    my $built_with_golang;
    if (defined($src)) {
        $built_with_golang
          = $src->info->relation('build-depends')->implies('golang-go');
    }

    # process all files in package
    foreach my $file ($info->sorted_index) {
        my $fileinfo = $info->file_info($file);
        my $objdump = $info->objdump_info->{$file};

        # binary or object file?
        next
          unless ($fileinfo =~ m/^[^,]*\bELF\b/)
          or ($fileinfo =~ m/\bcurrent ar archive\b/);

        # Warn about Architecture: all packages that contain shared libraries.
        if ($arch eq 'all') {
            tag 'arch-independent-package-contains-binary-or-object',$file;
        }

        if ($file =~ m,^etc/,) {
            tag 'binary-in-etc', $file;
        }

        if ($file =~ m,^usr/share/,) {
            tag 'arch-dependent-file-in-usr-share', $file;
        }

        if ($multiarch eq 'same') {
            unless ($file
                =~ m,\b$gnu_triplet_re\b|/(?:$ruby_triplet_re|java-\d+-openjdk-\Q$arch\E|\.build-id)/,
              ) {
                tag 'arch-dependent-file-not-in-arch-specific-directory',$file;
            }
        }

        # ELF?
        next unless $fileinfo =~ m/^[^,]*\bELF\b/o;

        if ($arch eq 'all' or not $ARCH_REGEX->known($arch)) {
            # arch:all or unknown architecture - not much we can say here
            1;
        } else {
            my $archre = $ARCH_REGEX->value($arch);
            my $bad = 1;
            if ($fileinfo =~ m/$archre/) {
                # If it matches the architecture regex, it is good
                $bad = 0;
            } elsif ($file =~ m,(?:^|/)lib(x?\d{2})/,
                or $file =~ m,^emul/ia(\d{2}),) {
                my $bitre = $ARCH_REGEX->value($1);
                # Special case - "old" multi-arch dirs
                $bad = 0 if $bitre and $fileinfo =~ m/$bitre/;
            } elsif ($ARCH_64BIT_EQUIVS->known($arch)
                && $file =~ m,^lib/modules/,) {
                my $arch64re
                  = $ARCH_REGEX->value($ARCH_64BIT_EQUIVS->value($arch));
                # Allow amd64 kernel modules to be installed on i386.
                $bad = 0 if $fileinfo =~ m/$arch64re/;
            } elsif ($arch eq 'amd64') {
                my $arch32re = $ARCH_REGEX->value('i386');
                # Ignore i386 binaries in amd64 packages for right now.
                $bad = 0 if $fileinfo =~ m/$arch32re/;
            }
            tag 'binary-from-other-architecture', $file if $bad;
        }

        my $strings = slurp_entire_file($info->strings($file));
        my $exceptions = {
            %{ $group->info->spelling_exceptions },
            'teH' => 1, # From #711207
        };
        check_spelling('spelling-error-in-binary',$strings, $file,$exceptions);

        # stripped?
        if ($fileinfo =~ m,not stripped\s*$,o) {
            # Is it an object file (which generally can not be
            # stripped), a kernel module, debugging symbols, or
            # perhaps a debugging package?
            unless ($file =~ m,\.k?o$,
                or $pkg =~ m/-dbg$/
                or $pkg =~ m/debug/
                or $file =~ m,/lib/debug/,
                or $file =~ m,\.gox$,o) {
                if (    $fileinfo =~ m/executable/
                    and $strings =~ m/^Caml1999X0[0-9][0-9]$/m) {
                    # Check for OCaml custom executables (#498138)
                    tag 'ocaml-custom-executable', $file;
                } else {
                    tag 'unstripped-binary-or-object', $file;
                }
            }
        } else {
            # stripped but a debug or profiling library?
            if (($file =~ m,/lib/debug/,o) or ($file =~ m,/lib/profile/,o)){
                tag 'library-in-debug-or-profile-should-not-be-stripped',$file;
            } else {
                # appropriately stripped, but is it stripped enough?
                foreach my $sect ('.note', '.comment') {
                    if (exists $objdump->{'SH'}->{$sect}) {
                        tag 'binary-has-unneeded-section', "$file $sect";
                    }
                }
            }
        }

        # rpath is disallowed, except in private directories
        if (exists $objdump->{RPATH}) {
            foreach my $rpath (
                map {File::Spec->canonpath($_)}
                keys %{$objdump->{RPATH}}
              ) {
                next
                  if $rpath
                  =~ m,^/usr/lib/(?:$madir/)?(?:games/)?(?:\Q$pkg\E|\Q$srcpkg\E)(?:/|\z),;
                next if $rpath =~ m,^\$\{?ORIGIN\}?,;
                next
                  if $directories{$rpath}
                  and $rpath !~ m,^(?:/usr)?/lib(?:/$madir)?/?\z,;
                tag 'binary-or-shlib-defines-rpath', "$file $rpath";
            }
        }

        foreach my $emlib ($EMBEDDED_LIBRARIES->all) {
            my $ldata = $EMBEDDED_LIBRARIES->value($emlib);
            if ($ldata->{'source-regex'}) {
                next if $proc->pkg_src =~ m/^$ldata->{'source-regex'}$/;
            } else {
                next if $proc->pkg_src eq $ldata->{'source'};
            }
            if ($strings =~ $ldata->{'match'}) {
                tag 'embedded-library', "$file: $ldata->{'libname'}";
            }
        }

        # binary or shared object?
        next
          unless ($fileinfo =~ m/executable/)
          or ($fileinfo =~ m/shared object/);
        next if $type eq 'udeb';

        # Perl library?
        if ($file =~ m,^usr/lib/(?:[^/]+/)?perl5/.*\.so$,) {
            $has_perl_lib = 1;
        }

        # PHP extension?
        if ($file =~ m,^usr/lib/php\d/.*\.so(?:\.\d+)*$,) {
            $has_php_ext = 1;
        }

        # Python extension using Numpy C ABI?
        if (
            $file =~ m,usr/lib/(?:pyshared/)?python2\.\d+/.*(?<!_d)\.so$,
            or(     $file =~ m,usr/lib/python3/.+\.cpython-\d+([a-z]+)\.so$,
                and $1 !~ /d/)
          ) {
            if (index($strings, NUMPY_STRING) != -1) {
                $uses_numpy_c_abi = 1;
            }
        }

        # Something other than detached debugging symbols in
        # /usr/lib/debug paths.
        if ($file
            =~ m,^usr/lib/debug/(?:lib\d*|s?bin|usr|opt|dev|emul|\.build-id)/,)
        {
            if (scalar(@{ $objdump->{NEEDED} })) {
                tag 'debug-file-should-use-detached-symbols', $file;
            }
            tag 'debug-file-with-no-debug-symbols', $file
              unless (exists $objdump->{'SH'}->{'.debug_line'}
                or exists $objdump->{'SH'}->{'.zdebug_line'});
        }

        # Detached debugging symbols directly in /usr/lib/debug.
        if ($file =~ m,^usr/lib/debug/[^/]+$,) {
            unless (scalar(@{ $objdump->{NEEDED} })
                || $fileinfo =~ m/statically linked/) {
                tag 'debug-symbols-directly-in-usr-lib-debug', $file;
            }
        }

        # statically linked?
        if (!scalar(@{ $objdump->{NEEDED} })) {
            if ($fileinfo =~ m/shared object/o) {
                # Some exceptions: kernel modules, detached debugging
                # information and the dynamic loader (which itself has
                # no dependencies).
                next if ($file =~ m%^lib/modules/%);
                next if ($file =~ m%^usr/lib/debug/%);
                next
                  if ($file =~ m%^lib(?:|32|64)/(?:[\w/]+/)?ld-[\d.]+\.so$%);
                tag 'shared-lib-without-dependency-information', $file;
            } else {
                # Some exceptions: files in /boot, /usr/lib/debug/*,
                # named *-static or *.static, or *-static as
                # package-name.
                next if ($file =~ m%^boot/%);
                next if ($file =~ /[\.-]static$/);
                next if ($pkg =~ /-static$/);
                # Binaries built by the Go compiler are statically
                # linked by default.
                next if ($built_with_golang);
                # klibc binaries appear to be static.
                next
                  if (exists $objdump->{INTERP}
                    && $objdump->{INTERP} =~ m,/lib/klibc-\S+\.so,);
                # Location of debugging symbols.
                next if ($file =~ m%^usr/lib/debug/%);
                # ldconfig must be static.
                next if ($file eq 'sbin/ldconfig');
                tag 'statically-linked-binary', $file;
            }
        } else {
            my $no_libc = 1;
            my $is_shared = 0;
            $needs_depends_line = 1;
            $is_shared = 1 if index($fileinfo, 'shared object') != -1;
            for my $lib (@{$objdump->{NEEDED}}) {
                if ($lib =~ /^libc\.so\.(\d+.*)/) {
                    $needs_libc = "libc$1";
                    $needs_libc_file = $file->name unless $needs_libc_file;
                    $needs_libc_count++;
                    $no_libc = 0;
                }
                if ($lib =~ m{\A libstdc\+\+\.so\.(\d+) \Z}xsm) {
                    $needs_libcxx = "libstdc++$1";
                    $needs_libcxx_file = $file->name
                      unless $needs_libcxx_file;
                    $needs_libcxx_count++;
                }
            }
            if ($no_libc and not $file =~ m,/libc\b,) {
                # If there is no libc dependency, then it is most likely a
                # bug.  The major exception is that some C++ libraries,
                # but these tend to link against libstdc++ instead.  (see
                # #719806)
                if ($is_shared) {
                    tag 'library-not-linked-against-libc', $file
                      unless $needs_libcxx ne '';
                } else {
                    tag 'program-not-linked-against-libc', $file;
                }
            }

            # Check for missing hardening characteristics. This currently
            # handles the following checks:
            # no-relro no-fortify-functions no-stackprotector no-bindnow no-pie
            if (exists($info->hardening_info->{$file})) {
                my $flags = $HARDENING->value($arch);
                if ($flags) {
                    foreach my $t (@{$info->hardening_info->{$file}}) {
                        my $tag = "hardening-$t";
                        tag $tag, $file if $flags->{$tag};
                    }
                }
            }
        }
    }

    # Find the package dependencies, which is used by various checks.
    my $depends = $info->relation('strong');

    # Check for a libc dependency.
    if ($needs_depends_line) {
        if ($depends->empty) {
            tag 'missing-depends-line';
        } else {
            if ($needs_libc && $pkg !~ /^libc[\d.]+(?:-|\z)/) {
                # Match libcXX or libcXX-*, but not libc3p0.
                my $re = qr/^\Q$needs_libc\E\b/;
                if (!$depends->matches($re)) {
                    my $others = '';
                    $needs_libc_count--;
                    if ($needs_libc_count > 0) {
                        $others = " and $needs_libc_count others";
                    }
                    tag 'missing-dependency-on-libc',
                      "needed by $needs_libc_file$others";
                }
            }
            if ($needs_libcxx ne '') {
                # Match libstdc++XX or libcstdc++XX-*
                my $re = qr/^\Q$needs_libcxx\E\b/;
                if (!$depends->matches($re)) {
                    my $others = '';
                    $needs_libcxx_count--;
                    if ($needs_libcxx_count > 0) {
                        $others = " and $needs_libcxx_count others";
                    }
                    tag 'missing-dependency-on-libstdc++',
                      "needed by $needs_libcxx_file$others";
                }
            }
        }
    }

    # Check for a Perl dependency.
    if ($has_perl_lib) {
        # It is a virtual package, so no version is allowed and
        # alternatives probably does not make sense here either.
        my $re = qr/^perlapi-[\d.]+(?:\s*\[[^\]]+\])?$/;
        unless ($depends->matches($re, VISIT_OR_CLAUSE_FULL)) {
            tag 'missing-dependency-on-perlapi';
        }
    }

    # Check for a phpapi- dependency.
    if ($has_php_ext) {
        # It is a virtual package, so no version is allowed and
        # alternatives probably does not make sense here either.
        unless ($depends->matches(qr/^phpapi-[\d\w+]+$/, VISIT_OR_CLAUSE_FULL))
        {
            tag 'missing-dependency-on-phpapi';
        }
    }

    # Check for dependency on python-numpy-abiN dependency (or strict versioned
    # dependency on python-numpy)
    if ($uses_numpy_c_abi and $pkg !~ m{\A python3?-numpy \Z}xsm) {
        # We do not allow alternatives as it would mostly likely
        # defeat the purpose of this relation.  Also, we do not allow
        # versions for -abi as it is a virtual package.
        my $vflags = VISIT_OR_CLAUSE_FULL;
        tag 'missing-dependency-on-numpy-abi'
          unless $depends->matches(qr/^python3?-numpy-abi\d+$/, $vflags)
          or (  $depends->matches(qr/^python-numpy \(>[>=][^\|]+$/, $vflags)
            and $depends->matches(qr/^python-numpy \(<[<=][^\|]+$/, $vflags));
    }

    return;
}

1;

# Local Variables:
# indent-tabs-mode: nil
# cperl-indent-level: 4
# End:
# vim: syntax=perl sw=4 sts=4 sr et
