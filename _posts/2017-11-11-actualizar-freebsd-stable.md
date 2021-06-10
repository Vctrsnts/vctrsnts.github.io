---
layout: post
title: "Actualizar FreeBSD ( Stable )"
author: Victor
date: 2017-11-11
category: [freebsd]
---

Aqui va otra entrada con respecto a **FreeBSD**.

En este caso, es como se puede hacer la actualización del sistema `STABLE`, es la que estoy usando yo en estos momentos.

Lo primero que tenemos que instalar el `subversion`, para hacer esto, se hace de la siguiente manera:

```
root@maquina:~# pkg install subversion
```

Una vez tenemos instalado `subversion`, lo siguiente es actualizar el sistema, lo vuelvo a repetir, yo lo hago de esta manera:

Lo primero, es actualizar el `el arbol del sistema`

```
rootmaquina:~# svn checkout https://svn.freebsd.org/base/stable/11 /usr/src
```

Ahora pasamos a actualizar el sistema

```
root@maquina:~# svn update /usr/src
```

Esto tarda un rato, dependiendo de la velocidad que tengais.

Una vez, haya finalizado la actualización, se recomienda leer el fichero `/usr/src/UPDATING` para ver las modificaciones que comporta esta actualización.

A continuación:

```
root@maquina:~# cd /usr/src
root@maquina:~# make -j4 buildworld
```

En la anterior instrucción, a mi entender, compila / construye el sistema, por eso, tomarlo con calma.

He puesto <ins>-j4</ins> porque son el numero de <ins>CPU / CORES</ins> que quiero que use esta instrucción. A más <ins>cpu / cores</ins>, más rapido ira la compilación, pero puede repercutir en la maquina, eso sois vosotros los que teneis que encontrar el punto intermedio.

Ahora, pasamos a:

```
root@maquina:~# make -j4 kernel
```

Se aplica la misma norma que en la anterior instrucción.

Una vez que se ha realizado la compilación del sistema y del kernel, reiniciamos el sistema

```
root@maquina:~# shutdown -r now
```

Ahora, a mi entender, actualizamos el sistema, con la siguiente instrucción :

```
root@maquina:~# cd /usr/src
root@maquina:~# make installworld
```

Cuando finalize, hacemos lo siguiente:

```
root@maquina:~# mergemarster -Ui
```

Y para finalizar, reiniciamos el sistema.

```
root@maquina:~# shutdown -r now
```

Y con esto, ya tenemos el sistema actualizado.
