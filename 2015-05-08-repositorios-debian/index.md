# Los mejores repositorios para Debian GNU/Linux

Cuando se está utilizando un sistema **Debian GNU/Linux**, una de las cosas que más se disfrutan es la herramienta para administración de paquetes `APT`.

<!--more-->

La mayoría, se pasa instalando distintos paquetes, aplicaciones, etc. aveces gastando mucho tiempo en lograr el objetivo (ej: actualizar el sistema), la mayoria de las veces provocado esto por la utilización de repositorios lentos… ¿pero como conozco los mejores repositorios para mi distro? Fácil con `apt-spy`.

**APT-SPY** es un programa usado para testear el ancho de banda de una serie de mirrors de **Debian GNU/Linux**, generando un archivo `/etc/apt/sources.list` con los servidores más rápidos. Puedes seleccionar que servidores deseas testear por localización geográfica.

Para poder usarlo, lo primero es instalarlo:
```bash
root@debian:~# aptitude install apt-spy
```

Ahora que ya lo tenemos… simplemente debemos usarlo:

Algunas de sus opciones en linea de comando son:
- `-d distribución`: Indicamos que distribución usamos, puede ser: stable, testing o unstable.
- `-e n`: Indicamos que solo pruebe los primeros n mirrors que funcionan.
- `-w archivo.list`: No sobreescribe nuestro `/etc/apt/sources.list`, en su lugar usa archivo.list.
- `-a [africa | asia | europe | north-america | oceania | south-america ]`: Identifica la localización geográfica donde buscar servidores

Como ejemplo de uso:
```bash
root@debian:~# apt-spy -d unstable -e 10 -w nuevo_sources.list -a Europa
```

Esto probará los primeros 10 mirrors para Europa de **Debian GNU/Linux UNSTABLE** y los escribira en el archivo nuevo_sources.list

Con esto ya tenemos nuestros nuevos repositorios, simplemente copiamos nuevo_sources.list como `/etc/apt/sources.list` y listo!!!
#### Referencia

