---
layout: post
title: "Raspberry Pi. Iniciar desde un HD externo"
author: Victor
date: 2016-04-03
category: [raspberry,raspbian]
---

Después de haber configurado la red, ahora pasare a explicar como extraer la información de la raiz ( `/` ) de la SD para pasarla a un HD externo y así alargar la vida de nuestra SD.

Haciendo este cambio, solamente se usara la SD en el momento del inicio, luego todo funcionara desde el HD externo. El proceso es un poco largo, pero a la larga beneficioso.

Lo primero que tenemos que hacer, es realizar una imagen de nuestra SD, tal como se encuentra ahora. Yo el proceso lo explicare bajo la premisa de que estas con Linux.

Lo primero es saber en que dispositivo esta nuestra SD cuando lo insertamos en nuestro PC, para eso, haciendo un mount, se puede ver facilmente. En mi caso es el siguiente:

```
root@maquina:~# mount
/dev/mmcblk0p1     /boot
/dev/mmcblk0p2     /
```

Lo que a nosotros nos interesa es copiar la segunda particion de la siguiente manera:

```
root@maquina:~# dd if=/dev/mmcblk0p2 of=/home/usuario/backup.img
```

Después lo que yo hice, fue crear las particiones necesarias en el HD externo.

Mi particionado, quedo de la siguiente manera ( recordar que ahora mismo se estan realizando estas acciones desde el nuestro PC, no desde la Raspberry, por eso pongo `sdb` ):

```
/dev/sdb1    /
/dev/sdb2    /home
/dev/sdb5    /media/Incoming
/dev/sdb6    /media/Temporal
/dev/sdb7    /media/Torrents
```

Una vez, tenemos creadas las particiones en nuestro HD externo, pasamos a copiar la imagen que hemos realizado anteriormente a la raiz de HD de la siguiente manera:

```
root@maquina:~# dd if=/home/usuario/backup.img of=/dev/sdb1
```

Ahora viene lo importante, que es modificar un fichero de la particion `/boot` de la SD para que cuando pongamos el HD externo conectado a la Raspberry funcione correctamente. Recordar que cuando se haga esa conexión, pasara de ser `/dev/sdb` a `/dev/sda`.
El fichero a modificar es el siguiente ( previamente hemos hecho un mount de la particion `/boot` ):

```
root@maquina:~# vi cmdline.txt
```

Y modificamos lo siguiente:

`root=/dev/mmcblk0p2`

Por

`root=/dev/sda1`

Otra cosa a tener en cuenta, es que si queremos que por defecto, se monten el resto de particiones que hemos creado, se tienen que incluir en el fichero `/etc/fstab` de la Raspberry. Yo lo he hecho de la siguiente manera:

```
root@maquina:~# vi /etc/fstab
```

Visualizaremos lo siguiente:

```
proc            /proc           proc    defaults                0       0
/dev/mmcblkp1   /boot           vfat    defaults                0       2
/dev/mmcblkp2   /               ext4    defaults,noatime        0       1
```

Y en mi caso, lo deje de la siguiente manera:

```
proc            /proc           proc    defaults                0       0
/dev/mmcblk0p1  /boot           vfat    defaults                0       2
/dev/sda1       /               ext4    defaults,noatime        0       1
/dev/sda2       /home           ext4    defaults                0       0
/dev/sda5       /media/Incoming ext4    defaults,noatime        0       0
/dev/sda6       /media/Temporal ext4    defaults,noatime        0       0
/dev/sda7       /media/Torrents ext4    defaults,noatime        0       0
```

Ahora solamente nos quedaria poner la SD en nuestra Raspberry, conectar el HD externo y todo tendria que funcionar correctamente.
