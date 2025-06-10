# Raspberry Pi. Instalando Jessie-Lite

Como dije en el anterior capitulo, despues de recibir mi nuevo juguete:

<!--more-->

- [Toshiba Canvio Connect II 1 TB](https://www.amazon.es/gp/product/B00TB7K8FA/ref=oh_aui_detailpage_o00_s00?ie=UTF8&amp;psc=1)

Después de ver el correcto funcionamiento de mi nuevo HD, lo primero que hice, fue formatearlo con **ext-4** y crear las particiones necesarias que iba a utilizar en la Raspberry. Pero no nos adelantemos a los acontecimientos.

Para realizar una instalación limpia, lo primero que hice fue bajarme la imagen de **Jessie-Lite** que podeis encontrar [aqui](https://www.Raspberrypi.org/downloads/raspbian). Yo escogi la `Lite`. En esta no viene ningun gestor de ventanas ni paquetes innecesarios para funcionar en modo servidor.

Una vez descargada, copie la imagen a la SD (lo hice desde mi portatil en **GNU/Linux**, supongo que para *Windows* tiene que haber alguna aplicacion que haga lo mismo):

Lo primero, es insertar la tarjeta SD y realizar la instrucción `mount` para descubrir que dispositivo es nuestra SD:
```bash
usuari@raspberry:~$ mount
```

Obtendras un listado con todos los dispositivos conectados. En mi caso, la tarjeta SD, era:
```bash
usuari@raspberry:~$ /dev/mmcblk0
```

Después de obtener esta información, solamente nos queda copiar la imagen a la SD.

{{< admonition note >}}
Hay que tener una cosa en cuenta a la hora de copiar la imagen en la SD, es que toda la información que pueda haber en la SD, se perdera
{{< /admonition >}}

La instrucción para realizar la copia (**se tiene que hacer como root**) es la siguiente:
```bash
root@raspberry:~# dd bs=4M if=2016-03-18-raspbian-jessie-lite.img of=/dev/mmcblk0
462+1 records in
463+0 records out
1941962752 bytes (1.9 GB) copied, 256.996 s, 7.6 MB/s
```

{{< admonition note >}}
Como se puede ver, a la opción bs, se le asigna el valor de 4M, esta puesto así, porque si se pone la opción 1M, el volcado de la información tardaria mucho.
{{< /admonition >}}

Esto, lo que hara, es copiar la imagen en nuestra SD, tener en cuenta, que en mi caso, estaba en el mismo directorio donde tenia la imagen, en caso contrario, tengo que poner todo el path de donde se encuentra la imagen.

Una vez se ha realizado la copia, solamente nos queda insertar la SD en nuestro RPI y a jugar...

Ahora solamente nos quedara realizar la configuración inicial y algunos cambios (que he realizado yo) que lo explicare en el siguiente capitulo.

Hasta otra...

{{< admonition info >}}
Si quereis obtener más información, podeis mirar este [link](https://elinux.org/RPi_Easy_SD_Card_Setup) donde se explica más detalladamente el proceso tanto para Linux, Windows y Mac
{{< /admonition >}}
#### Referencia
- [Creación SD de imagen Raspberry](https://elinux.org/RPi_Easy_SD_Card_Setup)

