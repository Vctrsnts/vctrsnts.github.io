---
layout: post
title: "USB se monta sólo como lectura"
author: Victor
date: 2013-11-24
category: [linux]
---

Por si a alguien le vuelve a pasar lo mismo que a mi, aqui pongo una pequeña ayuda de lo que se puede hacer antes de tirar a la basura un USB, que, cada vez que lo montas, esta como lectura...

Me paso el otro dia, que al conectar el USB, este solamente estaba disponible como lectura y me era imposible grabar en el. Busque información sobre como arreglar este problema y en principio, todo lo que encontraba, era información diciendo, que el usb estaba en las ultimas... Pero después de mucho buscar, encontre una <del>[solución]()</del> que podia dar algo de luz...

En el post, se explica, que hay una aplicación llamada `dosfsck`, que sirve para comprobar la consistencia de sistemas de ficheros `FAT` en cualquier sistema basado en Unnix, como Debian y cuyas funciones son similares a las del comando chkdsk de Windows.

Los tres pasos a seguir son:

- Instalar el paquete dosftool: `sudo apt-get install dosfstools`

- Desmontar el disco duro externo (o pendrive): `sudo umount /dev/sdb1`

- Verificar y reparar la partición: `sudo dosfsck -t -a -w /dev/sdb1`

Con esta sencilla solución, se reparó la partición y el disco duro externo volvió a ser de lectura/escritura.

Lo que tengo que decir, es que la reparación funciono durante un par de dias... Al final lo que tenia que pasar, paso... Es usb acabo en la basura... Estaba en las ultimas. Pero bueno, durante un par de dias, logre que siguiera funcionando.
