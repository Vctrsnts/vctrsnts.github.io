# Raspberry Pi. Mi pequeño nuevo juguete

Pues nada. Desde hace un par de meses, tengo a mi disposición un nuevo juguete. La Raspberry modelo B, con las las siguientes caracteristicas:

<!--more-->

* Un procesador ARM11 a 700 MHz
* Procesador gráfico a medida que acelera por hardware el vídeo H264 (mpeg4)
* 512 MB de memoria RAM
* 2 puertos USB
* Una salida de audio y video HDMI
* Conector de red Ethernet RJ45 (10/100 mbps)
* Entrada de corriente microUSB
* Lector de tarjetas SD

![](/images/raspberrypi.jpg "Raspberry Pi")

A parte, tengo los siguientes componentes para que pueda funcionar:

* Western Digital Black 640Gb.
* [Tarjeta Micro SD HC de 4Gb Kingston](https://www.kingston.com/en/flash/microsd_cards#sdc10)
* [Trust Pyramid 7 Port](https://www.amazon.es/Trust-Pyramid-Port-puertos-garantia/dp/B000RAH2LS/ref=pd_cp_computers_0)

Todo los componentes que tengo, los he conseguido para que funcionasen, en principio, sin ningun problema con la Raspberry.

Con respecto al Hub, teoricamente todos tendrian que funcionar sin ningun problema, pero te aconsejan que, como minimo el usb tiene que dar 1A (en este caso, este da 2A).

En el caso de la tarjeta SD Car, en esta [pagina](https://elinux.org/RPi_SD_cards#Working_.2F_Non-working_SD_cards) podeis encontrar las tarjetas compatibles y no compatibles con la Raspberry.

Todo esto unido con el mejor Sistema Operativo del mundo [Raspbian](https://www.raspbian.org/FrontPage). La perfecta unión entre la Raspberry y **Debian GNU/Linux**.

Así que empezare una serie de capitulos donde explicare mis experiencias y mi proceso de instalación que le he realizado a mi pequeño gran juguete.

Los capitulos son los siguientes:

- [Raspberry Pi. La presentación](/2013-11-25-rpi-pequeño-juguete)
- [Raspberry Pi. Funcionamiento de la RPI](/2016-04-02-rpi-funcionamiento-raspberry)
- [Raspberry Pi. Actualizando a Jessie](/2016-04-02-rpi-actualizando-jessie)
- [Raspberry Pi. Instalando Jessie-Lite](/2016-04-02-rpi-instalando-jessie-lite)
- [Raspberry Pi. Configurando la Raspberry](/2016-04-02-rpi-configurando-raspberry)
- [Raspberry Pi. Configurar la red](/2016-04-03-rpi-configurar-red)
- [Raspberry Pi. Iniciar desde HD externo](/2016-04-03-rpi-iniciar-hd-externo)
- [Raspberry Pi. Acceso a trave de SSH](/2016-04-04-rpi-acceso-traves-ssh)
- [Raspberry Pi. Cambiando el equipo](/2020-10-30-rpi-cambiando-equipo)
- [Raspberry Pi. Usando docker en Raspbian](/2020-03-08-rpi-usando-docker)
- [Raspberry Pi. Instalar y configurar fail2ban](/2020-11-08-rpi-usando-fail2ban)
- [Raspberry Pi. Haciendo copias de seguridad](/2021-01-17-rpi-copias-seguridad)
- [Raspberry Pi. Salvaguardando nuestras copias de seguridad](/2021-01-18-rpi-externalizando-copias-seguridad)
- [Raspberry Pi. Creando tu Spotify privado](/2021-04-01-rpi-spotify)
- [Raspberry Pi. Cambiando Traefik por Caddy](/2021-04-08-rpi-caddy-proxy-manager)
- [Raspberry Pi. Al final nos quedamos Nginx-Proxy-Manager](/2021-05-07-rpi-nginx-proxy-manager)
- [Raspberry Pi. Cambiando de Servidor](/2022-05-26-nuevo-servidor)

{{< admonition note >}}
Como se puede observar, el ultimo articulo que he hecho con respecto a todo lo que vivido, probado, experimentado con la Raspberry es el de [cambiando de servidor](/2022-05-26-nuevo-servidor), que es cuando me paso a un Dell Optiplex 3050.
Hay que tener una cosa en cuenta, que todo lo que he escrito para la Raspberry tambien es aplicable para el Dell, porque no he tenido que hacer ninguna modificación a mis configuraciones de docker de lo que tenia en la Raspberry, para que me funcione en Dell.
{{< /admonition >}}
#### Referencia
- [RPi SD cards](https://elinux.org/RPi_SD_cards#Working_.2F_Non-working_SD_cards)

