# Raspberry Pi. Configurando la Raspberry

Después de la instalación viene la configuración y en mi caso hice lo siguiente.

<!--more-->

Acceder al sistema introduciendo el usuario y password. Los datos son los siguientes:
```bash
usuario: pi
password: raspberrypi
```

Una vez hemos accedido al sistema, ejecutamos la siguiente instruccion:
```bash
usuari@raspberry:~$ sudo raspi-config
```

Con ello accedemos al menu de configuración inicial de la Raspberry donde podremos configurar la siguientes opciones (al lado de cada opción, viene una breve explicación de lo que hace cada una):

![](/images/raspi-config.png "Raspi Config")

En mi caso, las que he utilizado son las siguientes:
- `Expand Filesystem`: Expandir el SO para ocupar toda la SD, después nos aconseja reiniciar. Yo lo hago.
- `Change User Password`: Cambiamos el password del usuario `usuari`.
- `Enable Boot to Desktop/Scratch`: Selecciono la opción de inicio en `consola`.
- `Internationalisation Options`: Poner en castellano nuestro sistema. Yo selecciono `es_ES.UTF-8`
- `Advanced Options`: En este caso, esta la opción de cambiar el nombre de `host` de nuestra Rusuari. Yo lo hago.

Después de la configuración inicial, en mi caso, hago una actualización del `firmware` de la Raspberry mediante la siguiente instrucción:
```bash
usuari@raspberry:~$ sudo rpi-update
# en caso de que visualizes el siguiente mensaje:
usuari@raspberry:~$ Command not found
```

Te esta indicando que no tienes instalado este paquete, solamente tienes que instalarlo a traves de apt-get de la siguiente manera:
```bash
usuari@raspberry:~$ sudo apt-get install rpi-update
```

Una vez que hemos instalado el paquete, ahora si que podemos pasar a realizar la actualitzación del firmware, kernel y modulos de nuestra Raspberry.

![](/images/rpi_update.png "RPI Update")

Cuando el procedimiento de actualización ha finalizado, yo tengo por costumbre instalar los siguientes paquetes:
```bash
usuari@raspberry:~$ sudo apt-get install deborphan localepurge
```

Para que:
- `deborphan`: elimina los paquetes / librerias que han quedado huerfanas o que ya no se utilizan. Además, nos sera de mucha utilidad, cuando empezemos a eliminar paquetes que no son necesarios (esto es en mi caso).
- `localepurge`: elimina los idiomas que no se estan usando en nuestro sistema

```bash
usuari@raspberry:~$ sudo apt-get purge $(deborphan --libdevel)
```

Una vez, realizado esta mini-limpieza, lo que hago es cambiarle el password a **root**, porque no me gusta usar `sudo`, esto lo hago a traves de:
```bash
usuari@raspberry:~$ sudo passwd
```

Entonces, te pedira que pongas el nuevo password de **root**.

Después añado el usuario que voy a utilizar y borro al usuario `usuari` que viene por defecto en la instalación. Una medida más de seguridad.

Las instrucciones para realizar esta acción son las siguientes:
```bash
usuari@raspberry:~$ su -
password:

root@raspberry:~# adduser miUsuario
Adding user 'miUsuario' ...
Adding new group 'miUsuario' (1001) ...
Adding new user 'miUsuario' (1002) with group 'miUsuario'
Creating home directory '/home/miUsuario'
Copying files from '/etc/skel'
Enter new UNIX password:
Retype new UNIX password:
passwd: password update successfully
Changing the user information for miUsuario
Enter the new value, or press ENTER for the default
 Full Name []:
 Rom Number []:
 Work Phone []:
 Home Phone []:
 Oher []:
Is the information correct? [Y/n] y
```

Una vez, que ya he creado el usuario que voy a usar a partir de ahora, paso a borrar el usuario que viene por defecto. En este caso `usuari`:
```bash
usuari@raspberry:~$ su -
password:

root@raspberry:~# deluser --remove-home usuari
```

Lo que hace esta instrucción, a parte de borrar al usuari `usuari`, es borrar tambien el directorio del usuario.

Una cosa que se tambien he realizado, ha sido usar `apt-get` en vez de `aptitude`, porque se vuelve lento.

El problema es que en `aptitude` se puede deshabilitar la opción que de que te instale los paquetes **sugeridos** y / o **recomendados**.

Tambien, se pueden deshabilitar, si se crea un fichero en:
```bash
root@raspberry:~# vi /etc/apt/apt.conf.d/10norecommends

APT::Install-Recommends "false";
APT::Install-Suggets "false";
```

Con estas 2 opciones, cada vez que nosotros vayamos a realizar un:
```bash
root@raspberry:~# apt-get update && apt-get upgrade
```

Nos mostrara los paquetes recomendados y los sugeridos, pero no nos los instalara si es que no lo hacemos nosostros mismos.

Después de esto ya tenemos funcionando nuestra Raspberry. En proximos capitulos, explicaremos como [configurar la red](/2016-04-03-rpi-configurar-red) (porque por lo visto en **Jessie** es diferente) y más cosas que explicare.

Hasta la proxima...
#### Referencia

