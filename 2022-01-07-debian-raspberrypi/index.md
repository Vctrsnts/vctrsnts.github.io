# Raspberry Pi. Instalar Debian GNU/Linux en la Raspberry Pi 4

Cuando tienes una Raspberry Pi y ves que el **SO** recomendado es Raspberry Pi OS (antigua Raspbian), siempre me queda la cosa de no poder instalar **Debian GNU/Linux** ARM64. Pero desde que actualizaron la versión del firmware y **Debian GNU/Linux** empezo a tener versiones más estables, eso ya ha pasado a posible.

Asi que ahora voy a explicar los pasos que he hecho, en mi caso, para poder realizar y usar **Debian GNU/Linux** ARM64 en una Raspberry Pi 4 (4Gb).

<!--more-->

Antes de empezar, lo que necesitas es lo siguiente:
- Imagen ISO de [Debian GNU/Linux 11 ARM64](https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/)
- La ultima versión del [firmware UEFI para la Raspberry Pi 4](https://github.com/pftf/RPi4/releases)
- Que la **EEPROM** de nuestra Raspberry Pi este a la ultima versión. Esto ultimo, se puede saber si al iniciar la Raspberry Pi, nos aparece un codigo **QR** a la derecha de la pantalla.

![](/images/last_eeprom.png "Last EEPROM")

En el caso, del **firmware UEFI**, (100% libre) nos obliga a usar **GPT** en vez de **MBR** y tambien tenemos que usar **ESP** (EFI System Partition) en lugar de la **msftdata**.

Después de tener claro estos matices, vamos a realitzar el particionado de nuestro HDD, en mi caso, lo he realizado con GPARTED, donde todo lo que tenemos que hacer es más facil.

Los pasos a realizar son los siguientes:
- Asegurarnos que nuestra tabla de partición del HDD esta en GPT (con GPARTED, es facil realizar el cambio).
- Creamos una partición de como minimo 648Mb y la formateamos en FAT32 (más adelante, explico como reducir esta partición al minimo necesario).
- En mi caso, cree otra partición del 20Gb que es donde instalare el sistema base de **Debian GNU/Linux**
- Tambien, cree otra partición, en este caso, de 1Gb para la memoria SWAP.

Una vez, tenemos esto echo, más tarde volveremos para acabar, descomprimimos el **firmware UEFI** en la primera partición que hemos creado, la cual, sin tocar nada y sin crear ningun directorio.

Después de descomprimir el firmware, vamos a **descomprimir** la imagen ISO de **Debian GNU/Linux** en esta misma partición (por eso, hago una partición de 648Mb), para realizar podemos hacerlo de la siguiente manera:

Creamos un directorio donde montaremos nuestra imagen:
```bash
usuari@raspberry:~$ sudo mount -o loop /home/tuUsuario/imagen_debian.iso /directorio/destino
```

Una vez montado la imagen, tenemos que copiar todo el contenido de este directorio a la primera partición, incluido el directorio **.disk**:
```bash
usuari@raspberry:~$ sudo cp -r /directorio/destino /directorio/primera_particion
```

Una vez, hemos realizado esto, es lo que hice yo, porque sino, SO live (xubuntu) no me detectaba la primera partición, volvemos a nuestro GPARTED, seleccionamos la primera partición, seleccionamos los **flags** de la partición y marcamos **boot** y **esp**.

![](/images/gparted_flags.png "GParted")

Ahora, ya tenemos preparado nuestro HDD para instalar **Debian GNU/Linux**.

Procedemos a conectar el HDD a la Raspberry Pi y si todo ha ido bien, podemos ver, la pantalla de instalación de **Debian GNU/Linux** de toda la vida.

Una vez finalizada la instalación, solamente nos queda disfrutar de nuestra **Debian GNU/Linux** de toda la vida.

{{< admonition info >}}
Al finalizar la instalació, lo que yo hice, fue reducir la partición de 648Mb a 260Mb para asi, después añadir ese espacio extra a a partición del sistema. 260Mb es el minimo que (en mi caso) GPARTED no me transformaba la primera partición de **FAT32** a **FAT16**.
{{< /admonition >}}

Para llevar a cabo esto, en mi caso, borre todo lo que se habia añadido a la hora de *descomprimir* la ISO de **Debian GNU/Linux**. El *firmware UEFI* tambien lo dejo. En total todo el espacio ocupado (en mi caso) son 15.6Mb.

En el caso de tener una Raspberry Pi de 4Gb o más, el sistema esta configurado, para que solamente aproveche 3Gb de RAM, para usar toda la RAM que tenemos, tenemos que desactivar un parametro del **boot** de **UEFI**, se hace de la siguiente manera:
- Reiniciamos la Raspberry
- Accedemos a las opciones de UEFI apretando la tecla *ESC*.
- Vamos a la opción *Device Manager > Raspberry Pi Configuration > Advanced Configuration*
- **Desactivamos** la opción *Limit RAM to 3Gb*.

Con esto ya tenemos a nuestra disposición, toda la RAM de nuestro dispositivo.
#### Referencia
- [Instalación Debian buster "vainilla" en Raspberry Pi 4](https://www.wifi-libre.com/topic-1624-instalacion-debian-buster-vainilla-en-raspberry-pi-4.html)
- [Guide: Installation of *VANILLA* Debian 11 (or later) on a Raspberry Pi 4](https://forums.raspberrypi.com/viewtopic.php?t=282839)

