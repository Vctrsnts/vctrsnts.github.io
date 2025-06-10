# Recuperando Grub

No se si os ha pasado muchas veces eso de perder el arranque de GNU/Linux ***GRUB***, pero a mi, me esta pasando muchas veces ultimamente y no se si es porque tengo mala suerte o porque tengo mal configurado el inicio entre Linux y Windows, asi que al final, me he tenido que buscar la vida, para saber como se puede solucionar, porque sino, tengo que volver a reinstalarlo todo y ahora que el sistema lo tengo como yo quiero, pues ...

<!--more-->

Las instrucciones las uso, desde ***Grub Rescue*** que es donde siempre acabo si algo me falla en el inicio del sistema y hago lo siguiente. Pero antes, mejor explicar como tengo mi sistema de archivos, para que se vea, el porque de algunas instrucciones:

```bash
sda1 --> partición EFI
sda2 --> partición del sistema Linux
sda3 --> particion HOME
sda5 --> partición Windows
```
Pues eso, que a continuación pongo las instrucciones que yo uso en mi caso, para poder recuperar el sistema (espero que os puedan servir de ayuda):
```bash
# uso gpt2, porque es donde tengo la partición del sistema de Linux
grub:> set root=(hd0,gpt2)
# ahora se indica donde se encuentra la imagen de Linux y donde la puede encontrar
grub:> linux /vmlinuz root=/dev/sda2
# ahora se indica donde se encuentra la imagen de initrd
grub:> initrd /initrd.img
# ahora iniciamos el sistema
grub:> boot
```

Una vez iniciado el sistema, solamente tenemos que acceder a la consola y volver a reconfigurar ***grub*** de la siguiente manera (en este caso lo hacemos suponiendo que tienes ***EFI***):

```bash
usuari@debian:~$sudo dpkg-reconfigure grub-efi-amd64
```

Cuando haces esto, hay que tener en cuenta, que como en mi caso, si tienes otro Sistema Operativo instalado, y quieres que ***GRUB*** te lo detecte, tienes que tener esta opción desactivada:

```bash
usuari@debian:~$sudo vi /etc/default/grub
```

```bash
GRUB_DISABLE_OS_PROBER=false
```

Con esta opción obligas a ***grub*** a detectar otros SO y me ahorre, volver a reinstalar todo mi sistema.

A veces puede pasar que no funcione. Me ha pasado alguna vez, no se el motivo de esto, pero entonces he ejecutado las siguientes instrucciones y he podido resolver el problema:

```bash
usuari@debian:~sudo grub-install
usuari@debian:~sudo update-grub
```
#### Referencia
- [How to Re-Install GRUB EFI](https://www.baeldung.com/linux/grub-efi-reinstall)

