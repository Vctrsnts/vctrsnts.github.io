---
layout: post
title: "Crear imagen ISO desde la consola de Debian"
author: Victor
date: 2014-01-03
category: [linux]
---

A veces, cuando intento realizar una ISO de un CD, no encuentro la manera de hacerlo a traves de [Xfburn](http://goodies.xfce.org/projects/applications/xfburn), aunque al final si que descubri como se tenia que hacer. Es aqui cuando me hago un lio y busco desesperadamente como se puede hacer. Pero nunca se me ocurre buscar la manera de como hacerlo a traves de consola.

Entonces, el otro dia, buscando como hacerlo por consola, encontre la siguiente chuleta de como se tiene que hacer:

```
usuari@maquina:~$ dd if=/dev/cdrom of=~/nombre_imagen.iso
```

Con esta instrucción, lo que haces, es redirigir el contenido del cdrom ( cd del cual vas a realizar la ISO ) a un fichero `nombre_imagen.iso` que será la ISO en cuestión.

Y con esta simple instrucción, se consigue realizar una ISO de un CD.

Espero que esto os ayuda tanto como a mi.

**Referencia:**

* [NickLabs](http://www.nicklabs.com.ar/?p=2867)
