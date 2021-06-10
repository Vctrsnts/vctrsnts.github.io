---
layout: post
title: "Solucionar error i915 en GNU/Debian"
author: Victor
date: 2021-06-09
category: [linux]
---

Desde que GNU/Debian saco la versión del kernel 5.4 en mi portatil fue recurrente los flashes en la pantalla y el siguiente error:

```
[drm:intel_cpu_fifo_underrun_irq_handler [i915]] *ERROR* CPU pipe A FIFO underrun
```

La solución que todo el mundo me decia era eliminar el paquete del driver de *xserver-xorg-video-intel* y usar el por defecto del kernel. Pero estoy no entendia ( realmente era asi ) de como se tenia que hacer, porque si hacia eso perdia todo el X-ORG, al final en este [hilo](http://forums.debian.net/viewtopic.php?f=7&t=149472&p=737807#p737807) me indicaron que si hacia esto, solo se borraba el metapaquete de *xserver-xorg-video-all* pero nada más.

Al final di con la solución en el foro de [exDebian.org](https://exdebian.org/foro/como-solucionar-drmi965irqhandler-i915-error-cpu-pipe-fifo-underrun-solucionado).

Lo que tienes que hacer es crear ( en mi caso, me funciona ) un el siguiente fichero ``` ``` con el siguiente contenido:
```
ls etc/X11/
```

Si no aparece xorg.conf.d vas a tener que crear la carpeta
```
su
mkdir /etc/X11/xorg.conf.d
```

Y luego crear el archivo 20-intel.conf
```
su
vi /etc/X11/xorg.conf.d/20-intel.conf
```

Dentro del mismo poner el siguiente texto
```
Section "Device"
       Identifier  "Intel Graphics"
       Driver      "intel"
       Option      "AccelMethod"  "uxa"
       #Option      "AccelMethod"  "sna"
EndSection
```
Si al hacer los cambios debian no inicia desde grub elegis el inicio via reovery mode y eliminas el archivo
```
rm /etc/X11/xorg.conf.d/20-intel.conf
```

Donde indicas que siga usando el mismo driver que venia usando, lo unico que cambias es ( en palabras del post ):

*Más que eso, lo que has hecho es indicarle que use el mismo driver, modificando el método para la aceleración 3d. Intel pasó a usar el método sna por defecto en detrimento del método uxa, que es el que se venía usando. El prolema está en que sna, no siempre va bien con todas las intel, con lo que se mantuvo la posibilidad de usar uno u otro. Si la gráfica es algo vieja, es normal que uxa te de buenos resultados. Por el contrario en gráficas nuevas, sna es el que mejor funciona.*

Y con esta simple modificación, que hice hace 2 semanas, no me han vuelto a aparecer los flashes en la pantalla del portatil.

Espero que os sea de utilidad

**Referencia:**

* [Como solucionar *ERROR* CPU pipe A FIFO underrun?](https://forums.unraid.net/topic/46910-simple-podcast-downloader-script/)
* [Problems ( flash on screen ) with i915](http://forums.debian.net/viewtopic.php?f=7&t=149472)
