# Raspberry Pi. Actualizando a Jessie

Tal como habia explicado en el anterior capitulo, después de tener mi RPI con Whezzy y viendo que habian sacado una nueva versión [Jessie-Lite](https://www.raspberrypi.org/downloads/raspbian) de Raspbian decidi realizar un `full-upgrade` para actualizar el sistema.

<!--more-->

Pero hay confiado de mi, a partir de ese momento, empezaron todos mis problemas que me replantearon el futuro de mi RPI.

La actualización fue facil y sencilla, al estilo **Debian GNU/Linux**, cambiar los `sources` que apuntan a **Wheezy** y hacer que apunten a **Jessie**. En principio no tendria que haber habido ningun problema, pero que equivocado estaba.

El fichero que se tiene que cambiar es:
```bash
usuari@raspberry:~$ sudo vi /etc/apt/sources.list
```

Y donde pone **Wheezy**, cambiarlo por **Jessie** y todo solucionado, pero una vez que reinicie el sistema y accedir a la Raspberry, empezaron a aparecer los problemas.

A primera vista, lo que pude observar, fue que cada cierto tiempo perdia la conexión a internet sin ninguna explicación y no habia forma de reconectar sino era reiniciando el sistema.

Después de buscar un poco de información y no encontrar nada, decidi volver a realizar la instalación limpia de mi RPI con **Wheezy** y todo volvio a la normalidad (ya se, fui un cobarde, pero ...)

Pero he aqui amigo, que como soy un poco culo inquieto y despues de recibir el nuevo juguete que le iba a poner a la RPI, decidi volver a darle una nueva oportunidad **Jessie-Lite** y hacer una instalación limpia y nueva a la Raspberry y parece ser que le gusto mucho, porque lleva 1 semana en **Jessie** y sin ningun problema ni caida de red...

En el proximo [articulo](/2016-04-02-rpi-instalando-jessie-lite), explicare el proceso de instalación de **Jessie** en la Raspberry.
#### Referencia
- [Jessie-Lite](https://www.raspberrypi.org/downloads/raspbian)

