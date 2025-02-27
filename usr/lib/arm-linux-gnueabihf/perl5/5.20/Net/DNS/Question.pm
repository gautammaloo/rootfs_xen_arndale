package Net::DNS::Question;

#
# $Id: Question.pm 1222 2014-06-24 12:30:08Z willem $
#
use vars qw($VERSION);
$VERSION = (qw$LastChangedRevision: 1222 $)[1];


=head1 NAME

Net::DNS::Question - DNS question record

=head1 SYNOPSIS

    use Net::DNS::Question;

    $question = new Net::DNS::Question('example.com', 'A', 'IN');

=head1 DESCRIPTION

A Net::DNS::Question object represents a record in the question
section of a DNS packet.

=cut


use strict;
use integer;
use Carp;

use Net::DNS::Parameters;
use Net::DNS::Domain;
use Net::DNS::DomainName;


=head1 METHODS

=head2 new

    $question = new Net::DNS::Question('example.com', 'A', 'IN');
    $question = new Net::DNS::Question('example.com');

    $question = new Net::DNS::Question('192.0.32.10', 'PTR', 'IN');
    $question = new Net::DNS::Question('192.0.32.10');

Creates a question object from the domain, type, and class passed as
arguments. One or both type and class arguments may be omitted and
will assume the default values shown above.

RFC4291 and RFC4632 IP address/prefix notation is supported for
queries in both in-addr.arpa and ip6.arpa namespaces.

=cut

sub new {
	my $self   = bless {}, shift;
	my $qname  = shift;
	my $qtype  = shift || '';
	my $qclass = shift || '';

	# tolerate (possibly unknown) type and class in zone file order
	unless ( exists $classbyname{$qclass} ) {
		( $qtype, $qclass ) = ( $qclass, $qtype ) if exists $classbyname{$qtype};
		( $qtype, $qclass ) = ( $qclass, $qtype ) if $qtype =~ /CLASS/;
	}
	unless ( exists $typebyname{$qtype} ) {
		( $qtype, $qclass ) = ( $qclass, $qtype ) if exists $typebyname{$qclass};
		( $qtype, $qclass ) = ( $qclass, $qtype ) if $qclass =~ /TYPE/;
	}

	# if argument is an IP address, do appropriate reverse lookup
	if ( defined $qname and $qname =~ m/:|\d$/ ) {
		if ( my $reverse = _dns_addr($qname) ) {
			$qname = $reverse;
			$qtype ||= 'PTR';
		}
	}

	$self->{owner} = new Net::DNS::DomainName1035($qname);
	$self->{type}  = typebyname( $qtype || 'A' );
	$self->{class} = classbyname( $qclass || 'IN' );

	return $self;
}


=head2 decode

    $question = decode Net::DNS::Question(\$data, $offset);

    ($question, $offset) = decode Net::DNS::Question(\$data, $offset);

Decodes the question record at the specified location within a DNS
wire-format packet.  The first argument is a reference to the buffer
containing the packet data.  The second argument is the offset of
the start of the question record.

Returns a Net::DNS::Question object and the offset of the next
location in the packet.

An exception is raised if the object cannot be created
(e.g., corrupt or insufficient data).

=cut

use constant QFIXEDSZ => length pack 'n2', (0) x 2;

sub decode {
	my $self = bless {}, shift;
	my ( $data, $offset ) = @_;

	( $self->{owner}, $offset ) = decode Net::DNS::DomainName1035(@_);

	my $next = $offset + QFIXEDSZ;
	die 'corrupt wire-format data' if length $$data < $next;
	@{$self}{qw(type class)} = unpack "\@$offset n2", $$data;

	wantarray ? ( $self, $next ) : $self;
}


=head2 encode

    $data = $question->encode( $offset, $hash );

Returns the Net::DNS::Question in binary format suitable for
inclusion in a DNS packet buffer.

The optional arguments are the offset within the packet data where
the Net::DNS::Question is to be stored and a reference to a hash
table used to index compressed names within the packet.

=cut

sub encode {
	my $self = shift;

	pack 'a* n2', $self->{owner}->encode(@_), @{$self}{qw(type class)};
}


=head2 name

    $name = $question->name;

Internationalised domain name corresponding to the qname attribute.

Decoding non-ASCII domain names is computationally expensive and
undesirable for names which are likely to be used to construct
further queries.

When required to communicate with humans, the 'proper' domain name
should be extracted from a query or reply packet.

    $query = new Net::DNS::Packet( $example, 'ANY' );
    $reply = $resolver->send($query) or die;
    ($question) = $reply->question;
    $name = $question->name;

=cut

sub name {
	my $self = shift;

	croak 'immutable object: argument invalid' if scalar @_;
	$self->{owner}->xname;
}


=head2 qname, zname

    $qname = $question->qname;
    $zname = $question->zname;

Canonical ASCII domain name as required for the query subject
transmitted to a nameserver.  In dynamic update packets, this
attribute is known as zname() and refers to the zone name.

=cut

sub qname {
	my $self = shift;

	croak 'immutable object: argument invalid' if scalar @_;
	$self->{owner}->name;
}

sub zname { &qname; }


=head2 qtype, ztype

    $qtype = $question->qtype;
    $ztype = $question->ztype;

Returns the question type attribute.  In dynamic update packets,
this attribute is known as ztype() and refers to the zone type.

=cut

sub type {
	my $self = shift;

	croak 'immutable object: argument invalid' if scalar @_;
	typebyval( $self->{type} );
}

sub qtype { &type; }
sub ztype { &type; }


=head2 qclass, zclass

    $qclass = $question->qclass;
    $zclass = $question->zclass;

Returns the question class attribute.  In dynamic update packets,
this attribute is known as zclass() and refers to the zone class.

=cut

sub class {
	my $self = shift;

	croak 'immutable object: argument invalid' if scalar @_;
	classbyval( $self->{class} );
}

sub qclass { &class; }
sub zclass { &class; }


=head2 print

    $object->print;

Prints the record to the standard output.  Calls the string() method
to get the string representation.

=cut

sub print {
	print shift->string, "\n";
}


=head2 string

    print "string = ", $question->string, "\n";

Returns a string representation of the question record.

=cut

sub string {
	my $self = shift;

	join "\t", $self->{owner}->string, $self->qclass, $self->qtype;
}


########################################

use vars qw($AUTOLOAD);

sub AUTOLOAD {			## Default method
	no strict;
	@_ = ("method $AUTOLOAD undefined");
	goto &{'Carp::confess'};
}


sub DESTROY { }			## Avoid tickling AUTOLOAD (in cleanup)


sub _dns_addr {			## Map IP address into reverse lookup namespace
	local $_ = shift;

	# IP address must contain address characters only
	return undef unless m#^[a-fA-F0-9:./]+$#;

	my ( $address, $length ) = split m#/#, $_ . '/0';

	# map IPv4 address to in-addr.arpa space
	if (m#^\d*[.\d]*\d(/\d+)?$#) {
		return undef if new Net::DNS::DomainName('@')->label;
		my @parse = split /\./, $address;
		my $prefx = $length || @parse << 3;
		my $last = $prefx > 24 ? 3 : ( $prefx - 1 ) >> 3;
		return join '.', reverse( ( @parse, (0) x 3 )[0 .. $last] ), 'in-addr.arpa.';
	}

	# map IPv6 address to ip6.arpa space
	return unless m#^[:\w]+:([.\w]*)(/\d+)?$#;
	my $rhs = $1 || '0';
	return _dns_addr("$rhs/$length") if m#^[:0]*:0*:[fF]{4}:[^:]+$#;	   # IPv4
	$rhs = sprintf '%x%0.2x:%x%0.2x', split( /\./, $rhs ), 0, 0, 0 if /\./;
	$address =~ s/:[^:]*$/:0$rhs/;
	my @parse = split /:/, ( reverse "0$address" ), 9;
	my @xpand = map { /./ ? $_ : ('0') x ( 9 - @parse ) } @parse;		   # expand ::
	my $prefx = $length || @xpand << 4;			# implicit length if unspecified
	my $len = $prefx > 124 ? 32 : ( $prefx + 3 ) >> 2;
	my $hex = pack 'A4' x 8, map { $_ . '000' } ('0') x ( 8 - @xpand ), @xpand;
	return join '.', split( //, substr( $hex, -$len ) ), 'ip6.arpa.';
}


1;
__END__

########################################

=head1 COPYRIGHT

Copyright (c)1997-2002 Michael Fuhr. 

Portions Copyright (c)2002-2004 Chris Reinhardt.

Portions Copyright (c)2003,2006-2011 Dick Franks.

All rights reserved.

This program is free software; you may redistribute it and/or
modify it under the same terms as Perl itself.


=head1 SEE ALSO

L<perl>, L<Net::DNS>, L<Net::DNS::DomainName>, L<Net::DNS::Packet>,
RFC 1035 Section 4.1.2

