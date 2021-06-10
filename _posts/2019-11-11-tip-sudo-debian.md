---
layout: post
title: "TIP sobre SUDO en GNU/Linux"
author: Victor
date: 2019-11-11
category: [linux]
---

Después de mucho tiempo, pongo un TIP para que no se me olvide en caso de necesitarlo.

A lo mejor pongo más de uno, porque después me cuesta mucho buscarlos de nuevo. Así que aqui va el primero.

Para instalar y configurar sudo, los pasos ( los que yo utilizo ) son los siguientes:

```
root@maquina:~# apt-get install sudo
```

Una vez se ha instalado, ejecutamos: `visudo`

Esta instrucción se usa, para que en caso de trabajar con este fichero más de una persona, no se pierda la información de las modificacions que va haciendo cada usuario, por eso es recomendable, aunque tambien se puede hacer editando el fichero:

```
root@maquina:~#vi /etc/sudoers
```

La definición de este fichero es la siguiente: `nombre_usuario nombre_equipo = (usuario:grupo) comando_restringir`

1. En este caso, vamos a dar permisos a un usuario en concreto: `tu_usuario ALL=(ALL:ALL) ALL`

Lo que hace es que al usuario `tu_usuario` le damos permiso para que en cualquier equipo pueda ejecutar cualquier comando en nombre de cualquier usuario y grupo.

2. Dar permisos de root a un usuario: `tu_usuario tu_maquina=(root:root) ALL`

Lo que hacemos es dar permisos a `tu_usuario` en `tu_maquina` para ejecutar cualquier comando en nombre de `root`.

La diferencia con la instrucción de antes, es que en este caso, solo lo podra hacer en la maquina `tu_maquina` y solo lo podra hacer en nombre del usuario `root`.

3. Desactivar usuario root:

Una vez tenemos configurado sudo a nuestro gusto, en mi caso, he desactivado el acceso al usuario `root` de la siguiente manera:

### Nota: Antes de seguir adelante, se tiene que estar seguro de que todo la configuración de sudo esta correctamente, porque entonces no podremos volver atras y podriamos tener graves problemas.

Para bloquear al usuario root ejecutamos la siguiente instrucción: `sudo usermod --lock --expiredate 1979-01-01 root`

Una vez ejecutado este comando, el usuario `root` queda desactivado y todas las instrucciones se realizan a traves de sudo.

En el caso de querer reactivar al usuario `root`, tan solo tendriamos que ejecutar el siguiente comando: `sudo usermod --unlock --expiredate 99999 root`

Y el primer TIP ya esta listo.

**Referencia:**

* [Configurar SUDO](https://geekland.eu/configurar-sudo-en-linux)
