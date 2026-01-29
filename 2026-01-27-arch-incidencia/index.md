# Mi primera incidencia en Arch Linux

Pensaba que iba a ser uno de los pocos elegidos que nunca iba a tener problemas con Arch Linux, pero ya os puedo decir que he dejado de ser uno, por hacer la tonteria más grande que nunca me ha pasado. Y esta ha sido borrar **SystemD** y he impidiendo que se pudiera iniciar el sistema. 

<!--more-->

Seguramente os estareis preguntando como ha podido suceder eso, pero es tan simple que he habia instalado el paquete `base-devel` y `fakeroot` y asi poder utilizar el paquete `pacman-contrib` y poder usar `checkupdates` y encuentras otra manera más facil de usarlo sin todos los paquetes que te indica el sistema y vas y te pones a eliminar paquetes como si no hubiera un mañana, pues pasa lo que pasa. Que me cargo el sistema y yo sin enterarme hasta que reinició el sistema.

Lo puedes ver, cuando se inicia el sistema y este te dice que no puede encontrar `/sbin/init` y es aqui cuando te cogen todos los sudores 😰.

Pero gracias a la IA, que para lo poco que la utilizo es para usarla como buscador de información y asi me ahorro tener que buscar en miles de paginas hasta encontrar la solución correcta, si me lo puede hacer ella, pues, eso que gano. Se que no es lo correcto, porque seguramente pierdo poder aprender más cosas, pero en este caso, queria volver a tener en funcionamiento mi sistema lo antes posible y sobre todo, evitar tener que reinstalarlo todo de nuevo. Y asi ha sido 😬

A continuación explico como he podido recuperar el sistema, por si ha alguien le puede servir de ayuda y como información para si, por si me vuelve a pasar en un futuro 🤞

Empezamos iniciando el sistema, con el *USB* de instalación de **Arch Linux**, una vez iniciado todo, tenemos que conocer las particiones que tenemos, por si no te acuerdas y esto se puede conseguir a traves de la instrucción:
```bash
usuari@archlinux:~$ lsblk -f
```
Donde visualizaremos el particionado de nuestro equipo. En mi caso tengo lo siguiente (tener en cuenta, que yo tengo el sistema instalado en un **NVME**):
```bash
usuari@archlinux:~$ lsblk -f

├─nvme0n1p1 vfat   FAT32       2060-F52D                             941.7M     8% /boot
├─nvme0n1p2 ext4   1.0         243ca655-c4dc-4b51-9941-c851ad60f059   83.3G     6% /
└─nvme0n1p3 ext4   1.0         bcb9ab01-8372-4652-97cb-b57eef626f78  330.8G     4% /home
```
Una vez tenemos esta información, recordar que estamos usando el *USB* de instalación de **Arch**, pasamos a montar el sistema:
```bash
usuari@archlinux:~$ mount /dev/nvme0n1p2 /mnt
usuari@archlinux:~$ mount /dev/nvme0n1p1 /mnt/boot
usuari@archlinux:~$ mount /dev/nvme0n1p2 /mnt/home
```
Y ahora entramos en `arch-chroot` para asi poder, siempre que se puede, instalar lo que por equivocación habia borrado:
```bash
usuari@archlinux:~$ arch-chroot /mnt
```
Con esto accedemos al **Arch** que tenemos instalado en el equipo y ahora es, si el destrozo no ha sido muy grande, tengo que decir que no ha sido nada del otro mundo, para lo que podia haber sido, procedemos a instalar los paquetes que habia eliminado por equivocación:
```bash
usuari@archlinux:~$ pacman -Syu systemd systemd-syscompat base
```
En el caso de que diera algun error, podemos obligar a que haga la instalación si o si:
```bash
usuari@archlinux:~$ pacman -Syu systemd systemd-syscompat base --overwrite
```
Ahora viene la parte donde puedes tocar el cielo o el infierno (como ha sido mi caso), verificar que existe `/sbin/init`:
```bash
usuari@archlinux:~$ ls -l /sbin/init
```
Dando como resultado, si todo ha ido bien, lo siguiente:
```bash
usuari@archlinux:~$ init -> ../lib/systemd/systemd
```
Regeneramos initramfs, cosa muy recomendable:
```bash
usuari@archlinux:~$ mkinitcpio -P
```
Salimos de `arch-chroot` y desmontados las particiones y hacemos un reboot del sistema:
```bash
usuari@archlinux:~$ exit && unmount -R /mnt && reboot
```
Aqui es donde se puede ver si todo ha ido bien 🥳 o 😭 y en mi caso si que ha sido 🥳 consiguiendo recuperar todo el sistema sin problemas y ahorrando tener que volver a reinstalar todo el sistema de nuevo.

Espero que como a mi, os pueda servir de ayuda estos apuntes, porque nunca se sabe cuando algo asi puede volver a pasar 😆
#### Referencia

