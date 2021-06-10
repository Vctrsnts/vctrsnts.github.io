---
layout: post
title: "Recuperar Archivos en ReiserFS"
author: Victor
date: 2009-06-06
category: [linux]
---

A continuación explicare los pasos necesarios para recuperar un archivo/s eliminado de una partición creada con **ReiserFS** (en principio funciona correctamente en **GNU/Debian Linux**)

Como root, desmonta la partición **ReiserFS** para recuperar los archivos (en este caso usaremos `/home` como ejemplo):

```shell
root@maquina:/ # umount /home
```

Si te muestra un mensaje parecido a `umount: /home: device is busy`, significa que algo esta usando dicha partición. Tendras que pasarte a modo de usuario simple (consola) o puedes usar un cdrom live:
```shell
root@maquina:/ # init 1
```

Se crea una copia de seguridad de la partición por si la cosa no sale del todo bien. Es mejor perder un archivo, que no toda la información:
```shell
root@maquina:/ # dd if=/dev/hda1 of=backup.dd bs=4096 conv=noerror
```

Recuperamos los archivos borrados pero en la particion (`backup.dd`):
```shell
reiserfsck --rebuild-tree --scan-whole-partition backup.dd
```

Pasamos a crear un punto de montaje:
```shell
root@maquina:/ # mkdir /mnt/recovery
```

Montamos la partición virtual:
```shell
root@maquina:/ # mount -o loop backup.dd /mnt/recovery
```

Todos los archivos recuperados estaran en:
```shell
root@maquina:/ # /mnt/recovery/lost+found
```

Solamente nos queda montar la partición original y copiar los archivos de hemos recuperado.
