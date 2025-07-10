# Mis tips en Debian GNU/Linux

En mi búsqueda por el ancho y basto oceano de internet por mejorar mi configuración en **Debian GNU/Linux**, encontré unos tips que me resultaron muy útiles y decidí compartirlos por si a alguien más le sirven.

<!--more-->

Estaba buscando cómo mejorar la configuración de mi editor, **Geany**, tras intentar usar [neoVim](/2022-12-19-cambiando-de-editor-neovim). Ya sabia de antemano que **NeoVim** podría ser complicado, su usabilidad me hizo perder más tiempo del necesario, algo que con **Geany** no ocurre, ya que me permite enfocarme en escribir sin distracciones.

Vi este primero [video](https://www.youtube.com/watch?v=EuwAf_qVj14) junto con este otro [video](https://www.youtube.com/watch?v=ZZGKICzIuzQ9) de [JustAGuy](https://www.youtube.com/@JustAGuyLinux) sobre la configuración que el usa para **Geany**, los cuales me parecieron muy interesantes. Probé sus sugerencias y, hasta ahora, estoy satisfecho con los resultados. Además, en uno de los [videos](https://www.youtube.com/watch?v=a_Ktv679xD0) encontré algunos TIPS para el archivo `.bashrc` que, en mi opinión, facilitan el uso de **Debian GNU/Linux**.

Recomiendo echar un vistazo a estos recursos si queréis optimizar vuestro entorno de trabajo

#### .bashrc
Las mejoras que propone para este fichero son las siguientes:
```bash
# Instalación de paquetes
alias install='sudo apt install'
# Actualización del listado de paquetes
alias update='sudo apt update'
# Actualización del sistema
alias upgrade='sudo apt upgrade'
# Eliminación de paquetes que ya no se utilizan
alias autoremove='sudo apt autoremove'
# Borramos un paquete
alias purge='sudo apt purge'
# Obtenemos el espacio libre del equipo
alias df='df -h'
# Obtenemos la memoria RAM del equipo
alias free='free -h'
# Obtenemos la IP interna y externa del equipo
alias myip="hostname -I | awk '{print $1}'; curl -s ifconfig.me && echo ' external ip'"
```
En principio son cosas faciles, que podrias hacerlo directamente, pero que de esta manera, pues ahorras un par de letras y agiliza todo. Además la ultima, obtener la **IP** del equipo me ha parecido muy interesante, porque a mi me pasa muchas veces que tengo que utilizar una pagina web, del estilo de **myip** para saber cual es, y de esta manera la puedo obtener muy facilmente.

El segundo **TIP** tambien es para el archivo `.bashrc`, pero en este caso, yo lo utilizo para mis servidores porque me resulta más util, porque asi puedo diferenciar cuando estoy en mi equipo local o en mis servidores. Esta ayuda, es la siguiente:
```bash
# PS1 Customization
#PS1="\[\e[32m\]\h\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[34m\]\u\[\e[m\] \W \$ "
# Colour codes
RED="\\[\\e[1;31m\\]"
GREEN="\\[\\e[1;32m\\]"
YELLOW="\\[\\e[1;33m\\]"
BLUE="\\[\\e[1;34m\\]"
MAGENTA="\\[\\e[1;35m\\]"
CYAN="\\[\\e[1;36m\\]"
WHITE="\\[\\e[1;37m\\]"
ENDC="\\[\\e[0m\\]"

# Set a two-line prompt. If accessing via ssh include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then ssh_message="-ssh_session"; fi
PS1="${GREEN}\u ${WHITE}at ${YELLOW}\h${RED}${ssh_message} ${WHITE}in ${BLUE}\w \n${CYAN}\$${ENDC} "
```
Con esto lo que consigues, es que a la hora de conectar a traves de **SSH** con tus servidores, en la consola te aparezca lo siguiente:
```bash
user at debian-ssh_session in ~
$
```
De esta manera, es mi opinión, queda muy claro cuando estas conectado a un servidor a traves de **SSH** o cuando estas en tu equipo local, porque en mi caso, saldria de la siguiente manera:
```bash
user@debian:~$
```
Como podeis ver, la diferencia es clara, la primera ves exactamente que estas conectado a traves de una sesión de **SSH** y en la segunda no.

#### BetterFox
Este **TIP** tiene que ver más con **Firefox** que con Debian GNU/Linux, pero como este navegador, es uno de los más utilizados en el sistema del pinguino, además como el camino que esta tomando es un poco preocupante, pues han empezado a salir maneras de mejoras la funcionalidad y privacidad. Una de estas opciones, para mejorar **Firefox**, es la que podemos encontrar en [betterFox](https://github.com/yokoffing/Betterfox) y que lo descubri tambien viendo este [video](https://www.youtube.com/watch?v=JuHIwCFx34Q) y que mediante la modificación a traves de un `script` de algunas de las opciones de **about** mejora, segun su creador la velocidad y la privacidad del mismo, sin tener que renunciar a el.

{{< admonition warning >}}
Antes de continuar, te recomiendo que te guardes tu bookmark.html y los plugins que utilizas, porque si continuas, una vez que has eliminado tu perfil, inicias **Firefox** como si lo acabaras de instalar.
{{< /admonition >}}

Lo primero que tienes que hacer una vez de has descargado el `script` [user.js](https://github.com/yokoffing/Betterfox/blob/main/user.js) y es el que nos recomienda el creador del mismo, es borrar el perfil que tenemos actualmente. Mediante la siguiente instrucción `about:profiles` puedes ver tu *perfil* y donde esta ubicado. Cuando ya lo sabes, borras el directorio, que en el caso de **Debian GNU/Linux**, normalemente, lo puedes encontrar en `.mozilla/firefox`. Una vez hecho esto, vuelves a inicar el navegador e inmediatamente lo cierras. 

Mediante esta acción, consigues que te vuelva a crear un nuevo perfil, y lo que hacemos a continuación es borrar todo el contenido de este nuevo perfil y copiamos el archivo `user.js` en el directorio de nuestro perfil y volvemos a iniciar **Firefox** provocando que se cargue con la configuración de nuestro `script`.

Con esta ya podriamos dar por finalizado la *nueva configuración* de **Firefox**, pero si has leido la explicación completa que da el creador, tenemos la posibilidad ser más [restrictivos](https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening) en nuestra configuración (es lo que yo he hecho), de la siguiente manera:
```javascript
/****************************************************************************
 * START: MY OVERRIDES                                                      *
****************************************************************************/
// PREF: disable Firefox Sync
user_pref("identity.fxaccounts.enabled", false);

// PREF: disable the Firefox View tour from popping up
user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");

// PREF: disable login manager
user_pref("signon.rememberSignons", false);

// PREF: disable address and credit card manager
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

// PREF: delete all browsing data on shutdown
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
user_pref("privacy.clearOnShutdown_v2.cache", true);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);
user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", true);
user_pref("privacy.clearOnShutdown_v2.downloads", true); // [HIDDEN]
user_pref("privacy.clearOnShutdown_v2.formdata", true);

// PREF: after crashes or restarts, do not save extra session data
// such as form content, scrollbar positions, and POST data
user_pref("browser.sessionstore.privacy_level", 2);

// ESTA ULTIMA ES UNA MEJORA QUE ESTOY UTILIZANDO AHORA MISMO Y QUE ES, QUE TODAS
// LAS PAGINAS WEB LAS ABRE A TRAVES DE HTTPS SI LA WEB NO LO SOPORTA, 
// NOS AVISA PARA QUE NOSOTROS DECIDAMOS QUE HACER
user_pref("dom.security.https_only_mode", true);
// ABRE TODAS LAS PAGINAS WEB EN MODO PRIVADO
user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);
```
Una vez hayas añadido estas nuevas opciones y el el caso de que estas utilizando el *plugin* de **uBlock Origen** te recomiendo que apliques estas [modificaciones](https://github.com/yokoffing/filterlists#guidelines) para mejoras el nivel de bloqueo del mismo.

Con esto, podemos dar por finalizado este **TIP** con respecto a **Debian GNU/Linux** que siempre va bien conocer tanto para nuestra comodidad y seguridad como por las cosas nuevas que se aprende.

Espero que a vosotros os sea de tanta utilidad como ha sido para mi.
#### Referencia
- [A Better Firefox!](https://www.youtube.com/watch?v=JuHIwCFx34Q)
- [My .bashrc and the command prompt.](https://www.youtube.com/watch?v=a_Ktv679xD0)
- [Betterfox](https://github.com/yokoffing/Betterfox)
- [Recommended filters](https://github.com/yokoffing/filterlists#guidelines)

