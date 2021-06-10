---
layout: post
title: "Error respawning en consola…"
author: Victor
date: 2011-09-23
category: [linux]
---

No se si hos ha pasado a vosotros, pero después de una instalación limpia de **GNU/Linux Debian**, siempre me aparecia en la consola (antes de instalar KDE). Al final me canse de visualizar este error, porque llega a ser cansino.

Entonces buscando info por inet, encontre este [sitio](http://forums.debian.net/viewtopic.php?f=30&t=65460) donde salia la solución a este problema:

Se tiene que editar el fichero `/etc/inittab` y comentaremos la linea:

```
co:2345:respawn:/sbin/getty hvc0 9600 linux
```

dejandola de la siguiente manera :

```
#co:2345:respawn:/sbin/getty hvc0 9600 linux
```

Bueno, espero que os sirva...
