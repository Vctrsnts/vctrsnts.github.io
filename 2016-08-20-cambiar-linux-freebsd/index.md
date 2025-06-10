# Cambiar Debian GNU/Linux por FreeBSD?

{{< admonition note >}}
Antes de nada, decir que esto no es una critica a [FreeBSD](https://www.freebsd.org) ni una guerra de cual es mejor (porque de eso, si buscas en cualquier foro de FreeBSD o de GNU/Linux encontraras muchas y mejores).
{{< /admonition >}}

<!--more-->

Es mi opinion personal como usuario desde hace muchos años de **Debian GNU/Linux** (empece con **Debian GNU/Linux Potato**) con respecto a la transición de [Debian GNU/Linux](https://www.debian.org/index.es.html) a [FreeBSD](https://www.freebsd.org).

Después de hacer esta aclaración, ya podemos empezar... 😉

Todo esto, viene a raiz del pesimo modo (en mi opinion) en que se ha llevado a cabo la implementación de [Systemd](https://es.wikipedia.org/wiki/Systemd) en **Debian GNU/Linux**. A raiz de este cambio, estuve buscando alternativas, pero todas las versión de Linux ya tienen implementado **Systemd** en su interior y la unica alternativa que quedaba era **FreeBSD**. Y desde hace un par de meses, vengo haciendo pruebas en mi **Dell XPS** (junto con un HDD de 250GB) con **FreeBSD** y a continuación explico mi opinion personal con respecto a su instalación y uso (que conste que esto, lo estoy escribiendo desde **Debian GNU/Linux**).

{{< admonition warning >}}
Repito, es mi opinión personal.
{{< /admonition >}}

## 1. Instalación
Es como se realizaba hace un par de años en **Debian GNU/Linux**, asi que no es muy complicada. Lo unico que veo es la falta de **UTF**, a parte de esto, una instalación muy facil y sencilla. Y eso, que yo no use, todo el HDD como unica partición, sino que hice las siguientes (constumbre de **Debian GNU/Linux**):

```bash
mount point     size
----------      -----------
/               5Gb
/tmp            5Gb
/usr            24Gb
/usr/home       190Gb
/var            5Gb
swap            3.5Gb
```

## 2. Paquetes
Luego esta todo el tema de la instalación de paquetes, en mi opinión, ahora con `pkg` han echo un gran paso en su usabilidad, aunque aun estan los ports (un tema que me trae de cabeza y que nunca he logrado entender), a parte de que en mi portatil, no puedo usarlos, porque por cuestiones de temperatura no podia hacerlo

## 3. Configuració sistema
La configuración del sistema es facil, en principio, si no tienes nada raro, toda esta ya se ha realizado en la instalación.

## 4.Temperatura del sistema
La temperatura, este es otro tema que me ha traido de cabeza, porque todo el rato, el ventilador estaba funcionando (eso si, la tecnologia **Optimus**, no ayuda mucho). Para que os hagais una idea:
```bash
|   Uso   | Debian GNU/Linux | FreeBSD |
| ------- | ---------------- | ------- |
| Normal  |        54º       |   65º   | 
| Intenso |        65º       |   85º   |
```

En cambio, después de unas [modificaciones](https://forums.freebsd.org/threads/57176) en la configuración del sistema que me aconsejaron en el [Forum de FreeBSD](https://forums.freebsd.org) (que seria de mi sin ellos), he conseguido tener las mismas temperaturas que tenia en **Debian GNU/Linux** en **FreeBSD** 😉

## 5. Xorg, Slim, Xfce
Desde hace mucho tiempo que uso Xfce, no necesito más y encima consume pocos recursos. Además estan en FreeBSD, que más se puede pedir.

La instalación, como dije antes a traves de pkg es muy facil, sin ningun problema, aunque tengo que decir que para la configuración de Xorg (Optimus, ayudando) en un poco diferente a como lo pinta en el HandBook y como te lo intentan vender en el Foro.

Porque digo esto, segun el [Handbook](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/x-config.html)(5.4.8) ya no es necesario crear el fichero `xorg.conf` para que todo funcione correctamente, pero en mi caso, no se si por culpa de **Optimus** o que, si no tenia el fichero `xorg.conf`, `startx` no me funcionaban. Después de mucho preguntar en el foro de FreeBSD, creo que al final, me creyeron cuando dije que sin fichero no me funcionaba.

Después activar **Slim** junto con **DBUS** y **HAL** ya tenia mi **Xfce** funcionando y en perfecto estado.

## 6. Aplicaciones varias
Ahora mismo, en **Debian GNU/Linux** uso las siguientes aplicaciones, todas muy basicas:
- Firefox.
- VirtualBox
- Clementine
- Xpdf
- Filezilla
- Claws Mail
- Chromium
- Wicd
- Xfburn
- Mplayer
- Calibre

Yo creo que todas estas aplicaciones estan todas portadas a FreeBSD, a excepción de Wicd, que me recomendaron como alternativa usar [wifimgr](https://opal.com/freebsd/ports/net-mgmt/wifimgr).

## 7. Hardware externo
Porque tengo una sección sobre el **Hardware**, porque lo unico que me quedaba por probar es todo el tema de los USB (pendrive, ebook) no uso nada más.

Aqui es donde viene el problema, **FreeBSD** no tiene portado el paquete `xfce-volman`, asi que tienes que tirar de [Handbook](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/usb-disks.html).

Parezco un poco repetitivo, pero en la documentación te lo ponen como que es muy facil, pero realmente no es asi. Tienes que modificar más de un fichero, que si no te lo explican (no viene en la documentación) no logras que funcione. Pero gracias a un usuario del foro de FreeBSD, consegui que funcionara, pero de aquella manera. Me explico.

Conectaba un pendrive (marca Toshiba), **Xfce** me lo detectaba correctamente, clicaba en el y todo correcto, podia trabajar con el correctamente. Lo desmontaba y todo perfecto.

El problema venia con otro pendrive (marca Sandisk), lo conectaba, lo intentaba montar y ahi es donde tenia el problema. No me lo detectaba. Al final, me aparecia un mensaje indicando `Dispositivo Desconocido`. Y lo más raro de todo es que si extraia el pendrive, el sistema se reiniciaba solo.... :o

## 8. Documentación
Cuando me refiero a la documentación, no estoy diciendo que sea mala, desordenada ni nada por es estilo. Yo solamente la comparo con la documentación que hay con respecto a **Debian GNU/Linux** y con toda la documentación existente de GNU/Linux.

Se puede decir que la documentación como tal de **GNU/Linux** no existe, son miles de paginas desperdigadas por todo internet, en cambio la documentación que hay sobre **FreeBSD**, sabes que esta en un unico sitio y todo bien puesto.

A mi modo de ver, es una ventaja y un inconveniente y ahora explico el motivo de porque digo esto.

Cuando digo que es una ventaja, es correcto, solamente un grupo de personas, crean, controlan y modifican la documentación y no hay miles de documentos desperdigados.

El inconveniente es que toda la documentación ha sido realizada a traves de una maquina virtual de VirtualBox (se puede ver si revisas un poco el HandBook)

![](/images/bsdinstall-part-guided-disk.png "BSD Install")

Esto para mi es un inconveniente, porque la documentación se basa en una maquina standart que muy poca gente dispone (ni yo mismo) y cuando vas a buscar ayuda en esta documentación con respecto a cualquier problema que no hayan contemplado, pues te vas a volver loco, Pendrive, configuración `Xorg`, etc.. No hay información sobre que hacer con respecto a estos problemas que ellos nunca se han encontrado / contemplado, porque en una maquina virtual, esos problemas no se pueden dar.

Si, tienes el foro pero dependiendo como hagas la pregunta y lo experimentado que seas en el tema FreeBSD a lo mejor no te responden (que conste que eso nunca ha sido mi caso), pero si que me ha pasado que en la lista oficial en castellano que estoy suscripto, envie primero mis dudas con respecto a FreeBSD (las mismas que envie al foro) y aun estoy esperando. Que conste que no es una critica, pero...

Asi mismo, con respecto a la documentació de a GNU/Linux, yo la veo más util que la documentació de FreeBSD, porque es documentación que la ha realizado la gente sobre sus propias instalaciones en sus propias maquinas, maquinas reales, y esto es positivo, porque seguramente más gente se ha encontrado el problema de Optimus, es un ejemplo, pero seguro que habras otros casos,  y ellos explican la solucion que han tomado con respecto a este problema. Puede que a ti te sirva o no, pero es un punto de partida que puedes tomar.

En cambio, esto, en FreeBSD no lo veo, porque como la documentación solamente esta controlada por el grupo de FreeBSD, pues...

## 9. Conclusión
Esta es la opinión que he sacado despues de las pruebas que he realizado a FreeBSD, a mi modo de ver, aun quedan algunas cosas por pulir.

Cuando digo a pulir me estoy refiriendo a facilitar la vida a los usuarios que quieren usar este sistema. Ejemplo claro `PKG`. 

Digo esto, porque seguramente más gente que antes estaba contenta con las diferentes distribuciones que existian en GNU/Linux, pero al ver el camino que se ha tomado **Systemd**, estaran pensado lo mismo que yo y estaran sopesando la idea de pasar a **FreeBSD** y pueden haber pequeñas cosas que les puedan echar atras.

Si, tenemos **PCBSD**, pero es lo mismo que digo con respecto a Ubuntu y **Debian GNU/Linux**. Porque vas a usar un sucedanio, si tienes el original.

Esto no quiere decir que vaya a desistir de él. Me gustaria realizar la migración a FreeBSD y poder abrir una nueva etapa de mi vida, tal como hice con **Debian GNU/Linux**.

Esto lo digo con pena, porque veo que **Debian GNU/Linux** no ha sabido tratar el tema de `Systemd` como era de esperar respecto a la filosofia que ellos representan...

#### Referencia
- [FreeBSD](https://www.freebsd.org)
- [Handbook](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/usb-disks.html)

