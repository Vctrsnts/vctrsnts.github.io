# USB se monta sólo como lectura

Por si a alguien le vuelve a pasar lo mismo que a mi, aquí pongo una pequeña ayuda de lo que se puede hacer antes de tirar a la basura un USB, que, cada vez que lo montas, esta como lectura...

<!--more-->

Me paso el otro dia, que al conectar el USB, este solamente estaba disponible como lectura y me era imposible grabar en el. Busque información sobre como arreglar este problema y en principio, todo lo que encontraba, era información diciendo, que el usb estaba en las ultimas... Pero después de mucho buscar, encontre una ~~[solución]()~~ que podia dar algo de luz...

En el post, se explica, que hay una aplicación llamada `dosfsck`, que sirve para comprobar la consistencia de sistemas de ficheros `FAT` en cualquier sistema basado en Unix, como **Debian GNU/Linux** y cuyas funciones son similares a las del comando chkdsk de Windows.

Los tres pasos a seguir son:
```bash
# instalar el paquete dosftool
usuari@debian:~$  sudo apt-get install dosfstools
# desmontar el disco duro externo o pendrive
usuari@debian:~$ sudo umount /dev/sdb1
# verificar y reparar la partición
usuari@debian:~$ sudo dosfsck -t -a -w /dev/sdb1
```

Con esta sencilla solución, se reparó la partición y el disco duro externo volvió a ser de lectura/escritura.

Lo que tengo que decir, es que la reparación funciono durante un par de dias... Al final lo que tenia que pasar, paso... El USB acabo en la basura... Estaba en las ultimas. Pero bueno, durante un par de dias, logre que siguiera funcionando.
#### Referencia

