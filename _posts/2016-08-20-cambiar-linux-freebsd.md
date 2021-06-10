---
layout: post
title: "Cambiar GNU/Linux Debian por FreeBSD?"
author: Victor
date: 2016-08-20
category: [freebsd]
---

**Antes de nada, decir que esto no es una critica a [FreeBSD](https://www.freebsd.org) ni una guerra de cual es mejor ( porque de eso, si buscas en cualquier foro de FreeBSD o de GNU/Linux encontraras muchos y mejores ).**

Sino que es mi opinion personal como usuario desde hace muchos años de GNU/Linux Debian ( empece con **Potato** ) con respecto a la transición de [GNU/Linux Debian](http://www.debian.org/index.es.html) a [FreeBSD](https://www.freebsd.org).

Después de hacer esta aclaración, ya podemos empezar... ;)

Todo esto, viene a raiz del pesimo modo ( en mi opinion ) en que se ha llevado a cabo la implementación de [Systemd](https://es.wikipedia.org/wiki/Systemd) en GNU/Linux Debian. A raiz de este cambio, estuve buscando una alternativa a mi GNU/Linux Debian, pero todas las versión de Linux ya tienen implementado **Systemd** en su interior y la unica alternativa que quedaba era **FreeBSD**. Y desde hace un par de meses, vengo haciendo pruebas en mi **Dell XPS** ( junto con un HDD de 250GB ) con **FreeBSD** y a continuación explico mi opinion personal con respecto a su instalación y uso ( que conste que esto, lo estoy escribiendo desde GNU/Linux Debian ).

**Repito, es mi opinión personal.**

# 1. Instalación

Es como se realizaba hace un par de años en GNU/Debian, asi que no es muy complicada. Lo unico que veo es la falta de **UTF**, a parte de esto, una instalación muy facil y sencilla. Y eso, que yo no use, todo el HDD como unica partición, sino que hice las siguientes ( constumbre de GNU/Debian ):

```
/		5Gb
/tmp		5Gb
/usr		24Gb
/usr/home	190Gb
/var		5Gb
swap		3.5Gb
```

# 2. Paquetes

Luego esta todo el tema de la instalación de paquetes, en mi opinión, ahora con `pkg` han echo un gran paso en su usabilidad, aunque aun estan los ports ( un tema que me trae de cabeza y que nunca he logrado entender ), a parte de que en mi portatil, no puedo usarlos, porque por cuestiones de temperatura no podia hacerlo

# 3. Configuració sistema

La configuración del sistema es facil, en principio, si no tienes nada raro, toda esta ya se ha realizado en la instalación.

# 4.Temperatura del sistema

La temperatura, este es otro tema que me ha traido de cabeza, porque todo el rato, el ventilador estaba funcionando ( eso si, la tecnologia **Optimus**, no ayuda mucho ). Para que os hagais una idea:

<table>
	<thead>
		<tr>
			<th></th>
			<th>Uso Normal</th>
			<th>Uso Intenso</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>GNU/Debian</td>
			<td>54º</td>
			<td>65º</td>
		</tr>
		<tr>
			<td>FreeBSD</td>
			<td>65º</td>
			<td>85º</td>
		</tr>
	</tbody>
</table>

En cambio, después de unas [modificaciones](https://forums.freebsd.org/threads/57176) en la configuración del sistema que me aconsejaron en el [Forum de FreeBSD](https://forums.freebsd.org) ( que seria de mi sin ellos ), he conseguido trasladar las temperaturas que tenia en GNU/Linux Debian a FreeBSD :D

# 5. Xorg, Slim, Xfce

Desde hace mucho tiempo que uso Xfce, no necesito más y encima consume pocos recursos. Además estan en FreeBSD, que se puede pedir.

La instalación, como digo antes a traves de pkg es muy facil, sin ningun problema, aunque tengo que decir que para la configuración de Xorg ( Optimus, ayudando ) en un poco diferente a como lo pinta en el HandBook y como te lo intentan vender en el Foro.

Porque digo esto, segun el [Handbook](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/x-config.html)( 5.4.8 ) ya no es necesario crear el fichero `xorg.conf` para que todo funcione correctamente, pero en mi caso, no se si por culpa de *Optimus* o que, si no tenia el fichero `xorg.conf`, `startx**` no me funcionaban. Creo que al final, me creyeron cuando dije que sin fichero no me funcionaba.

Después activar **Slim** junto con **DBUS** y **HAL** ya tenia mi **Xfce** funcionando y en perfecto estado.

# 6. Aplicaciones varias

Ahora mismo, en GNU/Debian uso las siguientes aplicaciones, todas muy basicas:

- Firefox.
- VirtualBox
- Clementine
- Xpdf
- Filezilla
- Claws Mail
- Chromium
- Wicd.
- Xfburn
- Mplayer
- Calibre

Yo creo que todas estas aplicaciones estan todas portadas a FreeBSD, a excepción de Wicd, que me recomendaron como alternativa usar [wifimgr](http://opal.com/freebsd/ports/net-mgmt/wifimgr).

# 7. Hardware externo

Porque tengo una sección sobre el *Hardware*, porque lo unico que me quedaba por provar es todo el tema de los USB ( pendrive, ebook ) no uso nada más.

Y aqui es donde viene el problema, **FreeBSD** no tiene portado el paquete `xfce-volman`, asi que tienes que tirar de [Handbook](https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/usb-disks.html).

Parezco un poco repetitivo, pero en la documentación te lo ponen como que es muy facil, pero realmente no es asi. Tienes que modificar más de un fichero, que si no te lo explican ( no viene en la documentación ) no logras que funcione. Pero gracias a un usuario del foro de FreeBSD, consegui que funcionara, pero de aquella manera. Me explico.

Conectaba un pendrive ( marca Toshiba ), **Xfce** me lo detectaba correctamente, clicaba en el y todo correcto, podia trabajar con el correctamente. Lo desmontaba y todo perfecto.

El problema venia con otro pendrive ( marca Sandisk ), lo conectaba, lo intentaba montar y ahi es donde tenia el problema. No me lo detectaba. Al final, me aparecia un mensaje indicando `Dispositivo Desconocido`. Y lo más raro de todo es que si extraia el pendrive, el sistema se reiniciaba solo.... :o

# 8. Documentación

Cuando me refiero a la documentación, no estoy diciendo que sea mala, desordenada ni nada por es estilo. Yo solamente la comparo con la documentación que hay con respecto a GNU/Linux Debian y con toda la documentación existente de GNU/Linux.

Se puede decir que la documentación como tal de **GNU/Linux** no existe, son miles de paginas desperdigadas por todo internet, en cambio la documentación que hay sobre **FreeBSD**, sabes que esta en un unico sitio y todo bien puesto.

A mi modo de ver, es una ventaja y un problema y ahora explico el motivo de porque digo esto.

Cuando digo que es una ventaja, es correcto, solamente un grupo de personas, crean y controlan la documentación y no hay miles de documentos desperdigados.

Con referencia a que tambien es una desventaja, me refiero a que toda la documentación ha sido realizada a traves de una maquina virtual de VirtualBox ( se puede ver si revisas un poco el HandBook )

![]({{site.baseurl}}/assets/img/bsdinstall-part-guided-disk.png)

Y esto para mi es una desventaja, porque la documentación se basa en una maquina standart que muy poca gente dispone ( ni yo mismo ) y cuando vas a buscar ayuda en esta documentación con respecto a cualquier problema que no hayan contemplado, pues te vas a volver loco, Pendrive, configuración `Xorg`, etc.. No hay información sobre que hacer son respecto a esta estos problemas que ellos no ha tenido o no han contemplado.

Si, tienes el foro pero dependiendo como hagas la pregunta y lo experimentado que seas en el tema FreeBSD a lo mejor no te responden ( que conste que eso nunca ha sido mi caso ), pero si que me ha pasado que en la lista oficial en castellano que estoy suscripto, envie primero mis dudas con respecto a FreeBSD ( las mismas que envie al foro ) y aun estoy esperando. Que conste que no es una critica, pero...

En cambio, yo veo un punto a favor la información que hay respecto a GNU/Linux, porque es documentación que ha realizado la gente sobre sus propias instalaciones en sus propias maquinas, maquinas reales, y esto es positivo, porque seguramente más gente se ha encontrado el problema de Optimus, es un ejemplo, pero seguro que habras otros casos,  y ellos explican la solucion que han tomado con respecto a este problema. Puede que a ti te sirva o no, pero es un punto de partida que puedes tomar.

En cambio, esto, en FreeBSD no lo veo, porque como la documentación solamente esta controlada por el grupo de FreeBSD, pues...

# 9. Conclusión

Esta es la opinión que he sacado despues de las pruebas que he realizado a FreeBSD, a mi modo de ver, aun quedan algunas cosas por pulir.

Cuando digo a pulir digo a facilitar la vida a los usuarios que quieres usar este sistema. Ejemplo claro `PKG`. Y digo esto, porque seguramente más gente que antes estaba contenta con las diferentes distribuciones de GNU/Linux, al ver el camino que ha tomado **Systemd**, estaran pensado lo mismo que yo y estaran sopesando la idea de pasar a FreeBSD y pueden haber pequeñas cosas que les puedan echar atras.

Si tenemos PCBSD, pero es lo mismo que digo con respecto a Ubuntu y GNU/Linux Debian. Porque vas a usar un sucedanio, si tienes el original.

Esto no quiere decir que vaya a desistir de él. Me gustaria realizar la migración a FreeBSD y poder abrir una nueva etapa de mi vida, tal como hice con GNU/Linux Debian.

Esto lo digo con pena, porque veo que GNU/Linux Debian no ha sabido tratar el tema de `Systemd` como era de esperar respecto a la filosofia que ellos representan...
