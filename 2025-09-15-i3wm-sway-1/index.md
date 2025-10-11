# De i3WM ( X11 ) a Sway ( Wayland ) - 1

Como podeis leer en este [articulo](/2023-09-11-substitutos-portatil), tenia ya a mi disposición un substituto en caso de fallo grave de mi portatil que venia usando hasta ahora. Y eso es lo que ha pasado. El pobre ha pasado a mejor vida.

Como dice el refran "*el rey a muerto, viva el rey*" y esto es que el que estaba en el baquillo, ya puede salir a jugar 😂.

<!--more-->

Tengo pensado hacer una serie de 3 articulos que seran los siguientes (incluyendo este):
- [De i3WM (X11) a Sway (Wayland) - 1](/2025-09-15-i3wm-sway-1)
- [De i3WM (X11) a Sway (Wayland) - 2](/2025-10-05-i3wm-sway-2)
- [De i3WM (X11) a Sway (Wayland) - 3]()

Donde explicare todo el proceso de instalación, configuración y refinamiento hasta llegar a donde me encuentro ahora y que seguramente no sera el final, siempre puedes encontrar nuevas ideas para mejorar tu configuración.

{{< admonition note >}}
 La red es vasta e infinita - Motoko Kusanagi
{{< /admonition >}}

## Introducción
El porque de este cambio, el al 100% por fallos severos en el hardware. El teclado, USB, bateria, estaban fallando. O sea un fallo a gran escala, además del espacio que ocupaba que eso tambien era un handicap.

Pero lo que tenia claro es que para hacer el cambio tenia que seguir un par de pautas que eran inamovibles:
- Seguir usando *Debian GNU/Linux unstable*.
- Seguir usando *I3wm*
- A ser posible cambiar a *Wayland* para ir empezando a utilizar, lo que teoricamente sera el futuro.

Partiendo de estas premisas y si queria conseguirlas, tenia un problema que *I3wm* no esta pensado para funcionar en *Wayland*, si queria dar el salto, tenia que buscar una alternativa y esta me la dio, en primera instancia, como no puede ser otro **@atareo** con sus diversos [articulos](https://atareao.es/?s=sway) hablando de **sway** y sus bondandes (que no han tenido que ser muchas porque rapidamente lo abandono 😇 ) y dio el salto a otros *tiling*. Pero como bien dice el, para gustos, colores...

Pues ya teniamos una cosa más de la lista solucionada. Teniamos *Debian*, teniamos al substituto de *I3wm* y teniamos a *wayland*, pues ya lo teniamos todo, solo me faltaba instalarlo. Pero esta vez, no queria dar un salto de fe, como hice con *I3wm* en su momento y queria tenerlo todo bien preparado y que el cambio no fuera tan traumatico como lo fue con el anterior cambio.

Asi que me puse a buscar información del funcionamiento de *sway* y las opiniones que tenia la gente al respecto, y asi mirando, me encontre con un youtuber, que estoy empezando a seguir donde es uno de sus [videos](https://www.youtube.com/watch?v=sKOWqAm70jc), explicaba, que habia creado un `script` para la completa instalación y configuración de *sway*. Y como tenia un portatil, libre (**T480**), pues me decidi a probarlo. Y que quereis que os diga, me gusto como se desenvolvia tanto el script como sway. Pero claro, todo estaba configurado al gusto de **@JustAGuy Linux**. Aqui pense, si el puede hacerse un `script` para instalar sway, porque no lo puedo hacer yo y todo configurado a mi gusto. Pues me lie la manta a la cabeza y me puse a hacer mi propio script de instalación de sway, pero eso si, adaptado a mis necesidades y sobre todo con la ayuda de **Copilot**.

Dentro de estas necesidades, que seguramente alguna ya sabreis cual es:
- Instalación base de *Debian GNU/Linux unstable*.
- Instalación de *wayland*.
- Instalación de *sway*.
- Configuración de *sway* siguiendo los temas que me gustan (Nordic, Nord), o sea, temas oscuros.

### El script de preparación
Como ya he comentado, a partir de la idea que me habia visto en el video de **@JustAGuy Linux**, cree mi propio script para la instalación y configuración de **sway**. Este procedimiento, esta dividio en `3 script`, donde cada uno se encarga de una parte del proceso:
#### 00-preparacio.sh
Este es el que se encarga desde una instalación basica de *Debian GNU/Linux testing*, eliminar los paquetes que no son necesarios, procedimiento que siempre sigo después de cada instalación personal de Debian, y luego, salto a la rama **unstable** (que vengo usando desde hace unos 20 años sin ningun problema). 

Os voy a poner las partes más importantes del script para que veais un poco como va. Si quereis en script al completo o el procedimiento de instalación, lo podeis encontrar [aqui](https://github.com/Vctrsnts/debian-installer-sway)
```bash
#!/bin/bash

# 1. Desactivar la instalacion de paquetes sugeridos y recomendados
log_success "Configurando APT para evitar la instalacion de paquetes recomendados y sugeridos..."
echo 'APT::Install-Recommends "false";' | sudo tee /etc/apt/apt.conf.d/99-no-recommends.conf
echo 'APT::Install-Suggests "false";' | sudo tee -a /etc/apt/apt.conf.d/99-no-recommends.conf

# 2. Instalar localepurge (es un paquete que considero basico en cualquier instalación de Debian GNU/Linux)
log_success "Instalando localepurge para limpiar idiomas no deseados..."
sudo apt install -y localepurge

# 3. Preguntar por la version de Debian actual y modificar sources.list
read -p "Por favor, introduce el nombre de la version actual de Debian (ej. 'forky'): " current_version
log_success "Modificando /etc/apt/sources.list para apuntar a 'testing'..."
sudo sed -i "s/$current_version/testing/g" /etc/apt/sources.list

log_success "Actualizando e instalando paquetes del repositorio 'testing'..."
sudo apt -y update && sudo apt -y upgrade

# 4. Modificar sources.list para usar 'unstable' (sid) y actualizar
# Reemplaza 'testing' por 'unstable'.
sudo sed -i 's/testing/unstable/g' /etc/apt/sources.list

log_success "Actualizando e instalando paquetes del repositorio 'unstable' (full-upgrade)..."
log_success "¡ADVERTENCIA! El siguiente paso podría eliminar paquetes. Revisa la salida de la consola cuidadosamente antes de confirmar."
# Nota: Se ha quitado el flag -y para que el usuario pueda revisar los cambios.
sudo apt -y update && sudo apt -y full-upgrade

# Eliminamos paquetes conocidos, en mi caso, son estos
pkgs=(
  bluez bluetooth debian-faq debian-reference-common 
  debian-reference-es doc-debian manpages manpages-es nano 
  emacsen-common aspell aspell-es dictionaries-common 
  ispanish ispell wspanish task-spanish laptop-detect
  apt-listchanges reportbug python3-reportbug
  python3-apt distro-info-data iso-codes libpython3.13-minimal
  python3-requests python3-debian python3-charset-normalizer 
  python3-urllib3 python3-idna lsb-release python-apt-common
  python3-certifi python3-chardet python3-debconf 
  python3-debianbts python3 libpython3-stdlib python3.13
  libpython3.13-stdlib python3-minimal python3.13-minimal
)

sudo apt purge -y "${pkgs[@]}" && sudo apt -y autoremove

# =========================================================================
# Descargamos el ZIP con el resto de archivos / configuraciones necesarias
# =========================================================================
# Nombre del repositorio en formato usuario/repositorio
log_success "Iniciem la descarrega dels script"
REPO="Vctrsnts/debian-installer-sway"
ZIP_FILE="debian-installer-sway.zip"
TARGET_FOLDER="debian-installer-sway"

# Descargar el ZIP con nombre personalizado
wget -O "$ZIP_FILE" "$ZIP_URL"

log_success "Se ejecuta la actualización del funcionamiento de los sources"
sudo apt -y modernize-sources

log_success "Eliminamos aplicacion aptitude"
sudo apt purge -y aptitude w3m task-laptop task-spanish && sudo apt -y autoremove

log_success "Instalem aplicacions wireless"
sudo apt install -y iw wireless-tools wpasupplicant wireless-regdb

exit 0
```
Una vez finaliza este primer script, nos ha dejado el fichero *zip* donde esta el resto de scripts para seguir. Unicamente, nosotros tenemos que hacer un simple `unzip debian-installer-sway.zip` y listo.

Aqui lo dejamos para un siguiente articulo, porque sino, se puede extender mucho y hacerse pesado.

Hasta la proxima, donde explicare la instalación de **Wayland** junto con **Sway** y todos los paquetes que he instalado para mis necesidades.

#### Referencia
- [Sway](https://swaywm.org)
- [Sway Installation - New Script](https://www.youtube.com/watch?v=sKOWqAm70jc)
- [Build a Minimalist Linux Desktop with SwayWM – Part 1](https://www.youtube.com/watch?v=XUdu3xx6iWs)
- [Build a Minimalist Linux Desktop with SwayWM – Part 2](https://www.youtube.com/watch?v=egh43A8Tlh8)
- [Build a Minimalist Linux Desktop with SwayWM – Part 3](https://www.youtube.com/watch?v=zzPJCMl11k4)
- [Linux & Theming - The Ultimate Guide](https://www.youtube.com/watch?v=jFz5gLqv-FM)
- [How I Set Up My Sway Window Manager on Debian 12](https://www.youtube.com/watch?v=e7bezUA6G4g)

