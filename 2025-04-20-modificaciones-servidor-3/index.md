# Modificaciones en el servidor - 3

Este nuevo articulo no sabia si llamarlo **Modificaciones en el servidor - 3** o **La imaginación humana no tiene limites**, porque una vez que hayais leido este articulo pensareis lo mismo que yo.

<!--more-->

Como recordareis, en este [articulo](/2024-10-19-modificando-servidor-2) os comentaba que después de los ultimos cambios, mi servidor habia quedado de la siguiente manera:
- Intel Xeon e2286M
- 32Gb de RAM
- 4 HDD's
  - 1 HDD de 18Tb
  - 1 HDD de 16Tb
  - 1 HDD de 12Tb
  - 1 HDD de 1Tb
    - Este lo uso para copias de seguridad.
    
Lo más importante es saber el porque de este cambio. Al principio todo iba correctamente, aunque habia momentos en que notaba que los discos duros me hacian el tonto, como si se desconectasen o se reiniciasen pero como me lo hacia pocas veces, pues no le hacia mucho caso, porque como pasaba poco, pues nada.

La cosa cambio, cuando le añadi un nuevo *HDD Seagate Exos X20 SATA* (gracias a **HomeLabs** y sus conjuntas 😈), quedando el servidor con la siguiente configuración:
- 5 HDD's
  - 2 HDD de 18Tb
    - 1 HDD Toshiba
    - 1 HDD Seagate Exos
  - 1 HDD de 16Tb
  - 1 HDD de 12Tb
  - 1 HDD de 1Tb
    
Aqui se hicieron más seguidos y peligrosos los problemas que habia visto con anterioridad. Ya eran más importantes porque estos pasaban cada 2 por 3, los HDD's se reiniciaban sin motivo aparente y sobre todo cuando se hacian copias de muchos archivos a la vez o de archivos muy pesados y para que veais lo peligroso que habia, que a veces el array de **unRaid** se *desmontaba* quedando todos los discos duros desactivados con el consiguiente peligro para la integridad de la información.
    
Asi que tuve que desconectador algunos HDD. Al final, el servidor quedo de la siguiente manera:
- 3 HDD's
  - 2 HDD de 18Tb
    - 1 HDD Toshiba
    - 1 HDD Seagate Exos
  - 1 HDD de 12Tb
  
{{< admonition note >}}  
Como veis, peor de lo que estaba al principio, hablando de espació de almacenamiento y con los mismos problemas o peores.
{{< /admonition >}}

Lanze la pregunta a mi canal favorito de Telegram, *HomeLabs* y la respuesta que me dieron, es que todo tenia pinta de falta de potencia para manejar los 3 que tenia en ese momento. No entendia, porque habia una falta de potencia, si antes habia podido usar 3 HDD's sin ningun problema, usando el mismo transformador que tenia, el de **135w**, mediante la siguiente [modificación](https://homelabs.club/cambios-y-modificaciones-compatibles-con-los-tinys-m910q-m710q-m910x) donde se puede alimentar, siempre que tengas el transformador de 135w, un par de HDD's. 

El problema no era que por los 3 HDD's, sino porque 2 eran de alta capacidad (18T) junto con el *Xeon* del Tiny y la fuente ya no podida dar todo la demanada que se le pedia. La solución que me dieron y que redundaria tanto en mi benefició como en la salud de los HDD's, porque para los HDD's no es nada aconsejable que se esten *reiniciando* constantemente.

Mire las diferentes posibles soluciones que tenia a mi alcance, y todas tenian como resultado final, añadir una fuente de alimentación externa unicamente para los HDD's. Tambien me comentaron, que si tomaba este camino, podria, con la misma fuente, alimentar el *Tiny* y asi solamente tendria un unico cable, el espació del que dispongo es muy limitado.

Mientras pensaba en si hacer la modificación que me habian comentado, me contacto como un angel salvador 👼, **@Mr H**, al que siempre le estare agradecido por el increible trabajo de diseño que ha realizado, y tampoco nos podemos olvidar de **J.Lu**, los 2 de [HomeLabs](https://t.me/homelabsclub).

**@Mr H** me comento que estaba haciendo un nuevo diseño para poder acoplar un blackplane de 8 HDD's a un Tiny 🤯. 

Ya conocia a **@Mr H** porque tenia una antigua versión de [este mismo concepto](/2024-09-18-modificando-servidor-1), que también habia diseñado el, pero solo para 6, pero con un diseño más rudimentario y simple (segun *@Mr H*), no tan refinado como este nuevo (segun sus propias palabras).

Aqui podeis ver una primera versión del diseño en el que estaba trabajando:

{{< image src="/images/TiNAS_01.jpg" caption="TiNAS (`image`)" src_s="/images/TiNAS_01-small.jpg" src_l="/images/TiNAS_01-large.jpg" >}}

{{< image src="/images/TiNAS_02.jpg" caption="TiNAS (`image`)" src_s="/images/TiNAS_02-small.jpg" src_l="/images/TiNAS_02-large.jpg" >}}

{{< image src="/images/TiNAS_03.jpg" caption="TiNAS (`image`)" src_s="/images/TiNAS_03-small.jpg" src_l="/images/TiNAS_03-large.jpg" >}}

{{< admonition note >}}
Tengo que agradecer a **@Mr H** por permitirme publicar el diseño del TiNAS
{{< /admonition >}}

Que os parece? No es increible 🤩.

Tambien me comento que serian necesarios algunos componentes más y que eran muy faciles de conseguir en Aliexpress:
- [Probador de arranque de fuente de alimentación](https://es.aliexpress.com/item/1005007594599660.html)
- [Cable SATA 3,0 de 0,5 m/1m Cable SATA de angulo recto de 90 grados](https://es.aliexpress.com/item/1005007539344272.html)
  - Os aconsejo coger, como [minimo](https://es.aliexpress.com/item/1005007539344272.html) el de 6, yo pedi el de 4 y ya me estoy planteando comprar el de 6.
- ~~[Rele](https://es.aliexpress.com/item/1005007722058869.html)~~
  - Comprar este [otro](https://es.aliexpress.com/item/1005006782658465.html) porque con el primero nunca me llego a funcionar, no se si era por culpa del propio rele que ya no funcionaba o porque lo estropee yo.
- [Fuente de alimentación Modular](https://es.aliexpress.com/item/10000289980196.html)
- [Placa de circuito plano posterior para 8 HDD - SATAo SAS](https://es.aliexpress.com/item/1005006838080256.html)
- [Cable de alimentación USB](https://es.aliexpress.com/item/1005006954833827.html)
  - Aunque este os lo podeis ahorrar si teneis vosotros y como minimo tiene que ser de 50cm.
- [Tornillos a prueba de golpes para HDD 3.5" ](https://es.aliexpress.com/item/1005005162114038.html)
- [Cable de alimentación](https://es.aliexpress.com/item/1005004704710515.html)
  - Este cable, es para unificar los 2 cables (fuente y transformador en uno solo)
- [Tarjeta de expasión](https://es.aliexpress.com/item/4001263294249.html)
  - Esta es la que venia utilizando hasta el momento y que tambien iba a usar para esta nueva versión.
- [Thermalright Ventilador delgado TL-C12015](https://www.amazon.es/dp/B0BNT4NLP8)
  - Tenia un *Artic* pero cuando quiero poner otro, como los cantos de donde tienen que ir, son redondos, no entran 2 ventiladores, asi que pedi consejo a **@Mr H** y me aconsejo este que es mucho mejor y son los que usa el.
- [Cable de resistencia de ventilador](https://es.aliexpress.com/item/1005004974264597.html)
  - Esto es porque los conectores para los 2 ventiladores del blackplane suministran 12v y siento decirlo, pero de momento, el *Artic* si lo conecto hace un poco de ruido 😭, asi que siguiendo el consejo, de nuevo de **@Mr H**, voy a comprar estos conectores para reducir un 50% (color rojo) la tensión de los ventiladores.
- [Cable Molex IDE de 4 pines a SATA de 15 pines](https://es.aliexpress.com/item/1005008654185241.html)
  - Este es otro cable, para, siguiendo el consejo del vendedor del blackplane, hay que poner los 2 conectores *ATX* junto con el *SATA* para alimentarlo.
  
{{< admonition tip >}}
He actualizado la lista de la compra, porque han pasado ya unas cuantas semanas de uso y he cambiado algunas cosas por necesidad
{{< /admonition >}}

{{< admonition question >}}
- Seguramente os estareis preguntando porque en vez de ir por este camino, no me compro componentes nuevos y con una misma fuente, que tambien podria ser de 500w, tener un equipo mejor y más actual. La respuesta podria **si**, pero teniendo ya todo o gran parte de los componentes que necesitaba, no me salia a cuenta deshacerme de todo y comprar equipamiento nuevo, además, el espacio que tengo es limitado y tengo lo que tengo. 
- Además, nunca vas a llegar a usar los 500w de la fuente, porque primero tendria que tener los 8 HDD en funcionamiento siempre, actualmente tengo 4 y como maximo podre llegar a tener 6 que es lo maximo que me da mi tarjeta de expansión *PCI* y el momento en que un HDD consume más es al iniciar toda la parte mecanica. Asi que...
{{< /admonition >}}

Eso si, tengo que indicar que el preció es un poco elevado, pero todo eso es por culpa de la fuente de alimentación, que en mi caso seleccione la de 500w, porque nunca se sabe.

A lo mejor os preguntais, como podra funcionar todo el sistema si por una banda, esta la fuente de alimentación para los discos y por otra el transformador para el Tiny, porque no es plan de dejar la fuente de alimentación todo el rato conectada alimentando a los HDD's, aun cuando el servidor este apagado. No tiene ningun sentido.

Podeis estar tranquilos, yo me hice esa misma pregunta y **@Mr H** me lo aclaro todo. El sistema es sencillo, pero si no te lo explican, puedes perderte un poco, y tengo que decir que yo estudie electronica industrial, pero de eso hace mucho tiempo, y de electronico ya queda muy poco (aunque gracias a esta modificación, he tenido que recuperar viejos habitos) 😁. 

El sistema es bien simple, por una banda tienes la alimentación del Tiny, que cuando lo enciendes, se activa todo el sistema, incluido los conectores del USB, esto es importante porque es aqui, donde radica la simpleza y genialidad de todo el sistema. Cuando se activan los USB, tenemos un cable USB que va conectado a un **rele**, para que este al activarse, active a su vez la fuente de alimentación que *activara* todos los HDD's dando por iniciado todo el sistema. Asi mismo, en el momento de apagar el servidor, el USB dejara de alimentar el **rele**, haciendo que se desactive la fuente y por consiguiente los HDD's. 

Os pongo 2 imagenes que representarian el sistema en plan que se pueda entender, el interruptor seria el USB que cuando se enciende el Tiny y la bombilla serian los HDD's:

![](/images/HDD_OFF.png "HDD desactivados")

![](/images/HDD_ON.png "HDD activados")

Por eso digo, que todo es muy simple, pero a la vez una genialidad. La unica pega que le veo, es que tienes que tener dos cables de corriente, uno para el transformador de la Tiny y otro para la fuente de alimentación. Pero esto se puede solucionar facilmente si compras este [cable](https://es.aliexpress.com/item/1005004704710515.html) que permite la conexión de una fuente de alimentación y un transformador y asi tienes un 2x1.

Además, cuando te ponen la miel en los labios, no puedes parar y eso es lo que pasa cuando estas apuntado al canal de **HomeLabs**, que te van llegando ofertas cada 2x3 de cosas, que en principio no te interesan pero cuando te llega una oferta superincreible, pues, no puedes dejarla pasara, y eso paso con la venta conjunta de discos **NVME**, **disco**, pero no de 128Mb o 256Mb, sino de 4Tb.

Como resultdo de esta compra, mi servidor quedo de la siguiente manera y ya definitivamente, repito, sino me echaran de casa:
- Intel Xeon e2286M
- 32Gb de RAM
- 5 HDD's
  - 2 de 18Tb
    - 1 Toshiba Series MG09
    - 1 Seagate Exos X20 SATA
  - 1 de 16Tb
  - 1 de 12Tb
  - 1 NVME WD SN 700 de 4Tb
  
Aunque tengo pensado volver a añadir el de 1Tb para volver a activar las copias de seguridad, porque estoy con el culo al aire con respecto a este tema.

Todo esto montado y en funcionamiento en una caja echa en impresión 3D con las siguientes medidas aproximadas:
 - 21cm largo.
 - 20cm alto.
 - 20cm ancho.

Que gracias a un simple y pequeño **Thinkcenter m910x**, que más se puede pedir.

Aqui teneis algunas fotos de como es la criatura en su habitat natural:

{{< image src="/images/TiNAS_04.jpg" caption="TiNAS (`image`)" src_s="/images/TiNAS_04-small.jpg" src_l="/images/TiNAS_04-large.jpg" >}}
{{< image src="/images/TiNAS_05.jpg" caption="TiNAS (`image`)" src_s="/images/TiNAS_05-small.jpg" src_l="/images/TiNAS_05-large.jpg" >}}
{{< image src="/images/TiNAS_06.jpg" caption="TiNAS (`image`)" src_s="/images/TiNAS_06-small.jpg" src_l="/images/TiNAS_06-large.jpg" >}}

Ya os ire contando como va todo con esta nueva modificación.

{{< admonition note >}}
☎️ Si quereis saber más información sobre este proyecto, el **TiNAS**, contactar a traves de Telegram con el canal de telegram de [HomeLabs.club - Telegram](https://t.me/homelabsclub) y os daran toda la información sobre este proyecto y otros que se estan llevando a cabo en la asociación.
{{< /admonition >}}
#### Referencia
- [HomeLabs.club - Web](https://homelabs.club)
- [HomeLabs.club - Telegram](https://t.me/homelabsclub)
- [Cambios y modificaciones compatibles con los tiny’s M910Q/M710Q/M910X](https://homelabs.club/cambios-y-modificaciones-compatibles-con-los-tinys-m910q-m710q-m910x/)

