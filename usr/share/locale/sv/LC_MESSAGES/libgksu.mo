��    >        S   �      H  �   I  �     y   �  F   P  �   �  L   #  �  p     >
     N
  �   e
     =  A   Y  1   �  /   �     �  6     "   T     w     �  U   �  O   �     L     k  :   �  E   �       S   )     }  (   �  .   �  ,   �       	   ,  
   6     A     T     h     z     �     �  	   �  ?   �  �     w   �  �   -  �   �  .   �  �   �  �   N      <     ]     m     �  #   �  Y   �  6     ;   D  	   �     �     �     �  S  �  �   "  �     }   �  I   a  �   �  W   F     �     �     �  �   �     �  @   �  @   %  1   f  )   �  8   �  $   �           =  g   Z  P   �  *      %   >   H   d   \   �   %   
!  S   0!     �!  2   �!  7   �!  7   "     >"  
   Y"     d"     p"     �"     �"     �"     �"     �"  
   #  A   #  �   O#  |   $  �   �$  �   @%  3   &  �   9&  �   �&  &   �'     �'     (     (  -   &(  {   T(  :   �(  ?   )  	   K)     U)     ])     y)     (   2          +      5   3         
   9   ;                $       %   >                          8   .             -       	      =               <       !                               #           7   4   ,                     1       0   6   :               /   '      "      )       &   *       <b><big>Could not grab your keyboard.</big></b>

A malicious client may be eavesdropping on your session or you may have just clicked a menu or some application just decided to get focus.

Try again. <b><big>Could not grab your mouse.</big></b>

A malicious client may be eavesdropping on your session or you may have just clicked a menu or some application just decided to get focus.

Try again. <b><big>Enter the administrative password</big></b>

The application '%s' lets you modify essential parts of your system. <b><big>Enter the password of %s to run the application '%s'</big></b> <b><big>Enter your password to perform administrative tasks</big></b>

The application '%s' lets you modify essential parts of your system. <b><big>Enter your password to run the application '%s' as user %s</big></b> <b><big>Granted permissions without asking for password</big></b>

The '%s' program was started with the privileges of the %s user without the need to ask for a password, due to your system's authentication mechanism setup.

It is possible that you are being allowed to run specific programs as user %s without the need for a password, or that the password is cached.

This is not a problem report; it's simply a notification to make sure you are aware of this. <b>Behavior</b> <b>Screen Grabbing</b> <b>Would you like your screen to be "grabbed"
while you enter the password?</b>

This means all applications will be paused to avoid
the eavesdropping of your password by a a malicious
application while you type it. <b>You have capslock on</b> <span weight="bold" size="larger">Type the root password.</span>
 Configure behavior of the privilege-granting tool Could not read from the pipe with the child: %s Disable keyboard and mouse grab Display information message when no password is needed Do _not display this message again Error creating pipe: %s Error opening pipe: %s Failed to communicate with gksu-run-helper.

Received bad string while expecting:
 %s Failed to communicate with gksu-run-helper.

Received:
 %s
While expecting:
 %s Failed to exec new process: %s Failed to fork new process: %s Failed to load glade file; please check your installation. Failed to obtain xauth key: xauth binary not found at usual locations Force keyboard and mouse grab Grab keyboard and mouse even if -g has been passed as argument on the command line. Granting Rights Keyring to which passwords will be saved Not using locking for nfs mounted lock file %s Not using locking for read only lock file %s Password prompt canceled. Password: Password:  Privilege granting Prompt for grabbing Remember password Save for this session Save in the keyring Save password to gnome-keyring Sudo mode The gksu-run-helper command was not found or is not executable. The name of the keyring gksu should use. Usual values are "session", which saves the password for the session, and "default", which saves the password with no timeout. The underlying authorization mechanism (sudo) does not allow you to run this program. Contact the system administrator. This option determines whether a message dialog will be displayed informing the user that the program is being run without the need of a password being asked for some reason. This option will make gksu prompt the user if he wants to have the screen grabbed before entering the password. Notice that this only has an effect if force-grab is disabled. Unable to copy the user's Xauthorization file. Whether sudo should be the default backend method. This method is otherwise accessed though the -S switch or by running 'gksudo' instead of 'gksu'. Whether the keyboard and mouse grabbing should be turned off. This will make it possible for other X applications to listen to keyboard input events, thus making it not possible to shield from malicious applications which may be running. Wrong password got from keyring. Wrong password. _Authentication mode: _Grab mode: enable
disable
force enable
prompt
 gksu can save the password you type to the gnome-keyring so you'll not be asked everytime gksu_run needs a command to be run, none was provided. gksu_sudo_run needs a command to be run, none was provided. gtk-close su
sudo su terminated with %d status sudo terminated with %d status Project-Id-Version: libgksu
Report-Msgid-Bugs-To: kov@debian.org
POT-Creation-Date: 2006-12-13 22:22+0100
PO-Revision-Date: 2007-01-10 08:23+0100
Last-Translator: Daniel Nylander <po@danielnylander.se>
Language-Team: Swedish <tp-sv@listor.tp-sv.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 <b><big>Kunde inte fånga ditt tangentbord.</big></b>

En ondsint klient har möjligheten att lyssna på din session, du har klickat på en meny eller att något program precis har bestämt sig för att ta fokus.

Försök igen. <b><big>Kunde inte fånga din mus.</big></b>

En ondsint klient har möjligheten att lyssna på din session, du har klickat på en meny eller att något program precis har bestämt sig för att ta fokus.

Försök igen. <b><big>Ange det administrativa lösenordet</big></b>

Programmet "%s" låter dig ändra systemkritiska delar av ditt system. <b><big>Ange lösenordet för %s för att köra programmet "%s"</big></b> <b><big>Ange ditt lösenord för att genomföra administrativa uppgifter</big></b>

Programmet "%s" låter dig ändra systemkritiska delar av ditt system. <b><big>Ange ditt lösenord för att köra programmet "%s" som användaren %s</big></b> <b><big>Tilldelade rättigheter utan att fråga efter lösenord</big></b>

Programmet "%s" startades med rättigheterna för användaren %s utan att behöva fråga efter ett lösenord. Detta på grund av konfigurationen av autentiseringsmekanismen i ditt system.

Det är möjligt att du har tillåtits att köra specifika program som användaren %s utan att behöva ange ett lösenord, eller att lösenordet är mellanlagrat.

Det här är inte en problemrapport; det är helt enkelt en notifiering för att göra dig uppmärksam på det här. <b>Beteende</b> <b>Skärmfångst</b> <b>Vill du att din skärm ska "fångas"
under tiden du matar in lösenordet?</b>

Det här betyder att alla program pausas för att förhindra
avlyssning av ditt lösenord av ett ondsint program
under tiden du matar in det. <b>Du har CapsLock intryckt</b> <span weight="bold" size="larger">Ange root-lösenordet.</span>
 Konfigurera beteendet för verktyget för rättighetstilldelning Kunde inte läsa från röret med barnprocess: %s Inaktivera fångst av tangentbord och mus Visa informationsmeddelande när inget lösenord behövs Visa _inte det här meddelandet igen Fel vid skapande av rör: %s Fel vid öppning av rör: %s Misslyckades med att kommunicera med gksu-run-helper.

Mottog fel sträng när detta förväntades:
 %s Misslyckades att kommunicera med gksu-run-helper.

Mottog:
 %s
Förväntade:
 %s Misslyckades med att starta ny process: %s Misslyckades att grena ny process: %s Misslyckades med att läsa in glade-filen; kontrollera din installation. Misslyckades att hämta xauth-nyckeln: xauth-binären hittades inte på de vanliga platserna Tvinga fångst av tangentbord och mus Fånga tangentbord och mus även om -g har angivits som argument på kommandoraden. Tilldelar rättigheter Nyckelring till vilken lösenord kommer att sparas Använder inte låsning för NFS-monterade låsfilen %s Använder inte låsning för skrivskyddade läsfilen %s Lösenordsfråga avbröts. Lösenord: Lösenord:  Rättighetstilldelning Fråga för fångst Kom ihåg lösenord Spara för den här sessionen Spara i nyckelringen Spara lösenord i gnome-keyring Sudo-läge Kommandot gksu-run-helper hittades inte eller är inte startbart. Namnet på nyckelringen som gksu ska använda. Vanliga värden är "session", vilket sparar lösenordet för sessionen, och "default" som sparar lösenordet utan maximal tidsgräns. Den underliggande auktoriseringsmekanismen (sudo) tillåter inte att du kör detta program. Kontakta systemadministratören. Det här alternativet bestämmer huruvida en meddelandedialog kommer att visas och informera användaren att programmet kör utan att behöva fråga efter ett lösenord av någon anledning. Det här alternativet kommer att göra att gksu frågar användaren om denne vill få skärmen fångad innan lösenordet matas in. Observera att det endast har effekt om force-grab är inaktivert. Kunde inte kopiera användarens Xauthorization-fil. Huruvida sudo ska vara standardbakändemetoden. Den här metoden användas annars genom flaggan -S eller genom att köra "gksudo" istället för "gksu". Huruvida fångst av tangentbordet och musen ska stängas av. Det här gör det möjligt för andra X-program att lyssna på tangentbordsinmatningshändelser, vilket gör det inte är möjligt att skydda sig mot ondsinta program som kan vara igång. Fick fel lösenord från nyckelringen. Fel lösenord. _Autentiseringsläge: _Fångstläge: aktivera
inaktivera
tvinga aktivering
fråga
 gksu kan spara lösenordet som du anger i gnome-keyring så att du inte kommer att bli tillfrågad varje gång det används gksu_run behöver ett kommando att köra men inget angavs. gksu_sudo_run behöver ett kommando att köra men inget angavs. gtk-close su
sudo su avslutades med status %d sudo avslutades med status %d 