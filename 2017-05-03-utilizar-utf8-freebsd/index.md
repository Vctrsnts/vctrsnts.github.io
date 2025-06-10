# Utilizar UTF-8 en FreeBSD

Una de las cosas que echo en falta a la hora de realizar la instalación de **FreeBSD** es poder configurar `UTF-8` en el instalador.

Al igual que muchos sistemas operativo de la familia UNIX, **FreeBSD** no viene configurado para utilizar la codificación de caracteres `UTF-8` por defecto, sin embargo esta totalmente soportado y es facilmente configurable.

<!--more-->

Para determinar el locale apropiado para nuestro lenguaje y localización es posible utilizar la herramienta `locale`, para obtener más información de su funcionamiento, con un simple `man locale` accedemos a su manual:

```bash
locale -a | grep -i utf
```

Mi **FreeBSD 11.0** posee soporte para las siguientes configuraciones regionales (no las pongo todas, pongo la primera, la que voy a utilizar y la ultima):

```bash
usuari@freebsd:~% locale -a | grep -i utf
af_ZA.UTF-8
..
..
es_ES.UTF-8
..
..
zh_TW.UTF-8
```

En mi caso, voy a utilizar `es_ES.UTF-8`.

Para determinar cual es la configuración regional actual, ejecutar simplemente `locale`:

```bash
usuari@freebsd:~% locale

LANG=
LC_CTYPE="C"
LC_COLLATE="C"
LC_TIME="C"
LC_NUMERIC="C"
LC_MONETARY="C"
LC_MESSAGES="C"
LC_ALL=
```

Se observa que se esta utilizando el locale `C/POSIC`, donde `C` y `POSIC` son `aliases`.

Por lo tanto, es necesario cambiar el locale a UTF-8, para poder visualizar correctamente los tildes y eñes. Para ello, editar el archivo `/etc/login.conf`:

```bash
root@freebsd:~# vi /etc/login.conf

:charset=UTF-8:\
:lang=es_ES.UTF-8:
```

{{< admonition tip >}}
En la ultima variable no se debe escapar el salto de linea
{{< /admonition >}}

Luego es necesario ejecutar `cap_mkdb` para regenerar la base de datos de capacidades de login:

```bash
root@freebsd:~# cap_mkdb /etc/login.conf
```

Ahora, vamos a configurar otro fichero que hace falta:

```bash
root@freebsd:~# vi /etc/profile

LANG=en_US.UTF-8;   export LANG
CHARSET=UTF-8;  export CHARSET
```

Finalmente, cerrar la sesión.

Luego de iniciar la sesión, es posible verificar la configuración regional nuevamente:

```bash
usuari@freebsd:~% locale

LANG=es_ES.UTF-8
LC_TYPE="es_ES.UTF-8"
LC_COLLATE="es_ES.UTF-8"
LC_TIME="es_ES.UTF-8"
LC_NUMERIC="es_ES.UTF-8"
LC_MONETARY="es_ES.UTF-8"
LC_MESSAGES="es_ES.UTF-8"
LC_ALL=
```
Notar como `LC_COLLATE` se mantiene en `C`.

A partir de este momento, se visualizaran correctamente los tildes y eñes en nombre de archivo, sesiones `SSH` y al escribir texto.
#### Referencia

