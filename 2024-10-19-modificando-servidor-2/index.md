# Modificaciones en el servidor - 2

Se ha venido una nueva modificación en el servidor, y una más, pero esta vez, ha sido más a nivel de hardware que de software.

Como sabreis, si no os habeis dado cuenta leyendo algunos de mis articulos, estoy subscrito al canal de telegram de [HomeLabs.club](https://homelabs.club), donde siempre tienen alguna nueva cosa para liarte la manta a la cabeza.

<!--more-->

Una de estas cosas, fue un sorteo que hicieron entre los miembros VIP del canal y como nunca tengo muchas esperanzas en este tipo de sorteos, pues me apunte. Nunca se sabe lo que puede pasar. 

Lo que paso fue increible, habian muchas cosas por sortear, televisores, Tiny's, telefonos, hubs, etc... Y yo junto con unos pocos fui uno de los agraciados con que me tocase un Tiny, en concreto un M710q y seguramente muchos direis, uff que poca cosa, pero si os digo lo que llevaba en sus extrañas ya no direis lo mismo.

Este M710q, llevaba un [Intel® Xeon® E-2286M](https://www.intel.la/content/www/xl/es/products/sku/192993/intel-xeon-e2286m-processor-16m-cache-2-40-ghz/specifications.html), con las siguientes caracteristicas (resumen):
- Cantidad de núcleos: 8
- Total de subprocesos: 16
- Frecuencia turbo máxima: 5.00 GHz
- Frecuencia básica del procesador: 2.40 GHz
- Caché: 16 MB Intel® Smart Cache 
- Tamaño de memoria máximo (depende del tipo de memoria): 128 GB

Un **Xeon** junto con **32Gb** de RAM y una entrada de ethernet conectada a la WIFI (que no se que voy hacer con eso). Para que os hagais una idea, el Tiny lleva el maximo de lo que su socket puede llevar.

No me lo podia creer cuando me dijeron que habia ganado esto y eso, como ya de dicho con anterioridad, soy esceptico en estos sorteos porque nunca me ha tocada nada, pero bueno, un dia es un dia.

Después de la noticia, tenia que ponerme a pensar que iba hacer eso ese equipo. En principio no necesitaba ningun equipo más porque voy servido. Asi que me vino a la cabeza, y si le pongo el **Xeon** al servidor. Seguramente os echareis las manos a la cabeza de que eso no es posible. No es la primera vez que lo hago, porque tengo en reserva otro Tiny con otro **Xeon** que sera mi futuro PC cuando el portatil que tengo ahora mismo muera, y por lo que veo, no tardara mucho, porque ultimamente me hace mucho el tonto. Asi que de vuelta al ruedo de los mods.

Eso si, me volvi a ver este [video](https://www.youtube.com/watch?v=ZDUWrwq1PXE) donde explica detalladamente todos los pasos que se tienen que hacer para modificar la BIOS de un Tiny para que accepte un **Xeon**. 

El proceso es facil, pero hay que ir con cuidado, porque lo primero es leer la *BIOS* del Tiny, luego modificarla y luego volverla a poner en el Tiny. Ya os digo que tengo experiencia, pero es una cosa que me da mucho respeto, porque nunca se sabe lo que puede pasar 🤯.

El proceso en si, dura como 30 minutos, pero que 30 minutos, siempre piensas que se va a estropear todo y que ya no volvera a funcionar.

Pero todo funciono correctamente 😁 y ya tenia en mi servidor el **Xeon** quedando con la siguiente configuración:
- Intel Xeon e2286M
- 32Gb de RAM
- 4 HDD's
  - 1 de 18Tb
  - 1 de 16Tb
  - 1 de 12Tb
  - 1 HDD de 1Tb
    - Este lo uso para copias de seguridad
  
En pocas palabras un servidor que nunca me voy a acabar. Lo unico que puede pasar es que revienten los HDD, pero el resto tengo para toda una vida.

Todo estaba ya estaba listo para conectar y hacerlo funcionar. Y el resultado fue todo un exito, todo funcionando correctamente y sin ningun problema a excepción de la temperatura del **Xeon** y del ventilador que cuando se le da un poco de caña se nota que esta hay presente.

Como no puede ser de otra manera, **HomeLabs** lo habia previsto y tenia una especie de [pequeño manual](https://t.me/c/1410082468/127), para hacer **downgrade** al **Xeon** y asi reducir tanto el rango de trabajo del mismo como la temperatura que con todo ello conlleva que se reduce el ruido del ventilador.

Pero aun asi, todavia, cuando le pedias caña al **Xeon** hacia acto de presencia, pues me aconsejaron que lo mejor en estos casos, es quitar el **Turbo Bost** de la CPU. Y eso que hice. Le desactive esa opción y ahora todo funciona con una mejor temperatura.

Mucha gente me dira que para eso no tengas un **Xeon** pero hay que tener en cuenta que el sistema de refrigeración no es el correcto, lleva el ventilador, de cobre para disipar mejor, pero es un simple ventilador. Además si en vez de *5Ghz* me va a *2.4Ghz* tampoco voy a notar mucha diferencia.

Es mi servidor personal, no uno de la nasa. Con esto ya estoy servido.

Lo unico que me faltaba por hacer era visualizar la temperatura tanto de la CPU como de la placa base en unRaid que era una cosa que nunca habia conseguido hacer, la de la CPU si, pero la placa base no. 

Pero eso sera en otro [articulo](/2024-10-20-controlado-temperatura-servidor).
#### Referencia
- [Como modificar la bios de tu Lenovo m710q, m910q o m910x tiny para usar CPUs no soportadas](https://www.youtube.com/watch?v=ZDUWrwq1PXE)
- [Hacer downgrade a Xeon](https://t.me/c/1410082468/127)

