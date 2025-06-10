# Historia del cambio de terminal

Este es un articulo, que como puedes ver, es un articulo muy parecido a los que he ha escrito **Lorenzo**, de [Atareao](https://atareao.es), porque es algo, que si te pones a pensar es una de las aplicaciones que más se utilizan en *GNU/Linux* pero a la que no se le da mucha importacia.

Nos estamos refiriendo a la terminal.

<!--more-->

Esa aplicación, en mi caso, no era una cosa a la que le diera mucha importancia. Siempre usaba la que venia por defecto en el *Desktop* que instalaba en ese momento, *konsole* en el caso de **KDE**, *xfce4-terminal* en el caso de **XFCE**, o sino en el caso de usar los *Windows Tiling Manager* que el mejor ejemplo, se podria decir que es **i3-WM**, tambien usaba *xfce4-terminal*. Pero al usar los que venian por defecto, siempre, en mi caso, me encontraba un poco limitado porque si quieres trabajar con diferentes *paneles* o *escritorios*, tienes que usar diferentes pestañas y tienes que ir saltando de pestaña en pestaña y eso era un poco rollo.

Pero todo cambio, a partir de un [video](https://www.youtube.com/watch?v=7gmpjacFoHM) del **PeladoNerd** donde explicaba el uso de **TMUX**. Un famoso *multiplexor* donde podias tener varios *terminales* en la misma ventana. 

Esto era una mejora en mi manera de trabajar con respecto a lo que tenia antes. Pero aun habia un pequeño problema que seguia existiendo, que aunque habia logrado una mejora muy sustancial con respecto a lo que tenia antes, tenia que seguir utilizando 2 aplicaciones:
- La terminal que habia instalado.
- *Tmux* para disponer de estas mejoras.

Aqui os pongo la configuración del fichero `tmux.conf` que estaba usando en ese momento. Nunca se sabe si os puede ser de utilidad:
```bash
### Configuració per defecte
set -g assume-paste-time 0
# Iniciem les pestanyes de TMUX per 1 en comptes de 0
set -g base-index 1
setw -g main-pane-width 126
#setw -g aggressive-resize off
set -g status on
set -g history-limit 10000
#set -g pane-border-format "#P: #{pane_current_command}"
set -g mouse on

### Canviem la keybind per defecte
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# custom bindings
bind-key H resize-pane -L 5
bind-key L resize-pane -R 5
bind-key j select-pane -t :.-
bind-key x swap-pane -t :.0 \; select-pane -t :.0
bind-key k kill-pane \; select-layout main-vertical
bind-key v split-window -v \; select-layout main-vertical \; swap-pane -t :.0 \; select-pane -t :.0
# EXECUTEM SCRIPT
bind-key r run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-vertical -p 60"
### Configuracio de diferents accions programades
# Es recarrega la configuració de tmux
bind-key R source-file ~/.tmux.conf \; display-message "Config reloaded"
# Es pasa a opcio "paste-buffer"
#bind-key p paste-buffer
# Es pasa a opció "copy-mode"
#bind-key c copy-mode

### Configuració del Status Bar
set-window-option -g window-status-format ""
set-window-option -g window-status-current-format ""

### Configuració del color del Status Bar
set-option -g status-bg colour235 #base02
set-option -g status-fg yellow #yellow

### Es visualitzar la adreça IP
set -g status-left-length 178
# Configuració per a la visualització de la adreça IP
DEFAULT_GW="$(ip route | grep 'default' | awk '{print $3}')"

set -g status-left "#[fg=green][#P] #[fg=yellow]#(ip address | grep 'enp3s0' | grep 'inet ' | awk '{print \"inet \"$2}')#[fg=red]#(ip address | grep 'wlp8s0' | grep 'inet ' | awk '{print \"inet \"$2}') #[fg=white]208.67.222.222 (#(ping -c1 208.67.222.222 | grep time | cut -f4 -d'=')) #[fg=white]#(ip route | grep 'default' | awk '{print \"gateway \"$3}') (#(ping -c1 $DEFAULT_GW | grep time | cut -f4 -d'='))"

set -g status-right-length 60
set -g status-right "#[fg=yellow]%d %b %Y #[fg=green]%H:%M"
```
Si os fijais, hay un script (que os pongo a continuación) que lo que hacia es redimensionar el tamaño del panel al de la pantalla, porque no habia forma de que esto se hiciera automaticamente:
```bash
lflag=
pflag=
tflag=
while getopts l:p:t: name;
do
    case $name in
    l)    lflag=1
      layout_name=$OPTARG;;
    p)    pflag=1
          percentage="$OPTARG";;
    t)    tflag=1
          target="$OPTARG";;
    ?)   printf "Usage: %s: [-l layout-name] [-p percentage] [-t target-window]\n" $0
          exit 2;;
    esac
done

if [ ! -z "$pflag" ]; then
    if ! [ "$percentage" -eq "$percentage" ] 2> /dev/null; then
        printf "Percentage (-p) must be an integer" >&2
        exit 1
    fi
fi
if [ ! -z "$lflag" ]; then
    if [ $layout_name != 'main-horizontal' ] && [ $layout_name != 'main-vertical' ] ; then
        printf "layout name must be main-horizontal or main-vertical" >&2
        exit 1
    fi
fi

if [ "$layout_name" = "main-vertical" ]; then
    MAIN_PANE_SIZE=$(expr $(tmux display -p '#{window_width}') \* $percentage \/ 100)
    MAIN_SIZE_OPTION='main-pane-width'

fi

if [ "$layout_name" = "main-horizontal" ]; then
    MAIN_PANE_SIZE=$(expr $(tmux display -p '#{window_height}') \* $percentage \/ 100)
    MAIN_SIZE_OPTION='main-pane-height'
fi

if [ ! -z "$target" ]; then
    tmux setw -t $target $MAIN_SIZE_OPTION $MAIN_PANE_SIZE; tmux select-layout -t $target $layout_name
else
    tmux setw $MAIN_SIZE_OPTION $MAIN_PANE_SIZE; tmux select-layout $layout_name
fi

exit 0
```
Con esta configuración estuve un monton de tiempo porque desconocia que más alla de esto habian más cosas.

Todo esto cambio, cuando descubri a [Lorenzo](https://atareao.es) donde en uno de sus [articulos](https://atareao.es/podcast/kitty-el-mejor-terminal-para-linux) explicaba que habia encontrado una nueva terminal donde todo lo que, en mi caso necesitaba, ya estaba implementado por defecto. Y esta aplicación, no era otra que [Kitty](https://sw.kovidgoyal.net/kitty). Teniendo en cuenta que las opiniones de **Lorenzo** las tengo en muy alta estima, pues decidi probar esta nueva *terminal*.

Desde el momento que la instale y la configure, aqui teneis el fichero de configuración de `kitty.conf`:
```bash
# vim:fileencoding=utf-8:ft=conf:foldmethod=marker

#: Fonts {
  font_family      Fira Code
  bold_font        auto
  italic_font      auto
  bold_italic_font auto

  font_size 10.0
#: }

#: Cursor customization {
  cursor #f19618
#: }

#: Scrollback {
  scrollback_lines 2000
#: }

#: Mouse {
  detect_urls yes

  copy_on_select yes
#: }

#: Terminal bell {
  enable_audio_bell silence
#: }

#: Window layout {
  enabled_layouts tall

  window_border_width 5.0

  window_padding_width 3.0

  hide_window_decorations no
#: }

#: Color scheme {
  foreground #e5e1cf
  background #0e1419

  background_opacity 0.8

  selection_foreground #0e1419

  selection_background #243340

  color0 #000000
  color8 #323232

  #: black

  color1 #ff3333
  color9 #ff6565

  #: red

  color2  #b8cc52
  color10 #e9fe83

  #: green

  color3  #e6c446
  color11 #fff778

  #: yellow

  color4  #36a3d9
  color12 #68d4ff

  #: blue

  color5  #f07078
  color13 #ffa3aa

  #: magenta

  color6  #95e5cb
  color14 #c7fffc

  #: cyan

  color7  #ffffff
  color15 #ffffff
#: }

#: Advanced {
  allow_remote_control yes
#: }

#: Keyboard shortcuts {
  kitty_mod ctrl+shift

  #: Clipboard {

  map kitty_mod+c copy_to_clipboard
#: }

#: Window management {
  map kitty_mod+enter new_window
#: }

#: Font sizes {
  map kitty_mod+plus      change_font_size all +2.0
  map kitty_mod+minus     change_font_size all -2.0
  map kitty_mod+backspace change_font_size all 0
#: }
```
Me encanto su funcionamiento y su facilidad de uso, eso si, después de que te hayas acostumbrado a las combinaciones de teclas que se tiene que usar, pero en mi caso, eran pocas, asi que no tuve ningun problema en adaptarme a ellas.

Pero como dice el refran, *todo lo bueno se acaba* y eso me paso. Un dia, en una actualización de *kitty*, todo dejo de funcionar. Dejar de funciona no es la palabra correcta, lo que paso, es que todo se fue a la 💩.

El problema que tenia, es que mientras lo estaba usando, me aparecian simbolos en la terminal como si se estuviera pulsando teclas aleatoriamente, sin ningun motivo, cuando esto no era asi. Podia dejar de usar el teclado y los caracteres seguian apareciendo en la pantalla.

Lo primero que hice fue borrar la configuración que tenia hasta el momento, a ver si habia habido algun cambio y por eso tenia este problema, pero todo seguia igual. Tambien borre el paquete y lo volvi a instalar, pero sin ningun cambio. 

Busque información, tanto en la web de *kitty* como en la web de *Debian GNU/Linux* para ser si alguien habia reportado este fallo. Pero lo unico que encontre es a 2 personas que si que lo habian reportado, pero en una versión anterior a la que yo estaba usando, el problema se habia solucionado, pero eso habia pasado hace un par de años. Asi que esa no era mi solución. Pues viendo los problemas que tenia, me puse a buscar otra terminal que me diera las misma cosas que habia tenido hasta ahora con *kitty* pero sin este molesto problema. 

Que hacemos cuando tienes un problema de este tipo, pues preguntas al **profesor Lorenzo**, porque el ya habia hecho una lista de todos los posibles candidatos. 

Me paso esta pagina [web](https://github.com/cdleon/awesome-terminals), que a el le habia ayudado mucho en su elección donde podias ver todas las ventajas e inconvenientes de cada opción. Al final me decidi usar [wezterm](https://github.com/wez/wezterm) que ofrecia lo mismo que *kitty*.

La unica pega que tiene es que para instalar el paquete en *Debian GNU/Linux*, tienes que [instarlo](https://wezfurlong.org/wezterm/install/linux.html#__tabbed_1_3) por fuera del sistema. Una cosa que no me gusta mucho. Tambien tienes la opción de instalarlo a traves de *AppImage*, *Flatpak*, pero para segun que aplicaciones, las prefiero tener instaladas correctamente en el sistema.

El fichero de configuración que estoy usando actualmente es el siguiente:
```lua
-- Configuración básica para WezTerm
local wezterm = require 'wezterm'
local act = wezterm.action

return {
  -- Actualiza la barra de estado cada 1 segundo
  status_update_interval = 1, 
  -- Fuente
  font = wezterm.font("Fira Code"), -- Cambia esto a la fuente que prefieras
  font_size = 10.5, -- Tamaño de la fuente
  default_cursor_style = "BlinkingBar",

  -- Ligaduras tipográficas
  font_rules = {
    {
      intensity = "Bold",
      font = wezterm.font_with_fallback({"Fira Code", "Monospace"})
    },
  },
  -- Colores
  color_scheme = "Dracula", -- Cambia esto por el esquema que más te guste

  -- Estilo de la ventana
  window_padding = {
    left = 10, -- Espaciado desde la izquierda
    right = 10, -- Espaciado desde la derecha
    top = 10, -- Espaciado superior
    bottom = 10, -- Espaciado inferior
  },

  -- Establecer el esquema de la barra de título
  window_background_opacity = 0.98, -- Opacidad de la ventana

  -- Activar ligaduras de fuentes
  use_fancy_tab_bar = true, -- Mostrar una barra de pestañas con los nombres de las pestañas
  tab_bar_at_bottom = false, -- Coloca la barra de pestañas en la parte superior (cambiar a `true` si prefieres abajo)
  hide_tab_bar_if_only_one_tab = true,

  -- Comportamiento de las pestañas
  default_prog = {"/bin/bash"}, -- Cambia por tu shell preferido (zsh, fish, etc.)

  inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.1,
  },
  
  -- Teclas de acceso rápido
  keys = {
    -- Dividir el terminal
    {key="v", mods="CTRL|SUPER", action=act{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="h", mods="CTRL|SUPER", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},

    -- Crear una nueva pestaña
    {key="t", mods="CTRL|SHIFT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},

    -- Cambiar entre pestañas
    {key="LeftArrow", mods="CTRL|SUPER", action=act{ActivatePaneDirection="Next"}},
    {key="RightArrow", mods="CTRL|SUPER", action=act{ActivatePaneDirection="Prev"}}
  },

  -- Habilitar el "scrollback" (historial de la terminal)
  scrollback_lines = 10000, -- Aumenta el número de líneas del historial de la terminal

  -- Configuración avanzada para la terminal
  window_decorations = "NONE", -- Puedes elegir entre "NONE", "TITLE", "RESIZE", etc.

  mouse_bindings = {
    {event={Up={streak=1, button="Right"}}, mods="NONE", action=wezterm.action{PasteFrom="PrimarySelection"}},
  },
}
```
Tal como yo lo tengo configurado, me funciona perfectamente para las necesidades que tengo y lo más extraño, es que no tengo los problemas con las pulsaciones fantasma que me ocurria con *kitty*, porque tambien habia pensado que el portatil se habia roto, pero claro, sino con otra terminal el problema no aparece, pues, el problema esta en *kitty*.

Aun asi, intente darle una nueva oportunidad a *kitty*, para ver si con alguna nueva actualización, se habia solucionado el problema de las pulsaciones, pero el problema seguia persistiendo. Hasta intente usar *kitty* con el fichero minimo de configuración necesario para su funcionamiento, pero ni aun asi, el error seguia.

Asi, que no me quedo otra cosa, que volver a *wezterm* que tan buen sabor de boca me habia dejado y por eso, aun lo sigo usando hasta este momento y que espero que sea para mucho tiempo.
#### Referencia
- [POR QUE LOS SRE USAN MAC ? Mis herramientas de trabajo (Parte 2)](https://www.youtube.com/watch?v=7gmpjacFoHM)
- [Tmux](https://github.com/tmux/tmux)
- [253 - Kitty, el mejor terminal para Linux](https://atareao.es/podcast/kitty-el-mejor-terminal-para-linux)
- [560 - Las aplicaciones imprescindibles en Linux en 2024](https://atareao.es/podcast/las-aplicaciones-imprescindibles-en-linux-en-2024)
- [571 - Batalla de terminales en Linux. Wezterm](https://atareao.es/podcast/batalla-de-terminales-en-linux-wezterm)
- [awesome-terminals](https://github.com/cdleon/awesome-terminals)
- [Wezterm](https://github.com/wez/wezterm)

