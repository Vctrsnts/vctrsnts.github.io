# Por fin. VPS para hacer pruebas

Hacia mucho tiempo (minimo 2 años), que habia escuchado que Oracle te daba *gratuitamente* la posibilidad de tener un VPS para poderlo usar, eso si, con unas ciertas limitaciones:
- 1 vCPUs x86 - 1Gb Ram
- 4 vCPUs ARM - 24Gb Ram

Asi que si anteriormente, en un RaspberryPi con 1Gb de Ram y una unica CPU podia tener amule, transmission las 24 horas del dia y el sistema iba sobrado, la elección seria facil.

La elección era lo más facil, lo dificil fue conseguir darse de alta. Y cuando digo dificil, me refiero a dificil.

<!--more-->

Tarde como unos 2 años a conseguir darme de alta en el servicio. No se porque, pero me era imposible conseguir darme de alta, probe con todo tipo de emails (que tengo), tambien probe con emails ficticios (de los que duran 10 minutos), tambien probe con diferentes tipos de tarjetas de debito / credito, pero no habia ninguna manera de conseguir acceder al servicio, también probe de preguntar al *servició de ayuda* que habia disponible, pero como todos los servicios de ayuda, era como darse cabezazos contra una pared. No servian para nada.

Pero no se porque, antes de vacaciones, lo volvi a intentar y por fin lo consegui, no se como, pero funciono. Porque volvi a hacer lo mismo que habia echo las anteriores veces. A lo mejor fue porque el sistema estaba menos saturado, no se, pero me funciono.

Asi fue como consegui mi VPS, limitado eso si, pero no necesitaba nada más para hacer mis pruebas y usarlo como yo queria, pues me venia de perlas. Para que necesitar más.

Lo primero era crear la maquina virtual con las necesidades maximas (dentro del `Free Tier`):
- Arquitectura ARM (4 vCPUs)
- 24Gb de Ram
- SO. Ubuntu ARM (muy parecido a Raspbian **Debian GNU/Linux**, etc...)

Ahora solamente faltaba crear la maquina y configurarla, pero de eso no voy a explicar nada, porque hay miles de videos por internet donde lo explican mejor de lo que yo lo podria explicar.

Eso si, cuando tuve el sistema apunto y actualizado y minimamente [securizado](/2020-11-08-rpi-usando-fail2ban), le instale **Docker** siguiendo mi propia [guia de instalación](/2020-03-08-rpi-usando-docker) y ya lo tengo todo preparado para hacer mis cosas :)

Le instale los siguientes contenedores:
- [Caddy](2021-04-08-rpi-caddy-proxy-manager.md)
- [Searxng](https://ugeek.github.io/blog/post/2023-03-20-searxng-buscador-privado.html)
  - Este ultimo lo estoy usando como mi buscador principal y pasa por delante de **duckduckGo** y a **Google**.
- [Monitorix](https://elblogdelazaro.org/posts/2020-02-03-monitorix-monitoriza-tu-sistema)
  - Lo tengo para tener una monitorización del servidor por los puntos mas importantes a tener en cuenta.
- [DuckDns](2020-10-30-rpi-cambiando-equipo.md)
  - No voy a explicar como se instala, porque usando docker es superfacil. Además a traves de este [video](https://www.youtube.com/watch?v=MLjKbake8HM) de mi argentino preferido esta mejor explicado. Eso si, ultimamente ha decaido mucho (en mi opinion) en la tematica de los videos y ya no es como antes.
- [Jekyll](https://llibres.ahnenerbe.duckdns.org)
  - Aqui es donde tengo otra pagina web (diferente a la que tengo en GitHub), pero que ya hablare en otro articulo.

Si os dais cuenta, estoy poniendo muchos de mis articulos donde comento en como se instalan diferentes aplicaciones / programas / containers en una **RaspberryPi**, pero como todo es ***ARM*** y los sistemas operativos que uso, son derivados de **Debian GNU/Linux**, pues no hay ningun problema en la instalación.

A parte de lo instalado, también tengo puesto este [script](https://ugeek.github.io/blog/post/2023-04-10-neveridle-vps-de-oracle-nunca-inactivo.html) que en pocas palabras (para más información leer en completo articulo de uGeek) explica que si las maquinas virtuales estan sin utilizar Oracle las desactiva y las borra. El **script** lo que hace, es consumir recursos (lo que tu hayas marcado en el fichero de configuración) para asi dar la sensación, de que el servidor se esta usando y evitar cualquier problema de que te lo desactiven o borren.

Esto es mi odisea para tener un VPS, seguramente muchos direis que se le puede sacar más partido. Tengo ideas que me gustaria probar en el servidor, servidor de musica, de podcast, etc..., pero no se si es aconsejable porque a lo mejor podria tener problemas y me podrian cerrar el chiringuito.

En el caso de que alguno de los que me lee lo tenga, que usos le dais al VPS de Oracle. Es para conseguir nuevas ideas.
#### Referencia
- [uGeek - NeverIdle](https://ugeek.github.io/blog/post/2023-04-10-neveridle-vps-de-oracle-nunca-inactivo.html)
- [Searxng](https://ugeek.github.io/blog/post/2023-03-20-searxng-buscador-privado.html)
- [El Blog de Lazaro - Monitorix](https://elblogdelazaro.org/posts/2020-02-03-monitorix-monitoriza-tu-sistema)
- [PeladoNerd - DuckDns](https://www.youtube.com/watch?v=MLjKbake8HM)

