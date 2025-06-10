# Cambiar dinamicamente el fondo de pantalla en XFCE

Después de hacer limpieza de mi portatil (borrar ese espacio en el HD que no utilizaba para nada), he instalado de nuevo mi querido **Debian GNU/Linux**, y como estaba un poco cansado de KDE, lleno de programas que no utilizo, me decidi probar XFCE.

<!--more-->

Pero una de las pocas cosas que hecho de menos en XFCE, se que puede parecer una tonteria, pero 😉 es el cambio dinamico de wallpapers. Así que después de una busqueda por inet, encontre esta chuleta (que la pongo a continuación) como apunte para mi o por si alguien le puede servir de ayuda:
- Creamos una lista de imagenes, para ello tenemos que ir a la *configuración de escritorio* y seleccionar *Lista de Imagenes* y aqui es donde agregamos las imagenes que nosotros queremos que se visualizen.
- Probar como quedan las imagenes con el cambio dinamico mediante el comando (desde consola).

```bash
usuari@debian:~$ export DISPLAY=:0;/usr/bin/xfdesktop --reload
```

- Lo que hace es reiniciar el escritorio de XFCE, pero no vamos a estar haciendo esto cada vez que queramos cambiar el fondo de pantalla, así que ...
- Crearemos un script que insertaremos en el cron.
- Se crear un archivo donde agregamos lo siguiente y después lo guardamos:

```bash
*/5 * * * * export DISPLAY=:0;/usr/bin/xfdesktop --reload
```

- Donde `*/5` dindica el numero de minutos en que se ejecutara la instrucción.
- Lo guardamos con nuestro editor de texto preferido y lo añadimos al cron mediante la siguiente instrucción:

```bash
usuari@debian:~$ crontab archivo_creado
```

Con esto, le indicamos a `cron` que cada 5 minutos reinicie el escritorio de XFCE cambiando el fondo de pantalla. Es una funcionalidad o una manera de trabajar que nunca se me hubiese ocurrido, pero en esto consiste el software libre, si no lo encuentras siempre puedes hacerlo tu...

Bueno, espero que os sirve de ayuda
#### Referencia

