# De i3WM ( X11 ) a Sway ( Wayland ) - 2

Después del primer [articulo](/2025-09-15-i3wm-sway-1), donde explicaba la preparación de mi equipo para posteriormente realizar la instalación de sway. Ahora explicare como hice lo hice.

<!--more-->

## Script de instalación
Este script, es el que se encarga de realizar la instalación completa, o mejor dicho, de todo lo necesario para que en el momento de reinicar el equipo, **sway** funcione correctamente (en mi caso ha sido asi). 

De este script, lo más importante a destacar son los paquetes que instalo:

#### 01-install-sway.sh
```bash
#
pkgs=(
  sway swaybg waybar swaylock swayidle
  mako-notifier wayland-protocols xwayland
  wofi polkitd lxpolkit git grim slurp
  nwg-look greetd gtkgreet
  thunar gvfs gvfs-backends udisks2
  pulseaudio pulseaudio-utils pamixer
  xdg-user-dirs xdg-utils pavucontrol
  curl gpg unzip
  libpam0g libseat1 fastfetch
  acpi acpid eza
  gsettings-desktop-schemas
  libnotify-bin bluez bluetooth
)

apt_install "${pkgs[@]}"

log_success "Activant servei acpid"
sudo systemctl enable acpid
```

## Configuración
Como anteriormente habia mencionado, estuve haciendo pruebas en un portatil que tenia para asi dejar afinado, lo maximo posible, todos los archivos de configuración tanto de sway, mako, waybar, bash, etc...

#### ~/.config/sway
La configuración de **sway** la gran mayoria de cosas las he aprovechado de la configuración que tenia en **i3wm**, lo unico que he añadido son unas mejoras o una mejor distribución de los archivos para en un futuro, sea más facil la modificación de los mismos.

La estructura de directorios que tengo es la siguiente:
```bash
sway/
├── config.d/
│   ├── 00-theme
│   ├── 01-inputs
│   ├── 02-workspaces
│   ├── 03-keybinding
│   ├── 04-window_rules
│   ├── 05-bar
│   ├── 06-notifications
│   ├── 07-background
│   ├── 08-idle
│   └── 09-autostart_applications
├── scripts/
│   ├── background-rotater.sh
│   ├── import-gsettngs.sh
│   └── toggle-bt.sh
└── config
```
| Elemento                             | Función                                                                              |
|--------------------------------------|--------------------------------------------------------------------------------------|
| `config.d/00-theme`                  | Define el tema visual del entorno (colores, iconos, estilo general).                 |
| `config.d/01-inputs`                 | Configura dispositivos de entrada como teclado, ratón o touchpad.                    |
| `config.d/02-workspaces`             | Establece la organización de escritorios virtuales o espacios de trabajo.            |
| `config.d/03-keybinding`             | Atajos de teclado.                                                                   |
| `config.d/04-window_rules`           | Reglas que hacen referencia a las aplicaciones (posición, tamaño, etc.).             |
| `config.d/05-bar`                    | Barra de tareas (en este caso es waybar).                                            |
| `config.d/06-notifications`          | Configuración de las notifiaciones (usamos mako).                                    |
| `config.d/07-background`             | Configuración del fondo de pantalla inicial.                                         |
| `config.d/08-idle`                   | Configuración del sistema cuando inactivo.                                           |
| `config.d/09-autostart_applications` | Configuración de las aplicaciones que se inician al iniciar sway.                    |
| `scripts/background-rotater.sh`      | Cambia el fondo de pantalla automáticamente cada cierto tiempo.                      |
| `scripts/import-gsettngs.sh`         | Importa configuraciones de GNOME desde un archivo externo usando el estilo **Nord**. |
| `scripts/toggle-bt.sh`               | Activa o desactiva el Bluetooth con un solo comando.                                 |
| `config`                             | Archivo principal con parámetros globales de configuración.                          |

Las cosas que para mi, son más importantes en la configuración de **sway** son las siguientes:
```ini
# ~/.config/sway/config

# Definimos la terminal
set $term wezterm
# Definimos la tecla especial de sway (es igual que en i3wm)
set $mod Mod4
# Definir el lanzador de aplicaciones con wofi
set $menu wofi -c ~/.config/wofi/config -s ~/.config/wofi/style.css -S drun  -i | xargs swaymsg exec --
# Incluir configuración modular (inputs, keybindings, workspaces, etc.)
include ~/.config/sway/config.d/*

# ~/.config/sway/config.d/00-theme

# se encarga de importar el tema a las aplicaciones GTK cuando se inicia sway
exec_always ~/.config/sway/scripts/import-gsettings.sh

# ~/.config/sway/config.d/01-inputs

# Layout del teclado
input * {
  xkb_layout "es"
}

# ~/.config/sway/config.d/03-keybinding

# Se crea un modulo que utilizaremos a la hora de salir del sistema
mode "power" {
  bindsym l exec swaymsg exit
  bindsym r exec systemctl reboot
  bindsym s exec systemctl poweroff

  bindsym Return mode "default"
  bindsym Escape mode "default"
}
# Manteniendo la combinación de teclas y la funcionalidad, dentro de las posibilidades de sway, tiene la misma funcionalidad que tenia en i3wm.
# Aqui te sale un pequeño mensaje, que te pide que acción quieres realizar.
bindsym $mod+Shift+e exec "swaynag \
  -t warning \
  -m '⚡ Menú de energía: [l 󰍃] Logout | [r ] Reboot | [s ] Shutdown' \
  --background '#2E3440' \
  --text '#D8DEE9' \
  --border '#88C0D0' \
  --button-background '#3B4252' \
  --button-text '#ECEFF4' \
  --button-border '#81A1C1' \
  -f 'FiraCode Nerd Font 12' \
  & swaymsg mode power"
```
Aqui podeis ver, como es el mensaje de salida del sistema
![](/images/swaynag.png "Swaynag")

#### ~/.config/waybar
![](/images/waybar.png "Waybar")

Aqui pongo la configuración que tengo actualmente de **waybar**, como podeis ver, a la izquierda tengo:
- Ethernet
- Información del equipo (CPU, RAM, HDD)
- Temperatura

En el centro tengo:
- Los espacios de trabajo, que en mi caso, los distingo por los iconos de las aplicaciones que tengo (en cada espacio, unicamente tengo una aplicación).

A la derecha, tengo:
- Icono del bluetooth
- Paquetes pendientes de actualizar
- Ficheros en la papelera
- Fecha
- Notificaciones

La estructura del directorio es la siguiente:
```bash
waybar/
├── scripts/
│   ├── bt-status.sh
│   ├── sys-resources.sh
│   ├── sys-thermal.sh
│   ├── sys-trash.sh
│   └── sys-updates.sh
├── config
└── style.css
```
| Elemento                             | Función                                                                                |
|--------------------------------------|----------------------------------------------------------------------------------------|
| `config`                             | Define las funcionalidades que tendra waybar y donde (izquierda, centro, derecha).     |
| `style.css`                          | Hoja de estilo de waybar.                                                              |
| `scripts/bt-status.sh`               | Muestra el estado del bluetooth.                                                       |
| `scripts/sys-resources.sh`           | Muestra el estado del sistema (CPU, RAM, HDD).                                         |
| `scripts/sys-thermal.sh`             | Muestra la temperatura de la CPU.                                                      |
| `scripts/sys-trash.sh`               | Muestra los archivos que hay en la papelera.                                           |
| `scripts/sys-updates.sh`             | Me muestra los paquetes que tengo que actualizar.                                      |


```json
# ~/.config/waybar/config
{
  "layer": "top",
  "position": "top",
  "height": 28,
  "spacing": 4,

  // Orden de módulos
  "modules-left": [
    "network",
    "custom/resources",
    "custom/thermal",
  ],
  "modules-center": ["sway/workspaces", "sway/mode"],
  "modules-right": [
    "custom/bluetooth",
    "custom/updates",
    "custom/trash",
    "clock",
    "tray",
    "custom/notifications"
  ]
  # Aqui vendria el codigo de cada sección que visualizo y que son "custom" (propios). Los que no vienen con el sistema como network, clock, tray
}
```
Los scripts que uso para la información que visualizo son los siguientes:
```bash
# ~/.config/waybar/scripts/bt-status.sh

# Dirección MAC de los auriculares
MAC="IDENTIFICADOR DELS AURICULARS"

# Iconos (Nerd Font / Font Awesome)
ICON_ON=""   # Bluetooth normal
ICON_OFF="󰂲"  # Bluetooth tachado

# Verifica si estan conectats o no
CONNECTED=$(bluetoothctl info "$MAC" | grep "Connected: yes")

if [ -n "$CONNECTED" ]; then
  ICON="$ICON_ON"
  CLASS="on"
  # Batería desde journalctl
  BATTERY=$(journalctl --user -n 50 | grep "Battery Level" | tail -n1 | sed -n 's/.*Battery Level: \([0-9]\+\)%.*/\1/p')
  # Volumen actual
  VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n1)
  # VISUALIZACION DE INFORMACION EN EL TOOLTIP
  TOOLTIP="Auriculares conectados - ${BATTERY}%  ${VOLUME}"
else
  ICON="$ICON_OFF"
  CLASS="off"
  TOOLTIP="Bluetooth no conectado o apagado"
fi

# Sortida JSON para waybar
echo "{\"text\": \"$ICON\", \"tooltip\": \"$TOOLTIP\", \"class\": \"$CLASS\"}"

# ~/.config/waybar/scripts/sys-resources.sh

cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
mem=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
disk=$(df -h /home | awk 'NR==2 {print $4}')
echo " ${cpu}%   ${mem}%   ${disk}"

# ~/.config/waybar/scripts/sys-thermal.sh

# CPU temperature (°C)
temp_raw=$(cat /sys/class/hwmon/hwmon1/temp1_input 2>/dev/null)
if [[ -n "$temp_raw" ]]; then
  temp_c=$(echo "$temp_raw / 1000" | bc)
  temp_icon=""
else
  temp_c="?"
  temp_icon=""
fi

# Clase CSS si temperatura alta
if [[ "$temp_c" != "?" && "$temp_c" -ge 70 ]]; then
  class="hot"
else
  class="normal"
fi

echo "{\"text\": \"$temp_icon ${temp_c}°C\", \"class\": \"$class\"}"

# ~/.config/waybar/scripts/sys-trash.sh

trash_count=$(find ~/.local/share/Trash/files -type f 2>/dev/null | wc -l)

icon_full=""
icon_empty=""

if [ "$trash_count" -gt 0 ]; then
  text="$icon_full $trash_count"
  if [ "$trash_count" -ge 10 ]; then
    class="many-trash"
  else
    class="default"
  fi
else
  text="$icon_empty"
  class="normal"
fi

echo "{\"text\": \"$text\", \"class\": \"$class\"}"

# ~/.config/waybar/scripts/sys-updates.sh

updates=$(apt-get --just-print upgrade 2>/dev/null | grep "^Inst" | wc -l)

icon_full="󰮏"   # flecha de descarga
icon_empty="󱂱"  # flecha tachada

if [ "$updates" -gt 0 ]; then
  text="$icon_full $updates"
  if [ "$updates" -ge 10 ]; then
    class="many-updates"
  else
    class="default"
  fi
else
  text="$icon_empty"
  class="normal"
fi

echo "{\"text\": \"$text\", \"class\": \"$class\"}"
```

#### ~/.config/wofi/config
Aqui os pongo la configuración del gestor de menus, que en este caso, se encarga **wofi**:
```json
allow_images=true
image_size=32
width=800
height=1000
insensitive=true
mode=drun,run
columns=1
padding:5
lines=10
```

#### ~/.config/mako/config
**Mako** es la aplicación de notificaciones que uso. Se que se podria usar **sway-notification-center**, pero es mucha cosa, para lo que yo quiero. Algo simple y sencillo y **mako** me viene perfecto.

Aqui teneis la configuración que tengo actualmente. Lo unico que hay que tener en cuenta, es que, el tiempo que permanecen las notificaciones `default-timeout=0` para asi tenerlas activas y ser yo el que las desactive. No quita que más adelante me canse de esta funcionalidad y pongo un tiempo para su visualización, pero de momento, me gusta verlas.
```json
sort=-time
layer=overlay
background-color=#88C0D0
text-color=#2E3440
border-color=#5E81AC
border-size=2
border-radius=10
padding=10
margin=10
width=300
height=110
font=FiraCode 10
icons=1
max-icon-size=48
default-timeout=0
ignore-timeout=0

[urgency=low]
border-color=#8FBCBB

[urgency=normal]
border-color=#81A1C1

[urgency=high]
background-color=#BF616A
text-color=#ECEFF4
border-color=#BF616A
default-timeout=0
```

## Gestor de inicio de sesión
Aqui fue donde tuve muchos problemas, porque entre que **wayland** es nuevo y **sway** tambien, no hay muchos gestores de inicio de funcionen al 100%. 

Ahora es cuando todo el mundo de dice que hay miles y todos funcionan a las mil maravillas. Pues siento contradecir a toda esa gente, porque en mi caso, no fue asi.

Despues de muchas pruebas, me decidi por usar:
- [greetd](https://git.sr.ht/~kennylevinsen/greetd), que siento decir que la documentación de tiene es muy penosa 🤬.
- [gtkgreet](https://git.sr.ht/~kennylevinsen/gtkgreet), que tambien deja mucho que desear con respecto a la documentación, por no decir que es inexistente. Tuve que tirar de **Copilot** y de las *issues* del repositorio para hacerlo funcionar, pero que una vez lo tienes en funcionamiento no da ningun problema, aunque yo mejoraria alguna cosas.

La estructura del directorio es la siguiente:
```bash
/etc/greet/
├── config.toml
├── environments
├── gtkgreet.css
└── sway-config
```

| Elemento              | Función breve                        |
|-----------------------|--------------------------------------|
| `/greet/config.toml`  | Configuración de greetd              |
| `/greet/environments` | Entorno de sesión                    |
| `/greet/gtkgreet.css` | Estilos visuales de gtkgreet         |
| `/greet/sway-config`  | Acciones al iniciar o salir del sistema |

> **Notas adicionales:**
> - En `config.toml`, comenta agreety y descomenta wlgreet.

Yo lo tengo asi y me funciona perfectamente. Podeis hacer pruebas, pero con esta información, ya teneis un punto de partida por donde empezar.

#### /etc/greetd/config.toml
```toml
[terminal]
# The VT to run the greeter on. Can be "next", "current" or a number
# designating the VT.
vt = 7

# The default session, also known as the greeter.
[default_session]

# `agreety` is the bundled agetty/login-lookalike. You can replace `/bin/sh`
# with whatever you want started, such as `sway`.
#command = "/usr/sbin/agreety --cmd '${SHELL:-/bin/sh}'"
# if using wlgreet
command = "sway --config /etc/greetd/sway-config"

# The user to run the command as. The privileges this user must have depends
# on the greeter. A graphical greeter may for example require the user to be
# in the `video` group.
user = "_greetd"
```
#### /etc/greetd/environments
```ini
sway
```

#### /etc/greetd/gtkgreet.css
```css
window {
  /* si quereis usar un fondo de pantalla */
  background-image: url("file:///usr/share/backgrounds/login.jpg");
  background-size: cover;
  background-position: center;
  /* Tipografía general */
  font-family: "JetBrains Mono", monospace;
  font-size: 11pt;
  color: #D8DEE9; /* texto claro */
}

entry, button {
  background-color: #2E3440; /* Nordic base */
  color: #D8DEE9;
}

button:hover {
  background-color: #88C0D0; /* acento Nordic */
}
```

#### /etc/greetd/sway-config
```toml
exec "gtkgreet -l --style /etc/greetd/gtkgreet.css; swaymsg exit"

bindsym Mod4+Shift+e exec swaynag \
  -t warning \
  -m 'Que vols fer?' \
  -b 'Poweroff' 'systemctl poweroff' \
  -b 'Reboot' 'systemctl reboot'
```

Pues aqui llegamos al final. Podeis ver que he puesto lo basico o lo que yo creo que es lo más importante, porque si llego a poner todos los ficheros de configuración, completo, junto con las hojas de estilo (*CSS*) el articulo seria muy extenso.

Si quereis ver todos los archivos de configuración con toda la información, podeis visitar mi [gitHub](https://github.com/vctrsnts/sway) donde ahi si que los podreis ver en toda su extensión.
#### Referencia
- [Mi configuración de sway](https://github.com/Vctrsnts/sway-config)
- [Sway](https://swaywm.org)
- [greetd](https://git.sr.ht/~kennylevinsen/greetd)
- [gtkgreet](https://git.sr.ht/~kennylevinsen/gtkgreet)

