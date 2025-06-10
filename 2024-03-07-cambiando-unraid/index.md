# Cambiando a UnRAID

Este mes de marzo ha traido un cambio inesperado en mi servidor.

Lo primero de todo, vi una oferta de un Lenovo m910x (el que dispone de una ranura para puerto PCI) en Wallapop que venia completo (tarjeta grafica, SSD, RAM, transformador de 135w), o sea, una perita en dulce. Asi que me lance de cabeza a el. Y junto con los 2 HDD que ya tenia en funcionamiento (18Tb y otro de 12Tb) en mi [antiguo servidor](/2023-08-01-de-nuevo-cambiando-servidor) más otro que estaba en stand-by de 16Tb, y aprovechando el [mod](https://homelabs.club/cambios-y-modificaciones-compatibles-con-los-tinys-m910q-m710q-m910x) que se le puede hacer a los Tiny (sobre todo a los m910x), pense en aprovechar los 3 HDD y tener un **peazo** servidor que no se lo saltase un galgo.

<!--more-->

La unica duda que tenia, era como sacarle partido a todo el hard que tengo a mi disposición?

Pero antes de pensar en sacarle provecho al hard, tenia que hacer una operación quirurgica al nuevo servidor, para aprovechar las ventajas del m910x. Y esta modificación, consiste en:
- Soldar 3 cables a la placa base, para sacar la alimentación para los HDD. 
  - Los puntos que tienes que soldar, los puedes encontrar en esta [image](https://media.printables.com/media/prints/571792/images/4573825_5c9533df-9369-43f3-adfb-a8e3ec3e6bcc/thumbs/inside/1280x960/jpeg/noard-pinout-voltages.webp) del mod donde indica donde se tienen que hacer las soldaduras. El problema es si no tienes mucha experiencia o ninguna, entonces la cosa se complica. Yo he tenido de recordar los 5 años que me pase soldando cuando estaba haciendo el FP. de electronica industrial, asi que...
- Encontrar todo el material necesario para poder conectar los cables SATA a la PCI del Tiny. En la web de **homelabs.club** los encontraras.
- He ampliado la RAM del Tiny a 32Gb
- He cambiado la CPU que venia por defecto, **Intel i5 - 6500T** por una un poco mejor **Intel i5 - 6600T**.
  - Tengo en el almacen una **Intel i5 - 7500T**, pero no se si seria mucho hablando en terminos de consumo electrico.

Una vez realizada la parte más dificil, ahora solamente toca decidir que **Sistema Operativo** ponerle. En principio queria volver a poner **Debian GNU/Linux** tal como tenia antes en mi anterior servidor. Pero en el canal de telegram de **HomeLabs.club** todo el mundo comentaba las bondades de [UnRAID](https://unraid.net) y me decidi a probarlo a ver que tal era y si era tan bueno como decian.

Antes de nada, tenia que conseguir una licencia. Lo bueno que tiene **UnRAID**, es que tiene una licencia de prueba de `30 dias`. El **Sistema Operativo** tiene muy bien. Todo esta bien cuidado y bien ordenado, aunque al principio cuesta encontrar las cosas, pero eso es como todo. 

Pero por mi experiencia, antes de nada y para que no te lleves ningun susto o te encuentres perdido, te recomiendo que le des un vistado a los siguientes videos:
 - [Guía de Primeros Pasos en UnRAID (parte1)](https://www.youtube.com/watch?v=00zfs3U21GY)
 - [Guía de Primeros Pasos en UnRAID (parte2)](https://www.youtube.com/watch?v=Aq6ssRuMQVo)
 - [Guía de Primeros Pasos en UnRAID (parte3)](https://www.youtube.com/watch?v=B5jpsmV1Mjg)
 - [Guía de Primeros Pasos en UnRAID (parte4)](https://www.youtube.com/watch?v=GRjWusI3fj8)

Estos videos van muy bien, porque te pone en situación y te ayudan en la primera instalación y configuración del sistema. Es muy sencillo, pero como siempre pasa, el principio cuesta todo.
{{< admonition note >}}
Cuando llegues a la sección de configuración del Array o vayas a instalar los HDD al sistema, y si antes ya has visto los videos, no es todo tan bonito como parece, piensa antes lo que vas a hacer, porque yo me lance al huerto con el **PreClear** de un HDD de 18Tb y tarde **90 horas**, se dice pronto, en tenerlo disponible para añadirlo al sistema. Pero bueno, me sirvio como aprendizaje para saber lo que es aconsejable y lo que no.
{{< /admonition >}}
Otra cosa que tambien me aconsejaron, fue que me apuntara al canal de **Discord de UnRAID_ES**, porque ya pedir ayuda, consejo, etc... siempre estan disponibles. Son mis angeles de la guardia.

Con todo esto, ya podia a empezar a hacer las pruebas con el sistema, probando configuraciones, plugins, dockers, etc... Y es hay, cuando en el canal de Discord, salta la noticia de que las licencias que hay en ese momento disponibles en **UnRAID** van a cambiar a subscripciónes anuales. Todo el mundo, en el canal de **Discord** se volvio loco,  y recomendaron, que lo mejor, era comprar ya, una licencia tal como estan ahora (de por vida) para asi, al menos quedar cubierto para lo que pueda suceder en un futuro, y viendo que el sistema me empezaba a interesar y que tenia posibilidades, pues me decidi a comprar una licencia **basica**. Eso si, lo que recomiendan, es que vayas directamente a la licencia **PRO** porque con eso te `aseguras` de que no tengas problemas en un futuro, a parte de que puedes conectar dispositivos (entendemos como HDD) ilimitados.

Hay que puntualizar una cosa con referencia a lo de dispositivos **ilimitados** que salio en el mismo podcast donde se hablo de las licencias. El tema es que los famosos ilimitados queda muy bonito, pero que ahora mismo, **UnRAID** solo soporta 24 dispositivos, si son muchos, pero no es ilimitado. En mi caso, yo con 3 HDD, para que os hagais una idea, tengo unos 50Tb disponibles. Más que suficiente para mi servidor.
{{< admonition tip >}}
Tambien, hay que tener en cuenta, esto es una opinion mia y personal, es que puedes tener la *más mejor* de las licencias, que si la empresa que hay detras de UnRAID dice que anula todas las licencias anteriores, no servira de nada decir que tenias una **PRO** y que **era para toda la vida**, a parte de que cuestan una pasta.

Mucha gente opina, que si la empresa que hay detras de **UnRAID** hiciera eso, la comunidad entera se les echaria encima y abandonarian el barco en masa, con las consecuencias que eso podria tener para la empresa.
{{< /admonition >}}

Después de haber resuelto el tema de la licencia me puse a instalar todo lo que tenia en el anterior servidor, que es lo siguiente:
- Jellyfin
- Flexget
- Transmission
- aMule
- Gotify
- Caddy
- DuckDns
- Jackett
- Scruttiny
- Wireguard
  - No hace falta instalar nada, porque ya va instalado en el propio UnRAID
- Navidrome
- Glances
- HomePage
- PiHole

Aun me faltan algunas cosas para estar al 100%, pero hay andamos.

Si nos ponemos a hablar de las pegas que, en mi caso, le encuentro, serian las siguientes:
- Consume muchos recursos, a mi modo de ver, y si encima vienes de una **Debian GNU/Linux** con 16Gb, pues.
  - Esto viene porque segun para que cosas, sobre todo copiar archivos, y eso que no tengo el HDD de paridad (que daria para hablar otro articulo), es un proceso que requiere mucha CPU, y esto lo digo con conocimiento de causa, porque antes tenia los HDD conectados a traves de USB y no notaba tanto consumo de CPU como ahora, que estan conectados a traves de SATA.
- Al consumir tantos recursos, hace, en mi caso, que la CPU se caliente más de lo que me gustaria, llega hasta unos agradables 65º. Una temperatura que no es de mi agrado.

Como veis, son unicamente 2, pero seguramente, si es que me lee alguien, dira que soy un exagerado y que a ellos, eso no les pasa. Pero claro, por lo que he visto en el canal de **Discord** mi servidor parece de pobre, porque segun parece todos en el canal, tienen servidores industriales 😉

Hasta aqui hemos llegado, ya seguire explicando como va mi experiencia y sensaciones con UnRAID.
{{< admonition question >}}
Si llegase el momento de que **UnRAID** cambiase su politica de licencias, que opción escogerias tu.
{{< /admonition >}}
#### Referencia
- [Cambios y modificaciones compatibles con los tiny’s M910Q/M710Q/M910X](https://homelabs.club/cambios-y-modificaciones-compatibles-con-los-tinys-m910q-m710q-m910x)
- [UnRAID](https://unraid.net)
- [Tutoriales UnRAID_ES](https://www.youtube.com/playlist?list=PLVJ0-m0_zw1iM5w6oDHrEwMW87JnC_2pR)

