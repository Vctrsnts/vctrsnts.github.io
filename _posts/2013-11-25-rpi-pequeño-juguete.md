---
layout: post
title: "Raspberry Pi. Mi pequeño nuevo juguete…"
author: Victor
date: 2013-11-25
category: [raspberry,raspbian]
---

![](https://raw.githubusercontent.com/vctrsnts/vctrsnts.github.io/master/static/img/_posts/raspberrypi.jpg)

Pues nada. Desde hace un par de meses, tengo a mi disposición un nuevo juguete. La Raspberry modelo B, con las las siguientes caracteristicas:

- Un procesador ARM11 a 700 MHz
- Procesador gráfico a medida que acelera por hardware el vídeo H264 (mpeg4)
- 512 MB de memoria RAM
- 2 puertos USB
- Una salida de audio y video HDMI
- Conector de red Ethernet RJ45 (10/100 mbps)
- Entrada de corriente microUSB
- Lector de tarjetas SD

A parte, tengo los siguientes componentes para que pueda funcionar:

- Western Digital Black 640Gb.
- [Tarjeta Micro SD HC de 4Gb Kingston](http://www.kingston.com/en/flash/microsd_cards#sdc10)
- [Trust Pyramid 7 Port](http://www.amazon.es/Trust-Pyramid-Port-puertos-garantia/dp/B000RAH2LS/ref=pd_cp_computers_0)

Todo los componentes que tengo, los he conseguido para que funcionasen, en principio, sin ningun problema con la Raspberry.

Con respecto al Hub, teoricamente todos tendrian que funcionar sin ningun problema, pero te aconsejan que, como minimo el usb tiene que dar 1A (en este caso, este da 2A).
En el caso de la tarjeta SD Car, en esta [pagina](http://elinux.org/RPi_SD_cards#Working_.2F_Non-working_SD_cards) podeis encontrar las tarjetas compatibles y no compatibles con la Raspberry.

Y todo esto unido con el mejor Sistema Operativo del mundo [Raspbian](http://www.raspbian.org/FrontPage). La perfecta unión entre la Raspberry + GNU/Linux Debian.

Así que empezare una serie de capitulos donde explicare mis experiencias y mi proceso de instalación que le he realizado a mi pequeño gran juguete.

Los capitulos son los siguientes:

- [Raspberry Pi. La presentación](./rpi-pequeño-juguete)
- [Raspberry Pi. Funcionamiento de la RPI](./rpi-funcionamiento-raspberry)
- [Raspberry Pi. Actualización a Jessie](./rpi-Actualizacion-jessie)
- [Raspberry Pi. Instalando Jessie-Lite](./rpi-instalando-jessie-lite)
- [Raspberry Pi. Configurando la Raspberry](./rpi-configurando-raspberry)
- [Raspberry Pi. Configurar la red](./rpi-configurar-red)
- [Raspberry Pi. Iniciar desde HD externo](./rpi-iniciar-hd-externo)
- [Raspberry Pi. Acceso a trave de SSH](./rpi-acceso-traves-ssh)
- [Raspberry Pi. Cambiando el equipo](./rpi-cambiando-equipo)
- [Raspberry Pi. Usando docker en Raspbian](./rpi-usando-docker)
- [Raspberry Pi. Instalar y configurar fail2ban](./rpi-usando-fail2ban)
- [Raspberry Pi. Haciendo copias de seguridad](./rpi-copias-seguridad)
- [Raspberry Pi. Salvaguardando nuestras copias de seguridad](./rpi-externalizando-copias-seguridad)
- Raspberry Pi. Creando tu Spotify privado
- Raspberry Pi. Traefik + SSL
- Raspberry Pi. Cambiando Traefik por Nginx-Proxy-Manager
- Raspberry Pi. Al final nos quedamos con Caddy
