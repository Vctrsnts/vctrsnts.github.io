# Opinión Personal sobre unRaid - 2

Tal como explique en este [articulo](/2024-06-05-opinion-unraid) comente que iba a dar mi opinión con respecto a **unRaid** y aqui va el segundo de los 2 articulos que tenia planeado escribir dando mi opinión con respecto a las cosas positivas y negativas, y hoy toca hablar de las cosas negativas que le he encontrado, y siento decir que son más que las positivas que negativas.

<!--more-->

Aunque algunas, al final las he podido solucionar, pero la solución que he utilizado, seguramente sea la correcta si voy a mirar la documentación de *unRaid*, pero no me parece correcto que se tenga que hacer de esta manera.

### Puntos negativos

#### Usando el SO mediante un USB
Lo primero y más importante como punto negativo, es que en pleno siglo XXI, se tenga que usar un SO mediante un USB, con lo que implica eso. Ni la RaspberryPi y ya es decir mucho, usa ese sistema ya. Si, lo puedes usar, pero añadieron la opción de instalar el SO en un HDD externo y no me creo, que unRaid, no sea capaz de replicar esta funcionalida. Seguramente, me direis, que es para no estropear el RAID o cualquier otra cosa, pero un USB. Y porque no en una **SD** ya puestos?

Pero si ahora todo el mundo tiene un SSD por hay abandonado donde se podria instalar el SO y funcionaria 100 veces mejor que el USB y con lo que se reducirian los posibles errores de escritura que tiene a la larga un USB, porque como todo el mundo sabe, un USB, no es para estar escribiendo todo el rato. 

Seguramente me direis que eso no pasa con unRaid, que no esta escribiendo todo el rato en el USB, no se si es cierto o no, pero me hago la siguiente pregunta. Y los **logs**? donde se graban en la RAM? Y si es asi, que pasa cuando se reinicia el sistema, se pierden los logs?

Digo los **logs**, como podria decir cualquier otra cosa. No es mejor poder instalar el SO en un HDD / SDD que este en unRaid y asi usarlo como disco de sistema. 

Porque teniendo 300 HDD conectados a unRaid y que no puedas disponer de ninguno como disco para el SO, me parece un poco fuerte.

Y esto es lo primero en la frente, no se que más sorpresas me deparara unRaid.

#### Instalación de aplicaciones
Cuando me refiero a la instalación de aplicaciones, no me estoy refiriendo a docker, que de eso ya hablare más adelante o a los SO para virtualizar, que no voy a dar mi opinión con respecto a esto, porque no lo estoy usando. Me estoy refiriendo ha aplicaciones que puedas necesitar. Y voy a poner un ejemplo para explicar a lo que me estoy refiriendo.

En mi caso, tengo un [script](/2023-08-10-como-funciona-esta-web), que cada fin de semana sube un *toot* a mi cuenta de *Mastodon* gracias a Python que tienes que instalar, con esto no tengo ningun problema, porque a traves del *plugin* **NerdTools** se puede hacer facilmente y sin complicaciones.

Pero el problema es que a parte de Python, también necesitas otros programas, como podria ser *Mastodon.py*, *Twython* y *feedparser* y que tienes que instalar a traves de `pip install` y esto es lo que no acabo de entender. El motivo por el cual no hacen lo mismo que otras distribuciones que mediante, me voy a centrar en la distribución que hace más de 20 años que uso, y esta no es otra que *GNU/Debian*, y esto se haria de la siguiente manera con `apt install python3-twython` o `apt install python3-feedparser` ya tienes estos programas instalados y no como en *unRaid* que lo tienes que hacer a traves de python `pip install feedparser`.

Yo esto lo veo como una desventaja. Porque además, es que si te vas a la paqueteria de *Slackware* estos paquetes ~~si que estan disponibles y eso por eso que no entiendo porque no se pueden instalar~~.

{{< admonition note >}}
Aqui hago un inciso, porque he buscado estos paquetes en la distribución de *Slackware* y no estan disponibles para su instalación, entonces entiendo que se tiene que hacer a traves de `pip install`, pero aun asi me resulta extraño. Sera que estoy acostumbrado a GNU/Debian.
{{< /admonition >}}

Luego para acabarlo de rematar, una vez que los instalas y en el caso de que se reinicie el servidor, nos puede pasar a todos, estos se tienen que volver a instalar. No le encuentro ningun sentido, porque si es un paquete que tu has instalado, significa que es algo que tu quieres y necesitas, sino no lo instalarias.

Esto me ha pasado al querer usar el paquete **lame** para recodificar un mp3 (que es un paquete que si que esta en la paqueteria de *Slackware*). Primero que no estaba disponible a traves de la paqueteria de *unRaid* asi que tuve que ir a la paqueteria de *Slackware* e instalarlo pero no me funcionaba y, vuelvo a repetir, cuando se reinicia el servidor, el paquete se pierde. 

Esto tiene una facil solución, pero que sino lo sabes, pues... (culpa mia por no leer la documentación de *unRaid*, pero digamos la verdad, quien se lee los manuales), todo se soluciona basicamente si copiamos el paquete en `boot/extra` para que asi la proxima vez, el servidor instale la aplicación. Pero en mi caso, esto no funcionaba y no sabia el motivo y es un punto que no me acaba de gustar y que se tendria que mejorar para futuras versiones, que cualquier aplicación externa a *unRaid* se pierda después de un reinicio. Tienes la opción de ponerla en `boot/extra`, pero lo tienes que hacer y si no lo sabes, pues...

{{< admonition note >}}
Buscando información sobre la paqueteria de *slackware* he encontrado este [articulo](https://cameronjtinker.com/posts/installing-system-packages-on-unraid-aka-slackware) donde explica cual es la manera correcta de instalar, paqueteria externa en nuestro *unRaid* y funciona correctamente. Me he descargado **lame** y he seguido las indicaciones y de momento lo tengo funcionado.

Esto se hace a traves de la siguiente instrucción `upgradepkg --install-new paquete.txz` 
{{< /admonition >}}

Ya hemos instalado la aplicación, pero no tendria que ser tan dificil si ya tenemos dentro del propio *unRaid* la posibilidad de instalar aplicaciones *externas* a traves del plugin *NerdTools* pues se le tendria que sacar más provecho.

#### Gestión de docker

Se que la *gestión de docker*, *unRaid* la hace a traves de plantillas. Supongo que es la mejor es la mejor forma de gestionar los dockers, pero me parece muy floja. Con todas las posibilidades que tiene docker y que las plantillas te limiten todas las posibilidades que te da. Si tienes la opción de añadir lo que tu quieres "añadiendo varibles, rutas, etc..." pero se hace más lento y complicado, si como es mi caso, estas acostumbrado a usar *docker* a traves de un fichero *yaml*.

Si tienes la posibilidad de instalar el *plugin compose*, pero claro, tienes que instalar otra cosa, que si vas sumando, al final, haces que todo el sistema se vuelva más lento. No podria estar ya implementada esta opcion y poderla usar? Si en docker tenemos *docker compose*, porque no se puede tener lo mismo. Asi amplias las posibilidades y no la encorsetas en las plantillas, que si, para empezar estan bien, pero te limitan mucho, y más si, como yo, estas acostumbrado a usar un simple fichero para *docker*.

Creo que aqui, se tendria que hacer un planteamiento en como se estructura y se usa docker, para dotar a *unRaid*, de la misma versatilidad que tiene docker. Porque luego, si lo ves, todo se hace a traves de `docker-compose`.

Pero claro, esto ya es un suma y sigue, que cosas que a mi entender son muy mejorables y que van sumando, y que en mi caso, no le vea mucha utilidad usar *unRaid* en comparación a tener un servidor con una *GNU/Debian* u otra distribución junto con *docker*.

#### Gestión del administrador de archivos

El gestor de archivos que usa *unRaid* es muy malo, siento decirlo. Podria ser mejor, pero no le sacan todo el potencial que se le podria sacar.

Un ejemplo de esto, es que una vez que has seleccionado los archivos a tratar, tienes que ir hasta el final de la pagina para realizar la acción. No podria funcionar esto de otra manera. Que siempre fueran visibles las acciones que quieres realizar?

A parte el funcionamiento es poco agil y en el caso de querer descargar archivos a tu ordenador, tienes que ir de archivo en archivo, no puedes hacer una selección y descargarlos todos a la vez.

Se nota que aun hace falta mucho trabajo que hacer con este gestor de archivos y que se le podria sacar más provecho de lo que se esta haciendo ahora.

#### SO que hay por debajo de unRaid

Esto es la opinión más personal de todo el articulo y lo digo con toda la convicción del mundo.

Si no lo habeis notado aun, soy usuario de *Debian GNU/Linux* desde hace más de 20 años y seguramente aun me falta mucho que aprender con respecto a todo el mundo de GNU/Linux. Pero aunque solo sea por los años que llevo usandolo, tengo una opinión formada con respecte a *GNU/Debian* y por eso, me gustaria saber el motivo de porque han usado *Slackware* como plataforma para crear *unRaid* cuando, si por algo es conocido GNU/Debian es por la multitud de posibilidades que tiene para instalar en cualquier hardware.

Además, tiene, seguramente, uno de los mejores sistema de instalación de paquetes y con muchos años a sus espaldas y me estoy refiriendo a *APT* o *APT-GET*. Y por eso no lo entiendo. Vuelvo a decir es una opinión personal y seguramente habra un motivo, pero no lo se ver.

Si mucho me apurais, podrian haber utilizado [NetBSD](https://es.wikipedia.org/wiki/NetBSD) que yo lo considero el *GNU/Debian* de los *BSD*, porque este SO se pueda instalar en 58 plataformas diferentes y se dice pronto.

#### Foro de ayuda

Foro de ayuda como tal, si que existe en la pagina web de *unRaid*, pero hay otro en *Discord* que te ayudan todo lo que pueden y más, sobre eso no tengo ninguna queja, pero habiendo *telegram* que seguramente todo el mundo que usa *unRaid* lo tiene instalado, no logro entender porque usan *Discord*. Porque obligas a la persona a tener 2 aplicaciones, *telegram* y *Discord*. 

En mi opinión, prefiero solo tener una sola de aplicación para eso. A parte, en el canal de telegram de **HomeLabs** tambien hay mucha gente que usa *unRaid* y, en mi caso, prefiero hacer las consultas hay que en *Discord*, por decir que me he dado de baja de *Discord* y ahora todas las dudas que tengo, las hago por telegram. Me resulta más facil y todo lo tengo concentrado en una aplicación y no en 2 como tenia antes.

No entiendo el motivo del porque usan *Discord*. Seguramente habra algun motivo, pero lo desconozco. Y se que antes usaban telegram, porque mucha gente de *HomeLabs* me lo confirmaron.

### Opinión Final
Se que podria poner en 4 lineas mi opinión final con respecto a *unRaid*, pero prefiero hacerlo en un ultimo articulo, para explicar lo que pienso.

Este articulo saldra, proximamente, si es que los **fanboys** de unRaid, no me han matado. 😅
#### Referencia
- [Slackware on unRaid](https://en.wikipedia.org/wiki/Unraid)
- [NetBSD](https://es.wikipedia.org/wiki/NetBSD)
- [Como funciona esta web y su creación](/2023-08-10-como-funciona-esta-web)
- [Installing system packages on unRAID aka Slackware](https://cameronjtinker.com/posts/installing-system-packages-on-unraid-aka-slackware)

