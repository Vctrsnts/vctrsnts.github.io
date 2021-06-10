---
layout: post
title: "Cambiar dinamicamente el fondo de pantalla en Xfce"
author: Victor
date: 2013-01-09
category: [linux]
---

Después de hacer limpieza de mi portatil ( borrar ese espacio en el HD que no utilizaba para nada ), he instalado de nuevo mi querido GNU/Debian, y como estaba un poco cansado de pesado, lleno de programas que no utilizo, aunque querido KDE, así que me decidi por XFCE.

Pero una de las pocas cosas que hecho de menos en XFCE, se que puede parecer una tonteria, pero ;) es el cambio dinamico de wallpapers. Así que después de una busqueda por inet, encontre esta chuleta ( que la pongo a continuación ) como apunte para mi o por si alguien le puede servir de ayuda.
- Ahora creamos una lista de imagenes, para ello tenemos que ir a la *configuración de escritorio* y seleccionar *Lista de Imagenes* y aqui es donde agregamos las imagenes que nosotros queremos que se visualizen.
- Probar como quedan las imagenes con el cambio dinamico mediante el comando ( desde consola ).

```
export DISPLAY=:0;/usr/bin/xfdesktop --reload
```

- Esto lo que hace es reiniciar el escritorio de XFCE, pero no vamos a estar haciendo esto cada vez que queramos cambiar el fondo de pantalla, así que ...
- Crearemos un script que insertaremos en el cron.
- Se crear un archivo donde agregamos lo siguiente y después lo guardamos:

```
*/5 * * * * export DISPLAY=:0;/usr/bin/xfdesktop --reload
```

- Donde `*/5` dindica el numero de minutos en que se ejecutara la instrucción.
- Lo guardamos con nuestro editor de texto preferido y lo añadimos al cron mediante la siguiente instrucción:

```
crontab archivo_creado
```

Y con esto, le indicamos al cron que cada 5 minutos reinicie el escritorio de XFCE cambiando el fondo de pantalla. Es una funcionalidad o una manera de trabajar que nunca se me hubiese ocurrido, pero en esto consiste el software libre, si no lo encuentras siempre puedes hacerlo tu...

Bueno, espero que os sirve de ayuda
