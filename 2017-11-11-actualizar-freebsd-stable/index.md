# Actualizar FreeBSD (STABLE)

Aqui va otra entrada con respecto a **FreeBSD**.

En este caso, es como se puede hacer la actualización del sistema **STABLE**, es la que estoy usando yo en estos momentos.

<!--more-->

Lo primero que tenemos que instalar el `subversion`, para hacer esto, se hace de la siguiente manera:

```bash
root@freebsd:~# pkg install subversion
```

Una vez tenemos instalado `subversion`, lo siguiente es actualizar el sistema, lo vuelvo a repetir, yo lo hago de esta manera:

Lo primero, es actualizar es el **arbol del sistema**

```bash
rootfreebsd:~# svn checkout https://svn.freebsd.org/base/stable/11 /usr/src
```

Ahora pasamos a actualizar el sistema

```bash
root@freebsd:~# svn update /usr/src
```

Esto tarda un rato, dependiendo de la velocidad que tengais.

Una vez, haya finalizado la actualización, se recomienda leer el fichero `/usr/src/UPDATING` para ver las modificaciones que comporta esta actualización y a continuación:

```bash
root@freebsd:~# cd /usr/src
root@freebsd:~# make -j4 buildworld
```

En la anterior instrucción, a mi entender, **compila / construye** el sistema, por eso, tomarlo con calma.

He puesto `-j4` porque son el numero de `CPU / CORES` que quiero que use esta instrucción. A más `cpu / cores`, más rapido ira la compilación, pero puede repercutir en la maquina, eso sois vosotros los que teneis que encontrar el punto intermedio.

Ahora, pasamos a:

```bash
root@freebsd:~# make -j4 kernel
```

Se aplica la misma norma que en la anterior instrucción.

Una vez que se ha realizado la compilación del sistema y del kernel, reiniciamos el sistema

```bash
root@freebsd:~# shutdown -r now
```

Ahora, a mi entender, actualizamos el sistema, con la siguiente instrucción :

```bash
root@freebsd:~# cd /usr/src
root@freebsd:~# make installworld
```

Cuando finalize, hacemos lo siguiente:

```bash
root@freebsd:~# mergemarster -Ui
```

Para finalizar, reiniciamos el sistema.

```bash
root@freebsd:~# shutdown -r now
```

Con esto, ya tenemos el sistema actualizado.
#### Referencia

