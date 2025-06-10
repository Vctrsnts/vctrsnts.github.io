# Usando i3-wm

Aqui va una nueva entrada y en este caso hace referencia a [i3wm](https://i3wm.org)

Primero un poco de historia con respecto al porque de este post. Desde hace años (cuando **KDE** se volvio tan pesado y desapareció el paquete kde-minimal) cambie a **XFCE4** y todo fue bien, hasta que vi que (en mi opinión), se habia estancado, por eso decidi hacer un cambio y hablando con gente de [exDebian](https://exdebian.org) me aconsejaron probar **i3wm**. Asi que empeze a buscar información y fue cuando encontre esta colección de 3 videos en [Youtube - i3wm](https://www.youtube.com/playlist?list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf) que me abrieron las puertas a **i3wm**

<!--more-->

Y gracias a estos videos, me puse manos a la obra. Pero como siempre me pasa, soy un culo inquieto y también me canse, aunque creo que más que cansanció fue ganas de buscar otra cosa o probar cosas nuevas. Asi que aprovechando que me compre un [SSD - Samsung Evo 860](https://www.samsung.com/semiconductor/minisite/ssd/product/consumer/860evo/) volvi a XFCE4.

Pero fue mi mayor error. Porque con el recuerdo de i3wm en la mente, queria tener la misma funcionalidad en XFCE4 y eso no podia ser (algunas cosas si, pero otras no). Hasta que me canse y he vuelto a i3wm para (en principio) quedarme con el. Asi que aqui voy a explicar todo el proceso de instalación y configuración que he usado para mi i3wm.

### 1. Instalar en Debian GNU/Linux
Es la parte más sencilla de todo el proceso y sobretodo en **Debian GNU/Linux**:

```bash
usuari@debian:~$ sudo aptitude install i3-wm i3blocks i3status
```

Con esta instrucción tan sencilla, ya tenemos los basico y necesario para usar i3-wm, ahora solo falta lanzarlo (en mi caso uso **lightdm**).

### 2. Configuración del entorno
Una vez que accedemos, nos aparece una pantalla, no os espereis una gran cosa, parece más que sea de consola, nos pide elegir el `modkey` queremos usar. En mi caso, uso la tecla de `windows` porque se  no usa para nada en caso de tener **Debian GNU/Linux**. Tambien nos da opción de usar la tecla `Alt`, aunque yo no recomiendo esta. Con este simple paso se puede decir que hemos realizado el primer paso de la configuración de `i3-wm`. Ahora viene lo más dificil (al principio lo parece, pero luego no es tanto) la configuració del resto del entorno. El fichero de configuración lo encontramos `~/.config/i3/config`

### 3. Instalar programas basicos
Para poder usar un poco más holgadamente `i3-wm` os recomiendo que instaleis las siguientes aplicaciones que os facilitaran un poco la vida:
- Obtener información sobre la bateria: `ACPI`.
- Información sobre el volumen: Yo uso `ALSA-UTILS`, aunque seguramente otro tambien sirve.
- Lanzador de aplicaciones: Puede usar el que recomienda que es `dmenu`, pero es mejor `ROFI`.
- Para el fondo de pantalla: Yo uso `FEH`.
- Para el control del sonido: Yo uso `PAVUCONTROL` y `PULSE`
- Para visualizar información de la papelera en la barra de estado: Yo uso `TRASH`, que se puede encontrar en esta [pagina](https://github.com/Anachron/i3blocks).
- Apariencia: Yo me he decantado por `LXAPPEARENCE`, es facil de usar y no necesita muchas cosas para su uso. Con el puedes configurar iconos, temas, fuentes (que hablare más adelante), etc...
- Barra de estado: Yo uso `I3BLOCK`, es facil de usar y de configurar y tiene multiples opciones.

### 4. Configurar las fuentes a usar
Una de las cosas que es util de hacer (porque no es facil) es configurar manualmente las fuentes que vas a usar. En principio son dos.
- [Font Awesome](https://github.com/FortAwesome/Font-Awesome): Para los iconos que puedes usar en la barra de estado (i3block)
- [System San Francisco](https://github.com/supermarin/YosemiteSanFranciscoFont): Que emula las letras de MACOSX y que quedan bien (aunque tu puedes usar otras).

Una vez que las hayas descargado, solamente tienes que crear un directorio `~/.fonts` donde copiaras los `ttf` que has descargado y ya estaran listos para su uso.

La segunda parte es la modificación de los siguientes ficheros para que `lxappearence` y con ello todo el sistema use las fuentes.

Estos dos ficheros son:
- `~/.gtkrc-2.0`: En la opción `gtk-font-name=` tienes que poner `"System San Francisco Display 10"`
- `~/.config/gtk-3.0`: En la opción `gtk-font-name` tienes que poner `System San Francisco Display 10`

Y con esto tendras configurado el sistema para que use esta fuente.

{{< admonition note >}}
Se podria hacer a traves de `lxappearence`, pero no detecta esta fuente y no la podras seleccionar, por eso modificamos directamente los ficheros anteriores.
{{< /admonition >}}

### Mi Escritorio
Después de la instalación y si le dedicas un poco de tiempo, te puede quedar algo parecido al mio (o mejor) eso depende del gusto de cada uno.

![](/images/screenshot_002.jpg "ScreenShot")

### Mi Configuración
A continuación, siendo la parte más interesante, la configuración, os pongo la que yo uso (que seguro que en un futuro ire mejorando) pero que os puede servir como base de inicio.
- Mi configuración de i3-wm
- Mi configuración de i3blocks

#### .config/i3/config:
```bash
# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout some time, delete
# this file and re-run i3-config-wizard(1).
#
# i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!
set $mod Mod4
#
# VARIABLES DEL SISTEMA - COLORS
#
set $bg-color            #2f343f
set $inactive-bg-color   #2f343f
set $text-color          #f3f4f5
set $inactive-text-color #676E7D
set $urgent-bg-color     #E53935
#
# VARIABLES DEL SISTEMA - COLORS PER A LES FINESTRES
#   border              background         text                 indicator
client.focused          $bg-color           $bg-color          $text-color          #00ff00
client.unfocused        $inactive-bg-color  $inactive-bg-color $inactive-text-color #00ff00
client.focused_inactive $inactive-bg-color  $inactive-bg-color $inactive-text-color #00ff00
client.urgent           $urgent-bg-color    $urgent-bg-color   $text-color          #00ff00
# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:System San Francisco Display 9
#
# VORES DE LES PANTALLES MES PRIMES
#
hide_edge_borders both
# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
# font pango:DejaVu Sans Mono 8
# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.
# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod
# start a terminal
bindsym $mod+Return exec --no-startup-id xfce4-terminal
# kill focused window
bindsym $mod+Shift+q kill
# start dmenu (a program launcher)
#bindsym $mod+d exec dmenu_run
#bindsym $mod+d exec --no-startup-id rofi -show run -theme onedark -lines 3 -eh 2 -bw 0 -bc "$bg-color" -bg "$bg-color" -fg "$text-color" -hlbg "$bg-color" -hlfg "#9575cd" -font "System San Francisco Display 12"
# AQUEST ES LA PRIMERA VERSIO
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop --dmenu='rofi -theme custom-nord -dmenu -lines 5 -eh 2 -bw 0 -font "System San Francisco Display 12" -i sort'
# EL QUE ESTIC FENT SERVIR ARA
bindsym $mod+d exec "rofi -show drun -sidebar-mode -theme custom-nord -modi drun,window,ssh -show-icons"
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop
# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+ntilde focus right
# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right
# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+ntilde move right
# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right
# split in horizontal orientation
bindsym $mod+h split h
# split in vertical orientation
bindsym $mod+v split v
# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle
# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split
# toggle tiling / floating
bindsym $mod+Shift+space floating toggle
# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle
# focus the parent container
bindsym $mod+a focus parent
# focus the child container
#bindsym $mod+d focus child
# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1: Web "
set $ws2 "2: Terminal "
set $ws3 "3: File Manager "
set $ws4 "4: Music "
set $ws5 "5: VirtualBox "
set $ws6 "6: Email "
set $ws7 "7: Filezilla "
set $ws8 "8: Calibre "
set $ws9 "9: Misc "
set $ws10 "10: Misc "
# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10
# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10
#
# ASSIGNACIÓ DAPLICACIONS A LES FINESTRES PER DEFECTE
# NECESSITES X11-UTILS, PER SAPIGER QUINA "class" I AIXI PODER CONFIGURAR AQUESTA SECCIÓ
# virtualbox (mod+winkey+v)
assign [class="Firefox" ] $ws1
assign [class="Xfce4-terminal" ] $ws2
assign [class="Thunar" ] $ws3
assign [class="Chromium" ] $ws4
assign [class="VirtualBox Manager" ] $ws5
assign [class="Claws-mail" ] $ws6
assign [class="Filezilla" ] $ws7
assign [class="calibre" ] $ws8
#
for_window [class="(?i)lxappearance" ] floating enable
for_window [title="(?i)pulseaudio multiband EQ" ] floating enable
for_window [class="(?i)pavucontrol" ] floating enable, move position mouse
for_window [class="(?i)nm-connection-editor" ] floating enable
# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"
# resize window (you can also use the mouse for that)
mode "resize" {
   # These bindings trigger as soon as you enter the resize mode
   # Pressing left will shrink the window’s width.
   # Pressing right will grow the window’s width.
   # Pressing up will shrink the window’s height.
   # Pressing down will grow the window’s height.
   bindsym j resize shrink width 10 px or 10 ppt
   bindsym k resize grow height 10 px or 10 ppt
   bindsym l resize shrink height 10 px or 10 ppt
   bindsym ntilde resize grow width 10 px or 10 ppt
   # same bindings, but for the arrow keys
   bindsym Left resize shrink width 10 px or 10 ppt
   bindsym Down resize grow height 10 px or 10 ppt
   bindsym Up resize shrink height 10 px or 10 ppt
   bindsym Right resize grow width 10 px or 10 ppt
   # back to normal: Enter or Escape or $mod+r
   bindsym Return mode "default"
   bindsym Escape mode "default"
   bindsym $mod+r mode "default"
}
bindsym $mod+r mode "resize"
# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
       status_command i3blocks -c /home/vsantos/.config/i3/i3blocks.conf
       position top
       separator_symbol ""
       colors {
               background        $bg-color
               separator         #757575
               #                  border             background         text
               focused_workspace  $bg-color          $bg-color          $text-color
               inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
               urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
       }
       font pango:Source Code Pro for Powerline, FontAwesome Regular, Icons 9
}
#
# APLICACIONS QUE SEXECUTAN A LINICI
#
# BROWSER
exec --no-startup-id firefox
for_window [class="Firefox" ] focus
# TERMINAL
exec --no-startup-id xfce4-terminal
# CORREO
exec --no-startup-id claws-mail
# CHROMIUM / MUSICA
exec --no-startup-id chromium
# GESTOR FITXER
exec --no-startup-id thunar
# GESTOR FTP
exec --no-startup-id filezilla
# VIRTUAL BOX
exec --no-startup-id virtualbox
#
# PER A CONFIGURAR LA CONNEXIO (ETHERNET / WIFI)
#
exec_always --no-startup-id nm-applet
#
# PER A BLOQUEJA LA PANTALLA
#
#bindsym $mod+shift+x exec ~/.config/scripts/lock.sh
#
# PER A VISUALITZAR ELS FONS DE PANTALLA
#
exec_always --no-startup-id feh --bg-scale --no-fehbg ~/.config/wallpapers/Wallpaper_08.jpg
#
# EXECUTAR SEMPRE COMPTON (PROGRAMA PER AL MENU)
#
exec_always --no-startup-id compton -f
#
# Pulse Audio controls
#
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound
```
  
#### .config/i3/i3blocks.conf
```bash
# i3blocks config file
#
# Please see man i3blocks for a complete reference!
# The man page is also hosted at http://vivien.github.io/i3blocks
#
# List of valid properties:
#
# align
# color
# command
# full_text
# instance
# interval
# label
# min_width
# name
# separator
# separator_block_width
# short_text
# signal
# urgent
# Global properties
#
# The top properties below are applied to every block, but can be overridden.
# Each block command defaults to the script name to avoid boilerplate.
command=/usr/share/i3blocks/$BLOCK_NAME
separator_block_width=15
markup=none
#
[volume]
label=
instance=Master
interval=1
signal=10
#
[disk]
label= home:
interval=1
#
[trash]
label=
interval=1
#
[load_average]
label=
interval=1
#
[battery]
label=⚡
interval=1
#
[time]
label=
command=date '+%d %b %H:%M'
interval=1
```
#### Referencia
- [Mi configuración I3](https://sergioquijanorey.github.io/i3/linux/programacion/administracion/2018/09/09/configuraci%C3%B3n-i3wm.html)
- [Youtube I3wm](https://www.youtube.com/playlist?list=PL5ze0DjYv5DbCv9vNEzFmP6sU7ZmkGzcf)

