��    E      D  a   l      �  !   �          2  4   C     x     �  %   �     �  #   �       '   &  "   N  "   q  +   �     �     �  :   �     .  ;   =  *   y     �  >   �  �   �  /   �	  '   �	  2   �	  >   
  "   ]
     �
      �
     �
     �
     �
                <  #   Z  #   ~     �     �     �     �     	     !     ;     U     d     {  H   �  !   �     �  ;    A   X  A   �  9   �  %     ?   <  6  |  D   �  2   �     +  P   G  #   �  $   �  %   �  *     .   2  T   a  �  �  :   �  >   �     ,  P   E  .   �  F   �  C     0   P  J   �  E   �  T     :   g  :   �  O   �  I   -     w  e   �     �  r     `   �  .   �  s       �  [   �  c     C   l  j   �  F     -   b  7   �  ,   �     �  &         :   >   N   3   �   >   �   4    !  ,   5!  1   b!  )   �!  -   �!  /   �!  .   "  :   K"  $   �"  +   �"  7   �"  }   #  :   �#  7   �#     $  |   )  �   �)  V   *  X   g*  z   �*  �  ;+  p   -  K   �-     �-  �   �-  8   �.  3   �.  4   �.  <   -/  E   j/  q   �/     &   @                  1   0      6                    >             C                         -   =   B      5       ,           (          ?   2   #   A   4           9      '          *      E   +   7          /       	         %   !   ;      :         $                                 3       
       )   8                      "          <   D   .    %1 menu entries found (%2 total). %1: missing required tag: "%2" (probably) stdin Boolean (either true or false) expected.
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
 Zero-size argument to print function. file %1 line %2:
Discarding entry requiring missing package %3. install-menu [-vh] <menu-method>
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
 install-menu: no menu-method script specified! replacewith($string, $replace, $with): $replace and $with must have the same length. Project-Id-Version: menu 2.1.37
Report-Msgid-Bugs-To: menu@packages.debian.org
POT-Creation-Date: 2007-10-05 07:30+0200
PO-Revision-Date: 2007-10-10 21:13+0400
Last-Translator: Yuri Kozlov <kozlov.y@gmail.com>
Language-Team: Russian <debian-l10n-russian@lists.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 1.11.4
Plural-Forms:  nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);
 Найдено %1 пунктов меню (всего %2). %1: отсутствует необходимый тег: "%2" (возможно) stdin Ожидается Boolean (либо true, либо false).
Найдено: "%1" Не удалось создать канал. Невозможно заблокировать %1: %2 - Отмена. Не удалось открыть файл %1 (также и %2).
 Не удалось открыть файл %1.
 Не удалось открыть сценарий %1 на чтение.
 Невозможно удалить файл блокировки %1. Невозможно удалить файл блокировки %1 - Отмена. Невозможно сменить каталог(%1): %2 Невозможно открыть каталог(%1): %2 Dpkg не блокирует область статистики, хорошо. Ошибка при преобразовании кодировки: "%1" Ошибка чтения %1.
 Выполнение %1 завершилось без результата или с ошибкой.
 Ожидается: "%1" Ошибка передачи данных через канал "%1" (канал открыт на чтение). Дальнейший вывод (если есть) будет перенаправлен в %1. Ожидается идентификатор. В файле "%1", в строке (или в определении, которое кончается на) %2:
 Для создания пользовательских файлов конфигурации менеджера окон,
вышеуказанные файлы должны быть доступны на запись (и/или каталоги должны существовать).
 Неявное использование неопределённой функции: "%1" В записи пункта меню отсутствует необходимое поле "%1".
 Неверное число аргументов функции %1. Уже запущены другие процессы update-menus, блокирующие %1, выход. Чтение списка установленных пакетов... Чтение пунктов меню из %1. Чтение правил трансляции из %1. Запускается menu-methods из %1. Запуск метода: %1 Запуск метода: %1 --remove Запуск: "%1"
 Сценарий %1 не может быть выполнен. Сценарий %1 получил сигнал %2. Сценарий %1 вернул статус ошибки %2. Пропуск файла из-за ошибок...
 Где-то во входном файле:
 Не удалось открыть файл "%1". Неожиданный символ: "%1" Неожиданный конец файла. Неожиданный конец строки. Неизвестный compat режим: "%1" Неизвестная ошибка, сообщение=%1 Неизвестная ошибка. Неизвестная функция: "%1" Неизвестный идентификатор: "%1" Неизвестное условие установки "%1" (пока поддерживается только "package"). Неизвестное значение поля %1="%2".
 Update-menus запущен пользователем. Использование: update-menus [опции] 
Собирает данные о пакетах из базы данных меню и генерирует меню для
всех программ, которые предоставляют методы-меню, обычно это менеджеры окон.
  -d                   Выводить сообщения отладки.
  -v                   Подробно сообщать что происходит при работе.
  -h, --help           Это сообщение.
  --menufilesdir=<кат> Добавить <кат> в список поиска каталогов меню.
  --menumethod=<метод> Выполнить только указанный <метод> меню.
  --nodefaultdirs      Не использовать стандартные каталоги меню.
  --nodpkgcheck        Не проверять, установлены ли пакеты.
  --remove             Удалять, а не создавать меню.
  --stdout             Вывод списка меню в формате, пригодном для передачи
                       по каналу в install-menu.
  --version            Показать версию и закончить работу.
 Ожидание завершения работы dpkg (работа в фоновом режиме).
(проверка %1) Предупреждение: сценарий %1 не содержит функции removemenu, меню не удалено
 Внимание: строка %1 не найдена в файле шаблона %2
 В функцию print передан аргумент нулевого размера. файл %1, строка %2:
Удаляемая запись требует отсутствующего пакета %3. install-menu [-vh] <метод-меню>
  Читает записи пунктов меню из stdin в формате "update-menus --stdout"
  и генерирует файлы меню, используя указанный метод-меню.
  Опции install-menu:
     -h --help    : это сообщение
        --remove  : удалить меню, а не создавать.
     -v --verbose : выдавать подробную информацию
 install-menu: "hotkeycase" может иметь значение только "sensitive" или "insensitive"
 install-menu: %1 должен быть определён в menu-method %2 install-menu: %1: отмена
 install-menu: Внимание: Неизвестный идентификатор `%1' в строке %2 в файле %3. Игнорируется.
 install-menu: [поддерживается]: имя=%1
 install-menu: проверка каталога %1
 install-menu: создание каталога %1:
 install-menu: каталог %1 уже существует
 install-menu: не указан метод-меню сценарий! replacewith($string, $replace, $with): $replace и $with должны иметь одинаковую длину. 