��    D      <  a   \      �  !   �          "  4   3     h     |  %   �     �  #   �     �  '     "   >  "   a  +   �     �     �  :   �       ;   -  *   i     �  >   �  �   �  /   �	  '   �	  2   �	  >   
  "   M
     p
      �
     �
     �
     �
     �
           ,  #   J  #   n     �     �     �     �     �          +     E     T     k  H   �  !   �     �  ;    A   H  A   �  9   �  %     6  ,  D   c  2   �     �  P   �  #   H  $   l  %   �  *   �  .   �  T     �  f  (   �           5  9   K     �  2   �  8   �  &     1   5  -   g  8   �  ,   �  '   �  =   #  %   a     �  6   �     �  A   �  1         R  F   j  �   �  7   o  8   �  6   �  J     %   b  '   �     �  !   �     �          '  !   9     [  %   w  *   �  '   �  %   �          0     L  *   e     �     �     �      �  U   �  )   S  )   }  �  �  T   �"  C   �"  :   &#  .   a#  R  �#  H   �$  4   ,%     a%  \   ~%  #   �%  *   �%  '   *&  (   R&  6   {&  Z   �&     &   ?                  1   0      6                    =             B                         -   <   A      5       ,           (          >   2   #   @   4           9      '          *      D   +   7          /       	         %   !   :                $                                 3       
       )   8                      "          ;   C   .    %1 menu entries found (%2 total). %1: missing required tag: "%2" (probably) stdin Boolean (either true or false) expected.
Found: "%1" Cannot create pipe. Cannot lock %1: %2 - Aborting. Cannot open file %1 (also tried %2).
 Cannot open file %1.
 Cannot open script %1 for reading.
 Cannot remove lockfile %1. Cannot write to lockfile %1 - Aborting. Could not change directory(%1): %2 Could not create directory(%1): %2 Dpkg is not locking dpkg status area, good. Encoding conversion error: "%1" Error reading %1.
 Execution of %1 generated no output or returned an error.
 Expected: "%1" Failed to pipe data through "%1" (pipe opened for reading). Further output (if any) will appear in %1. Identifier expected. In file "%1", at (or in the definition that ends at) line %2:
 In order to be able to create the user config file(s) for the window manager,
the above file needs to be writeable (and/or the directory needs to exist).
 Indirectly used, but not defined function: "%1" Menu entry lacks mandatory field "%1".
 Number of arguments to function %1 does not match. Other update-menus processes are already locking %1, quitting. Reading installed packages list... Reading menu-entry files in %1. Reading translation rules in %1. Running menu-methods in %1. Running method: %1 Running method: %1 --remove Running: "%1"
 Script %1 could not be executed. Script %1 received signal %2. Script %1 returned error status %2. Skipping file because of errors...
 Somewhere in input file:
 Unable to open file "%1". Unexpected character: "%1" Unexpected end of file. Unexpected end of line. Unknown compat mode: "%1" Unknown error, message=%1 Unknown error. Unknown function: "%1" Unknown identifier: "%1" Unknown install condition "%1" (currently, only "package" is supported). Unknown value for field %1="%2".
 Update-menus is run by user. Usage: update-menus [options] 
Gather packages data from the menu database and generate menus for
all programs providing menu-methods, usually window-managers.
  -d                     Output debugging messages.
  -v                     Be verbose about what is going on.
  -h, --help             This message.
  --menufilesdir=<dir>   Add <dir> to the lists of menu directories to search.
  --menumethod=<method>  Run only the menu method <method>.
  --nodefaultdirs        Disable the use of all the standard menu directories.
  --nodpkgcheck          Do not check if packages are installed.
  --remove               Remove generated menus instead.
  --stdout               Output menu list in format suitable for piping to
                         install-menu.
  --version              Output version information and exit.
 Waiting for dpkg to finish (forking to background).
(checking %1) Warning: script %1 does not provide removemenu, menu not deleted
 Warning: the string %1 did not occur in template file %2
 Zero-size argument to print function. install-menu [-vh] <menu-method>
  Read menu entries from stdin in "update-menus --stdout" format
  and generate menu files using the specified menu-method.
  Options to install-menu:
     -h --help    : this message
        --remove  : remove the menu instead of generating it.
     -v --verbose : be verbose
 install-menu: "hotkeycase" can only be "sensitive" or "insensitive"
 install-menu: %1 must be defined in menu-method %2 install-menu: %1: aborting
 install-menu: Warning: Unknown identifier `%1' on line %2 in file %3. Ignoring.
 install-menu: [supported]: name=%1
 install-menu: checking directory %1
 install-menu: creating directory %1:
 install-menu: directory %1 already exists
 install-menu: no menu-method script specified! replacewith($string, $replace, $with): $replace and $with must have the same length. Project-Id-Version: menu 2.1.19
Report-Msgid-Bugs-To: menu@packages.debian.org
POT-Creation-Date: 2007-10-05 07:30+0200
PO-Revision-Date: 1004-11-10 15:38-0300
Last-Translator: Antonio Amorim <Antonio.Amorim@fisica.fc.ul.pt>
Language-Team: Portuguese <debian-l10n-portuguese@lists.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
 %1 items de menu encontrados (%2 total). %1: falta a Tag necess�ria: "%2" (provavelmente) stdin Booleano (verdadeiro ou falso) esperado.
Encontrado: "%1" N�o foi poss�vel criar pipe. N�o foi poss�vel fazer lock em %1: %2 - Abortando. N�o foi poss�vel abrir ficheiro %1 (tamb�m tentado %2).
 N�o foi poss�vel abrir o ficheiro %1.
 N�o foi poss�vel abrir o script %1 para leitura.
 N�o foi poss�vel remover ficheiro de lock %1. N�o foi poss�vel gravar ficheiro de lock %1 - Abortando. N�o consegui mudar para o direct�rio(%1): %2 N�o consegui criar o direct�rio(%1): %2 O dpkg n�o est� fazendo lock na sua �rea de status, perfeito. A codificar o erro de convers�o: "%1" Erro ao ler %1.
 A execu��o de %1 n�o gerou sa�da ou retornou um erro.
 Esperado: "%1" Falha ao passar dados atrav�s de "%1" (pipe aberto para leitura). Sa�da adicional (caso exista) ir� aparecer em %1. Identificador esperado. No ficheiro "%1", na linha (ou na defini��o que termina na) linha %2:
 Para que seja poss�vel criar o(s) ficheiro(s) de configura��o do utilizador para o gestor de janelas,
os ficheiros acima t�m de ter permiss�o de escrita (e/ou o direct�rio tem de existir).
 Fun��o utilizada indirectamente, mas n�o definida: "%1" A entrada de menu n�o possui um campo obrigat�rio "%1".
 N�mero de argumentos para a fun��o %1 n�o corresponde. Outros processos update-menus j� est�o a falzer o lock em %1, finalizando. Lendo lista de pacotes instalados ... Lendo ficheiros de items de menu em %1. Lendo regras de tradu��o em %1. Executando m�todos de menu em %1. Executando m�todo: %1 Executando m�todo: %1 --remove A executar: "%1"
 Script %1 n�o p�de ser executado. Script %1 recebeu sinal %2. Script %1 retornou status de erro %2. Ultrapassando ficheiro devido a erros ...
 Em algum lugar no ficheiro de entrada:
 N�o � possivel abrir o ficheiro "%1". Caracter inesperado: "%1" Fim de ficheiro inesperado. Fim de linha inesperado. Modo de compatibilidade desconhecido: "%1" Erro desconhecido, mensagem=%1 Erro desconhecido. Fun��o desconhecida: "%1" Identificador desconhecido: "%1" Condi��o de instala��o desconhecida "%1" (atualmente, somente "package" � suportado). Valor desconhecido para o campo %1="%2".
 Update-menus � executado pelo utilizador. Utiliza��o: update-menus [opc��es] 
Re�ne os dados de diferentes pacotes da base de dados de menus e gera
 os menus para todos os programs que providenciam m�todos-menu, geralmente
gestores de janelas.
  -d                     Exibe mensagens de depura��o.
  -v                     Seja verboso sobre o que est� acontecendo.
  -h, --help             Esta mensagem.
  --menufilesdir=<dir>   Adiciona <dir> a lista de direct�rios de menus a 
                         serem procurados.
  --menumethod=<m�todo>  Executa somente o m�todo de menu <m�todo>.
  --nodefaultdirs        Desabilita o uso de todos os direct�rios de menu
                         padr�o.
  --nodpkgcheck          N�o verifica se os pacotes est�o instalados.
  --remove               Em alternativa remove os menus instalados.
  --stdout               Exibe lista de menu em formato utiliz�vel para enviar
                         via pipe par o install-menu.
  --version              Exibe informa��o sobre a vers�o e termina.
 Aguardando a finaliza��o di dpkg (fazendo fork para segundo plano).
(a verificar %1) Aviso: o script %1 n�o fornece removemenu, o menu n�o foi removido
 Aviso: a string %1 n�o aparece no ficheiro de template %2
 Argumento de tamanho zero para a fun��o print. install-menu [-vh] <m�todo-menu>
  Ler items de menu a partir do item padr�o no formato
  de "update-menus --stdout" e gerar ficheiros de menu utilizando
  o m�todo-menu especificado.
  Op��es para o install-menu:
     -h --help    : esta mensagem
        --remove  : elimine este menu em vez de o gerar.
     -v --verbose : seja verboso
 install-menu: "hotkeycase" pode apenas ser "sensitive" ou "insensitive"
 install-menu: %1 deve ser definido no m�todo-menu %2 install-menu: %1: abortando
 install-menu: Aviso: identificador desconhecido `%1' na linha %2 no ficheiro %3. Ignorando.
 install-menu: [supported]: nome=%1
 install-menu: A verificar o direct�rio %1
 install-menu: A criar o direct�rio %1:
 install-menu: O direct�rio %1 j� existe
 install-menu: nenhum script m�todo-menu especificado ! replacewith($string, $replace, $with): $replace e %with devem possuir o mesmo comprimento. 