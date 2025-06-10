# Recuperar Archivos en ReiserFS

A continuación explicare los pasos necesarios para recuperar un archivo/s eliminado de una partición creada con **ReiserFS**, que en principio funciona correctamente en **Debian GNU/Linux**

<!--more-->

Como root, desmonta la partición **ReiserFS** para recuperar los archivos (en este caso usaremos `/home` como ejemplo):
```bash
root@debian:/# umount /home
```

Si te muestra un mensaje parecido a `umount: /home: device is busy`, significa que algo se esta usando en dicha partición. Tendras que pasarte a modo de usuario simple (consola) o puedes usar un cdrom live:
```bash
root@debian:/# init 1
```

Se crea una copia de seguridad de la partición por si la cosa no sale del todo bien. Es mejor perder un archivo, que no toda la información:
```bash
root@debian:/# dd if=/dev/hda1 of=backup.dd bs=4096 conv=noerror
```

Recuperamos los archivos borrados pero en la particion (*backup.dd*):
```bash
root@debian:/# reiserfsck --rebuild-tree --scan-whole-partition backup.dd
```

Pasamos a crear un punto de montaje:
```bash
root@debian:/# mkdir /mnt/recovery
```

Montamos la partición virtual:
```bash
root@debian:/# mount -o loop backup.dd /mnt/recovery
```

Todos los archivos recuperados estaran en:
```bash
root@debian:/# /mnt/recovery/lost+found
```

Solamente nos queda montar la partición original y copiar los archivos de hemos recuperado.
#### Referencia

