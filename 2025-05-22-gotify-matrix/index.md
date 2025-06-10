# Matrix - 4. De vuelta al inicio, de Gotify a Matrix

Como ya explique en este [articulo](/2025-05-19-matrix-gotify), ante la imposibilidad de usar **Matrix** me pase a **Gotify** aunque me negue a dejar de lado a *Matrix* y segui investigando, el porque no funcionaba correctamente y asi llegado el momento, poderlo usar o sino, tener una alternativa *Gotify*.

<!--more-->

Aqui si que tengo que dar las gracias a **Lorenzo** de **atareao**, por toda la ayuda que me ofrecio para resolver el problema que tenia 👏.

Lo primero fue facilitarme el `docker-compose.yml` que el estaba usando para **Matrix**, os lo pongo  continuación por si os sirve de ayuda, pero modificado para mis necesidades:
```yaml
conduit:
   image: matrixconduit/matrix-conduit:latest
   container_name: matrixConduit
   restart: unless-stopped
   volumes:
     - ${HOME}/config/matrix/db:/var/lib/matrix-conduit/
   environment:
     RUST_BACKTRACE: full
     CONDUIT_LOG: warn
     CONDUIT_SERVER_NAME: matrix.servidor.org
     CONDUIT_DATABASE_PATH: /var/lib/matrix-conduit/
     CONDUIT_DATABASE_BACKEND: rocksdb
     CONDUIT_PORT: 6167
     CONDUIT_MAX_REQUEST_SIZE: 20_000_000 # in bytes, ~20 MB
     CONDUIT_ALLOW_REGISTRATION: false
     CONDUIT_ALLOW_FEDERATION: false
     CONDUIT_ALLOW_CHECK_FOR_UPDATES: true
     CONDUIT_ENABLE_LIGHTNING_BOLT: true
     CONDUIT_TRUSTED_SERVERS: '["matrix.org" ]'
     CONDUIT_ADDRESS: 0.0.0.0
     CONDUIT_CONFIG: "" # Ignore this
   networks:
     - proxy
   labels:
     - traefik.enable=true
     - traefik.http.services.conduit.loadbalancer.server.port=6167
     - traefik.http.routers.conduit.entrypoints=websecure
     - traefik.http.routers.conduit.rule=Host(`${MATRIX_SERVER}`)
     - traefik.http.routers.conduit-secure.tls=true
     - traefik.http.routers.conduit-secure.tls.certresolver=letsencrypt
     - traefik.http.routers.conduit.middlewares=cors-headers@docker
     - traefik.http.middlewares.cors-headers.headers.accessControlAllowOriginList=*
     - traefik.http.middlewares.cors-headers.headers.accessControlAllowHeaders=Origin, X-Requested-With, Content-Type, Accept, Authorization
     - traefik.http.middlewares.cors-headers.headers.accessControlAllowMethods=GET, POST, PUT, DELETE, OPTIONS
```
Con este simple `docker` es lo unico que se necesita para instalar **Matrix**, no como lo tenia yo [antes](/2025-03-25-instal-config-matrix) que eso si que era complicado, ahora si que ya teniamos todas las herramientas para hacer funcionar a **Matrix**, o eso creia yo.

Una vez que ya tenia el **docker**, lo unico que me quedaba era probarlo, porque esta nueva manera de instalación, era mucho más sencilla que la que yo tenia antes. Pues aqui vamos a ver que resultado obtenemos:
```bash
usuari@debian:~$ docker compose up -d conduit
```
Después de la instalación, todo funcionaba correctamente, pero seguia con el problema de que las notificaciones no me llegaban al movil.

Aqui busque ayuda de todo el mundo, para saber el porque seguia sin funcionarme las notificaciones, tambien probe **Synapse**, pero con el mismo resultado, tambien llame a todas las puertas y todas me las encontraba cerradas o miraban la mirilla, pero no me abrianla puerta ;), hasta que al final pedi ayuda a **atareao** que muy amablemente se ofrecio a ver si conseguiamos llevar a buen puerto este problema que tenia, porque el, con esta misma configuración, no tenia problemas.

Os pongo un resumen de todo fue todo, porque sino seria muy largo todo y os dareis cuenta de lo que una pequeña cosa, los problemas que puede llegar a dar:
{{< admonition succes >}}
**atareao:** Cuantos usuarios tienes en Matrix?<br />
**yo:** Uno solo, que es el adm que soy yo<br />
**atareao:** Crea otro usuario y manda los mensajes con el otro usuario<br />
{{< /admonition >}}

Aqui fue cuando mi cerebro explosiono en mil trozitos y pidiendo a **@Atareao** que acabe con mi sufrimiento 🥹<br />
{{< admonition succes >}}
**yo:** *@atareao* Tienes cerca alguna cuerda larga y un barranco?<br />
**yo:** Para que me ates y me lances por ese barranco<br />
**yo:** He hecho lo que has comentado<br />
**yo:** He creado un usuario que es el administrador de los canales y luego me he creado mi usuario.<br />
**yo:** Entonces el adm me ha invitado a los canales y con el script que te he pasado estoy enviando mensajes a la sala y me aparecen las notificaciones<br />
**yo:** Por eso, yo me ato de pies y manos y tu solo tienes que empujarme hacia el barranco<br />
**atareao:** Ya... Tiene lógica que si te envías a ti mismo un mensaje no te notifique que tienes un mensaje nuevo<br />
{{< /admonition >}}
Llevaba 1 mes con este problema al que no le encontraba solución, y todo era por culpa de que solamente tenia un unico usuario, y por eso las notifiaciones no me llegaban. Que si te pones a pensar, tiene su logica, porque uno envia un mensaje al canal, para que el resto de usuarios les llegue la notificaciones. Pero claro es una cosa que no piensas, hasta que alguien te hace caer en ello.

Gracias **atareao** por toda la ayuda que me has dado.

Ahora si que si, tengo a pleno rendimiento mi servidor de matrix para poder usarlo para las notificaciones de todos mis servicios.

De momento, tengo en funcionamiento:
- El envio de notificaciones cuando se general los archivos `XML` de los podcast que descargo.
- Las notificaciones de la ejecución de las copias de seguridad, que lo podreis ver en este [articulo](/2025-05-22-restic-copias-locales-2).

Me queda pendiente las notificaciones:
- Notificaciones de **unRaid**
- Notificaciones de **flexGet**

Pero con estas tendre que pelearme un poco más porque tengo que usar **pushBits**, tal como explique en este [articulo](/2025-03-27-pushbits).

Alguna cosa más de la que me gustaria estar informado, pero para eso tengo que investigar si se puede hacer o no. Ya os ire informando de los progresos que voy teniendo.
#### Referencia
[atareao - gitHub](https://github.com/atareao/self-hosted/tree/main/matrix)

