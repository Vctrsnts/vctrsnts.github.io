# Mejoras en mi escritorio (i3-wm)

Después de mucho tiempo usando [i3-wm](/2020-08-06-usando-i3-wm), estaba constantemente, cambiando de wallpaper (seguramente ha más de uno le pasa), pense que habria alguna manera de hacer que cada X tiempo, el wallpaper que estoy utilizando cambiara automaticamente, de los que tengo en el directorio donde los guardo.

Así que me puse a la busqueda de como se puede hacer.

<!--more-->

Encontre unas cuantas maneras de hacer lo que yo queria :
- Primer [script](https://forum.codeselfstudy.com/t/desktop-background-switcher-for-i3wm/1044)
- Segundo [script](https://github.com/levinit/i3wm-config/blob/master/i3/wallpaper.sh)

Yo me quede con la idea del segundo script, aunque le añadi la posibilidad de enviar notificaciones al escritorio de los cambios de fondos de pantalla a través del `notify-send`.
```bash
#!/usr/bin/bash
shopt -s nullglob

if [[ -z $(which feh) ]]; then
    echo "wallpaper err: Can not found command feh." > ~/i3wm-wallpaper.err
    exit 127
fi
# DIRECTORI ON ESTAN ELS FONTS DE PANTALLA
path=~/.config/wallpapers
# TEMPS / INTERVAL ENTRE ELS CANVIS DE FONS DE PANTALLA
interval=59m
# INICI DE L'SCRIPT
cd $path
# INICIEM EL BUCLE DE L'SCRIPT
while true
do
  files=()

  for i in *.jpg *.png;
  do
    [[ -f $i ]] && files+=("$i")
  done
  range=${#files[@]}

  CURRENT_WALLPAPER="${files[RANDOM % range]}"

  CURRENT_IMAGE=$path"/"$CURRENT_WALLPAPER

  ((range)) && feh --bg-scale $CURRENT_WALLPAPER
  #
  # ENVIEM LA NOTIFICACIÓ AL SISTEMA, PERQUE ES VEGI PER PANTALLA
  #
  notify-send -i "$CURRENT_IMAGE" 'Desktop Changed' $(basename -- "$CURRENT_WALLPAPER")

  sleep $interval
done
```
El script en esencia es muy simple. Lo unico que hace, es poner en un `array` todos los archivos del directorio que le indicas donde estaran las imagenes (`wallpapers`) para que cada X minutos (`interval`) que le hayas configurado haga el cambio de fondo de pantalla y que te notifique (`notify-send`) de dicho cambio, se necesita el paquete **libnotify-bin** para que te avise del cambio.

Lo unico que queda, es configurar el fichero de configuración de `i3-wm` para que :
- Haga la carga inicial del wallpaper
- Inicie el script del cambio de wallpaper, que a su vez, tomara el control y que cada X tiempo (segun tengas configurado) ira realizando el cambio de fondo de pantalla.

Para que funcione, tienes que añadir lo siguiente en el fichero de configuración:
```bash
# PARA VISUALIZAR EL FONDO DE PANTALLA
exec_always --no-startup-id feh --bg-scale --no-fehbg ~/.config/wallpapers/Wallpaper_10.jpg
# AQUI ES CONFIGURA EL CANVI AUTOMATIC DEL WALLPAPER
exec --no-startup-id  ~/.config/i3/scripts/wallpaper.sh &
```

La otra modificación que he realizado, ha sido la de que en la barra de `i3-wm` (`i3block`) me informe de los paquetes que se tienen que actualizar, era una información que me gustaba tener y después de mucho buscar, encontré el [comando / instrucción](https://github.com/vivien/i3blocks-contrib) que me daba lo que necesitada.

Lo primero, necesitas el script `apt-upgrades` y descargarlo en algún sitio desde donde puedas tener acceso. En mi caso, lo he dejado en el directorio del `i3-wm/script`, que es donde tengo todos los scripts que uso para `i3-wm`.

El script en cuestión (tener en cuenta que depende de **aptitude**) hace lo siguiente :
```bash
#!/usr/bin/env bash
#
# Copyright (C) 2015 James Murphy
# Licensed under the terms of the GNU GPL v2 only.
#
# i3blocks blocklet script to display pending system upgrades

# FontAwesome refresh symbol, change if you do not want to install FontAwesome
#PENDING_SYMBOL=${PENDING_SYMBOL:-"\uf021 "}
PENDING_SYMBOL=${PENDING_SYMBOL:-""}

# By default, show both the symbol and the numbers
SYMBOL_ONLY=${SYMBOL_ONLY:-0}

# By default, show something when no upgrades are pending
ALWAYS_PRINT=${ALWAYS_PRINT:-1}

# Colors for when there is/isn't a pending upgrade
PENDING_COLOR=${PENDING_COLOR:-"#FF0000"}
NONPENDING_COLOR=${NONPENDING_COLOR:-"#FFFFFF"}

while getopts s:oc:n:Nh opt; do
    case "$opt" in
        s) PENDING_SYMBOL="$OPTARG" ;;
        o) SYMBOL_ONLY=1 ;;
        c) PENDING_COLOR="$OPTARG" ;;
        n) NONPENDING_COLOR="$OPTARG" ;;
        N) ALWAYS_PRINT=0 ;;
        h) printf \
"Usage: apt-upgrades [-s pending_symbol] [-o] [-c pending_color] [-N|-n nonpending_color] [-h]
Options:
-s\tSpecify a refresh symbol. Default: \"\\\\uf021 \"
-o\tShow refresh symbol only, but no numbers.
-c\tColor when upgrade is pending. Default:  #00FF00
-n\tColor when no upgrade is pending. Default: #FFFFFF
-N\tOnly display text if upgrade is pending (supercedes -n)
-h\tShow this help text\n" && exit 0;;
    esac
done

read upgraded new removed held < <(
aptitude full-upgrade --simulate --assume-yes |\
    grep -m1 '^[0-9]\+ packages upgraded,' |\
    tr -cd '0-9 ' |\
    tr ' ' '\n' |\
    grep '[0-9]\+' |\
    xargs echo)

if [[ $upgraded != 0 ]] || [[ $new != 0 ]] || [[ $removed != 0 ]] || [[ $held != 0 ]]; then
    color="$PENDING_COLOR"
    if [[ $SYMBOL_ONLY == 1 ]]; then
        echo -e "$PENDING_SYMBOL"
        echo -e "$PENDING_SYMBOL"
    else
        echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
        echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
    fi
    echo $color
elif [[ $ALWAYS_PRINT == 1 ]]; then
    color="$NONPENDING_COLOR"
    echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
    echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
    echo $color
fi
```
Una vez tengas el script, vamos a la configuración del archivo de `i3block.conf`:
```bash
[apt_upgrades]
command=/home/usuari/.config/i3/scripts/apt-upgrades
# l'script s'executara cada dia (el valor es refereix a minuts)
interval=1440
signal=1
label=
```
Cuando ya tenemos configurado toda la parte del usuario, solamente nos queda configurar la parte de **root** (que es el encargado de realizar el `aptitude update` para actualizar los paquetes y que a su vez, hace que el script obtenga los paquetes a actualizar.

Para eso, tenemos que hacer lo siguiente (a través de `sudo`, en mi caso):
```bash
# obtenim acces a nivell de root
usuari@debian:~#sudo -i
```
Una vez, tenemos acceso a la consola de `root` pasamos a configurar el `cron` que lo puedes hacer de la siguiente manera para evitar al maximo cualquier error posible:
```bash
usuari@debian:~#crontab -e
```
Ahora pasamos a la creación de nuestro cron:
```bash
@daily aptitude update
```
Y con este sencillo script obtenemos la siguiente información:
- Los paquetes a actualizar.
- Los nuevos paquetes que se van a instalar.
- Los paquetes que se van a eliminar.
- Los paquetes que no se actualizar.

Todo esto, claro esta, siempre que realices la actualización.

En pantalla quedaría de la siguiente manera:

![](/images/apt-upgrades.png "APT Upgrade")
#### Referencia
- [Primera versión del script](https://forum.codeselfstudy.com/t/desktop-background-switcher-for-i3wm/1044)
- [Segunda versión del script](https://github.com/levinit/i3wm-config/blob/master/i3/wallpaper.sh)
- [Modificación en el config](https://github.com/levinit/i3wm-config/blob/master/i3/config)
- [apt-upgrades](https://github.com/vivien/i3blocks-contrib)

