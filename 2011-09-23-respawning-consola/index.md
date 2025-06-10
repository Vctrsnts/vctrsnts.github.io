# Error respawning en consola

No se si os ha pasado a vosotros, pero después de una instalación limpia de **Debian GNU/Linux**, siempre me aparecía en la consola (antes de instalar KDE). Al final me canse de visualizar este error **INIT: ID "co" respawning too fast: disabled for 5 minutes**, porque llega a ser cansino.
 
<!--more-->

Entonces buscando info por inet, encontre este [sitio](https://forums.debian.net/viewtopic.php?f=30&t=65460) donde salia la solución a este problema:

Se tiene que editar el fichero `/etc/inittab` y comentaremos la linea:
```bash
co:2345:respawn:/sbin/getty hvc0 9600 linux
```

dejandola de la siguiente manera :
```bash
# Lo hemos comentado para desactivarlo
# co:2345:respawn:/sbin/getty hvc0 9600 linux
```

Bueno, espero que os sirva...
#### Referencia
- [Error after installing Debian 'Testing' - INIT](https://forums.debian.net//viewtopic.php?f=30&t=65460)

