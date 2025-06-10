# Raspberry Pi. Cambiando el equipo

Ante la noticia de que iban a sacar una nueva [Raspberry Pi](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/?resellerType=home) con varias mejores (más vale tarde que nunca que ya hablaremos más adelante) y pense si ya era hora de cambiar mi Raspberry Pi 3b por la nueva versión.

<!--more-->

Pero cual, porque la fundación se ha liado la manta a la cabeza y ha sacado unas cuantas versiones interesantes:
- Raspberry Pi4 con 1Gb de RAM aunque esta desaparecio rapidamente. No tenia sentido
- Raspberry Pi4 con 2Gb de RAM que ahora es el nivel inicial de la familia
- Raspberry Pi4 con 4Gb de RAM, esto ya son palabras mayores
- Raspberry Pi4 con 8Gb de RAM, pero se han vuelto locos

A parte de las mejoras que han introducido, que no entrare a fondo, porque todo el mundo las sabe, pero:
- Ethernet Gigabyte. Ya era hora.
- USB3 (2 salidas)
- USB2 (2 salidas). Que no le encuentro ningun sentido, si pones USB3, pon todo igual
- 2 mini-HDMI. Si con uno hay más que suficiente, pero bueno...
- Alimentación por USB-C y una nueva fuente de alimentación con más amperaje

A parte de estas mejores (necesarias) cometieron algunos fallos de novato que no tiene perdon. No estan empezando. Llevan años con esto. Pero bueno, **errar es humano**.

Antes estas mejoras no sabia que hacer si dar el salto a por una nueva RPI o quedarme con la que tenia, aunque fuera un poco apurada con el docker (que daño ha hecho).

Pero al final me decidi a dar el salto. Y me fui a por la de 4Gb, porque asi, podria estar seguro de que no tendria problemas de rendimiento (pero con docker nunca se sabe), pero eso si, me fui a por la Raspberry Pi4 Rev 1.2, porque era la que tenia los errores de alimentación solucionados asi como una reducción en la temperatura considerable (a parte de la mejora en la firmware nueva).

Asi estamos, con una nueva RPI 4 con 4Gb de RAM y un nuevo HDD de 4Tb y los siguientes contenedores de Docker y sin despeinarse:
- [transmission](https://hub.docker.com/r/linuxserver/transmission)
- [Medusa](https://hub.docker.com/r/linuxserver/medusa)
- [Jackett](https://hub.docker.com/r/linuxserver/jackett)
- [Flexget](https://hub.docker.com/r/wiserain/flexget)
  - Aunque la base es esta, pero uso una modificada por mi.
- [Amule](https://hub.docker.com/r/synopsis8/raspberrypi3-amule)
- [Jdownloader](https://hub.docker.com/r/jaymoulin/jdownloader)
- [Calibre Web](https://hub.docker.com/r/linuxserver/calibre-web)
- [DuckDNS](https://hub.docker.com/r/linuxserver/duckdns)
  - Hay que tener en cuenta que para poder usar `DuckDns` hay que crearse una cuenta en la pagina web de ellos.
- [Traefik](https://hub.docker.com/_/traefik)
- [Navidrome](https://hub.docker.com/r/deluan/navidrome)
- [Samba](https://hub.docker.com/r/dperson/samba)

Eso si, no penseis que la antigua RPI3b que tenia la he tirado, sino que esta haciendo de mediacenter con Libreelec y con la imagen de Samba me va perfecta.
#### Referencia

