# Matrix - 1. Instalación y configuración

A partir de unos articulos de [Lorenzo](https://atareao.es/?s=matrix) y de [uGeek](https://ugeek.github.io) (podeis encontrar más información en la referencia), me pico la sobre como seria tener mi propio servidor de mensajeria y poderlo utilizar para enviar las notificaciones de mis servicios y asi no depender tanto de *Telegram*.

De hay viene este nuevo articulo, donde explicare todo el proceso de instalación y uso de mi nuevo servidor **Matrix** en mi VPS y os aviso que no ha sido nada sencillo.

<!--more-->

{{< admonition note >}}
Pero antes, tengo que tirarle un poco de las orejas a **Lorenzo**, porque la información que tiene puesto en su **pagina web** o en su repositorio de **GitHub** es muy floja con respecto a la instalación y configuración de todo lo que se necesita para su correcto uso, y eso me ha lastrado mucho a la hora de realizar toda la instalación y configuración. 

Porque cuando tienes algo por donde empezar, todo se hace más facil y no como esta vez que ha sido como tirarte a la piscina sin saber nadar y sin flotador. Que si, he aprendido mucho, pero no es lo más recomendable.

Que conste que no es ninguna recriminación hacia **Lorenzo**, porque seguro que tendra algun motivo para no haberlo subido a su repositorio, pero es que ha sido como un dolor de muelas todo el proceso. 😭
{{< /admonition >}}

Después del tiron de orejas, viene lo bueno, la explicación de todo lo necesario para tener un servidor de **Matrix** en marcha y a pleno rendimiento, aunque aun le faltan algunas cosas que explicare en proximos articulos.

Lo primero es decidir que servidor de *Matrix* utilizar. Como he dicho, **uGeek** y **Lorenzo** 2 muy diferentes entre ellos, te recomiendo que leas los articulos que hablan de ello porque son muy interesantes, y estos servidores son:
- *uGeek*: [Synapse](https://github.com/matrix-org/synapse)
- *Lorenzo*: [Conduit](https://conduit.rs)

En principio, el que recomienda **Matrix** es que se use *Synapse*, pero es un poco pesado de usar para las cosas, que en mi caso quiero hacer, que son basicamente:
- Un solo usuario 😁
- Solo enviara notificaciones de los servicios que tengo activos tanto en mi servidor domestico como de mi VPS.
- El volumen de notificaciones que tendra que enviar es muy bajo.

En este caso, para este tipo de uso, segun lo que he podido leer, y **atareao** pone mucho enfasis en este punto, el mejor es **conduit** por los pocos recursos que necesita asi como los que consume.

Asi que en primera instancia me fui a por la instalación de **Conduit** como servidor de **Matrix** y como he dicho, **Lorenzo** no lo ha puesto nada facil, porque no habia subido a su repositorio, como siempre hace, el `docker-compose` para la instalación, y ha sido una tarea ardua y nada sencilla. 

Eso si, lo cortes no quita lo valiente, y tengo que decir que *Lorenzo* si que puso el `docker-compose` en este [articulo](https://atareao.es/podcast/crear-bots-en-matrix), para instalar el servidor de *Matrix* y el cliente *Cinny*, pero no de la manera que nos tiene acostumbrados.
{{< admonition tip >}}
Opinión Persona: Con respecto a los articulos y más concretamente los videos de *Lorenzo*, antes si explicaba todo el proceso de instalación, *en plan rapido y explicaba un poco por encima lo que hace cada cosa*, pero ya era algo por donde empezar, ahora en los nuevos videos esto no lo hace y se hace un poco más dificil ver y entender todo el conjunto. Que si, de esta manera aprendes más, pero el inicio es más cuesta arriba.
{{< /admonition >}}

Pues como iba diciendo, tenia un `docker-compose.yml` por el que empezar a trastear y en mi caso quedo de la siguiente manera:
```yaml
 cinny:
   image: ajbura/cinny:latest
   init: true
   container_name: matrixCinny
   networks:
     - internal
   volumes:
     # Es el GitHub de Cinny podeu trobar un config.json per començar
     - ${HOME}/config/matrix/cinny/config.json:/app/config.json
   labels:
     - traefik.enable=true
     - traefik.http.services.cinny.loadbalancer.server.port=80
     - traefik.http.routers.cinny-secure.entrypoints=websecure
     - traefik.http.routers.cinny-secure.rule=Host(`${CINNY_SERVER}`)
     - traefik.http.routers.cinny-secure.tls=true
     # En aquest cas, vaig trobar a falta informació respecte al que fa exactament aquests 2 middlewares.
     # Més o menys ara tinc que clar fan, pero...
     - traefik.http.routers.cinny-secure.middlewares=traefik-real-ip@file,http2https@file
     - traefik.http.routers.cinny-secure.tls.certresolver=letsencrypt

conduit:
  image: matrixconduit/matrix-conduit:latest
  container_name: matrixConduit
  init: true
  restart: unless-stopped
  volumes:
    - ${HOME}/config/matrix/db:/var/lib/matrix-conduit/
    - ${HOME}/config/matrix/conduit.toml:/conduit.toml
  environment:
    CONDUIT_CONFIG: /conduit.toml
    RUST_BACKTRACE: full
  networks:
   - internal
  labels:
    - traefik.enable=true
    - traefik.http.services.conduit.loadbalancer.server.port=6167
    - traefik.http.routers.conduit-secure.entrypoints=websecure
    - traefik.http.routers.conduit-secure.rule=Host(`${MATRIX_SERVER}`)
    - traefik.http.routers.conduit-secure.tls=true
    - traefik.http.routers.conduit-secure.tls.certresolver=letsencrypt
    - traefik.http.routers.conduit-secure.middlewares=cors-headers@docker
    - traefik.http.middlewares.cors-headers.headers.accessControlAllowOriginList=*
    - traefik.http.middlewares.cors-headers.headers.accessControlAllowHeaders=Origin, X-Requested-With, Content-Type, Accept, Authorization
    - traefik.http.middlewares.cors-headers.headers.accessControlAllowMethods=GET, POST, PUT, DELETE, OPTIONS

 well-known:
   image: nginx:latest
   container_name: matrixNginx
   restart: unless-stopped
   networks:
     - internal
   volumes:
     - ${HOME}/config/matrix/nginx/matrix.conf:/etc/nginx/conf.d/matrix.conf # the config to serve the .well-known/matrix files
     - ${HOME}/config/matrix/nginx/www:/var/www/ # location of the client and server .well-known-files
   labels:
     - traefik.enable=true
     - traefik.http.routers.to-matrix-wellknown.rule=Host(`${MATRIX_SERVER}`) && PathPrefix(`/.well-known/matrix`)
     - traefik.http.routers.to-matrix-wellknown.tls=true
     - traefik.http.routers.to-matrix-wellknown.tls.certresolver=letsencrypt
     - traefik.http.routers.to-matrix-wellknown.middlewares=cors-headers@docker
     - traefik.http.middlewares.cors-headers.headers.accessControlAllowOriginList=*
     - traefik.http.middlewares.cors-headers.headers.accessControlAllowHeaders=Origin, X-Requested-With, Content-Type, Accept, Authorization
     - traefik.http.middlewares.cors-headers.headers.accessControlAllowMethods=GET, POST, PUT, DELETE, OPTIONS
```
Esto es el `docker-compose.yml` como ya he dicho, para *Cinny*, *Conduit* y *WellKnown* (Nginx), este ultimo, por lo que he ido leyendo, entiendo que se usa más para todas las funcionalidades de cuando tu servidor de *matrix* esta federado con el resto de servidores, pero que en teoria, para un uso normal no haria falta, pero si lo usa *Lorenzo* seguramente algo se me escapa. *Donde manda patron, no manda marinero*.

Asi mismo, a parte del `docker-compose.yml` tambien se tienen que hacer unas modificaciones en el **proxy** que estes utilizando, que en mi caso es **traefik**. Las modificaciones que se tienen que hacer en el fichero `traefik.yml` son:
```yaml
experimental:
  plugins:
    geoBlock:
      moduleName: "github.com/PascalMinder/geoblock"
      version: "v0.2.5"
    traefik-real-ip:
      modulename: github.com/soulbalz/traefik-real-ip
      version: v1.0.3
```
A continuación la modificación que se tiene que hacer en `dynamic.yml`:
```yaml
http:
  middlewares:
    http2https:
      redirectScheme:
        scheme: https
        permanent: true
    traefik-real-ip:
      plugin:
        traefik-real-ip:
          excludednets:
            - "1.1.1.1/24"

    cors-headers:
      headers:
        accessControlAllowOriginList:
          - "*"
        accessControlAllowHeaders:
          - "Origin"
          - "X-Requested-With"
          - "Content-Type"
          - "Accept"
          - "Authorization"
        accessControlAllowMethods:
          - "GET"
          - "POST"
          - "PUT"
          - "DELETE"
          - "OPTIONS"
          
  routers:
    conduit-secure:
      rule: "Host(`${MATRIX_SERVER}`)"
      entryPoints:
        - "websecure"
      # Servico docker del Servidor de Matrix, en mi caso, Conduit
      service: "conduit"
      tls:
        certResolver: "letsencrypt"

  services:
    conduit:
      loadBalancer:
        servers:
          # URL del servicio de Conduit
          - url: "http://conduit:6167"
```
Con esto, ya tendria que funcionar sin ningun problema nuestro *servidor de Matrix*. En principio es asi, pero ahora es cuando te das de bruzes con la realidad.

Lo primero es ver que si envias un mensaje desde la consola, este llegue correctamente a tu servidor y aqui es cuando empezaron mis problemas y eso que el script es facil. Encontre miles de los scripts. Pero la diferencia que habia entre unos y otros, es que unos hacian uso de *POST*, que es la versión antigua para enviar los mensajes, y otros usaban el *PUT* que es la versión más actual y que todos los servidores de *matrix* acceptan.

No os podeis imaginar la de problemas que tenia.

Llegue hasta un punto de eliminar el servidor de **Conduit** y probar con **Synapse** a ver si el problema radicaba es eso. Tambien hice multiples modificaciones a los ficheros de traefik (`traefik.yml` y `dynamic.yml`) y no conseguia que nada funcionase. El problema no estaba en el servidor que utilizase, sino más bien, en el *script*. Aqui fue donde si que pedi ayuda a *Lorenzo* porque no sabia por donde salir y fue cuando me paso el *script* que lo soluciono todo y que pongo a continuación:
```bash
#! /bin/bash

MATRIX_SERVER="https://matrix.myserver.org"
TOKEN="TOKEN_MATRIX"
ROOM_ID="ROOM_ID:matrix.myserver.org"

curl -XPUT \
    -H "Authorization: Bearer ${TOKEN}"\
    -H "Content-Type: application/json"\
    -d '{"msgtype":"m.text","body":"hello world"}' \
    "https://${MATRIX_SERVER}/_matrix/client/v3/rooms/${ROOM_ID}:${MATRIX_SERVER}/send/m.room.message/$(date '+%s%3N')"
```
Con este simple *script* todo volvio a la vida y yo por fin podia ver la luz al final del camino.

No pare de enviar mensajes desde la consola al cliente, desde el cliente al movil, desde el movil al cliente y ahora si, todo funcionaba correctamente.

Lo unico que no me acababa de funcionar bien, era el tema de enviar imagenes, esto viene porque en una de las tareas que quiero usar, es necesario enviar imagenes, y no habia manera de que el cliente del portatil se pudieran ver las imagenes. En cambio en el movil si que las veia.

Para que veais lo frustante que es, llegue a probar todos los clientes habidos y por haber a traves de web y en todos me pasaba lo mismo. Me pase 3 dias peleando contra esto y en todos me daba de bruces contra la pared. Hasta que se me ocurrio la brillante idea 💡, porque no lo hice antes, de preguntar en el foro de *Conduit*. Lo que me respondieron era para darme de collejas hasta en el carnet de identidad. La pregunta era muy simple, *tienes el navegador en modo incognito* 🤯

No me lo podia creer, no podia ser que por estar con esta configuración no se vieran las imagenes, pues ya os lo podeis imaginar. Si por esta tonteria no se pueden ver las imagenes. Desactive esa opción y las imagenes que enviaba las podia ver si problemas en el cliente de mi portatil 🤬.

Llevaba 3 dias intentando solucionar este problema y todo era por culpa del navegador *Firefox* que me estaba apuñalando por la espalda. Que es culpa mia porque podia haberlo preguntado antes, pero quien iba a pensar que por estar en *modo incognito* se bloquearan las imagenes. Una cosa más que ya tenia solucionada.

Lo unico que me faltaba era que los servicios pudieran enviar imagenes pero esto, ya os puedo decir que hasta donde yo se, no es posible, porque por lo que he llegado a entender, y eso que he hecho miles de pruebas, y he leido mucho sobre este tema, es que primero se tiene que enviar la imagen al servidor de *matrix*, para que te de una especie de *URL*, más concretamente un **MXC** y luego con esta dirección tu ya puedes enviar un mensaje con esa imagen adjunta. Y no todos los servicios con los que se puede usar *matrix* tienen ese tipo de funcionalidad implementada. 

Aunque *matrix* mismo podria cambiar esta manera de funcionar y funcionar de la misma manera de *Telegram*, *Discord* o *Slack*.

Pero bueno, ya podia hacer funcionar correctamente mi servidor de matrix y podia enviar y recibir mensajes entre mis diferentes dispositivos.

Ahora solamente queda la opción de sacarle jugo al nuevo servico. Pero esto ya lo explicare en otro articulo que este me parece que ya se esta haciendo muy largo. Porque también os tengo que decir que tuve que sudar sangre y lagrimas para conseguir lo que yo queria.
#### Referencia
- [535 - Crear bots en Matrix](https://atareao.es/podcast/crear-bots-en-matrix)
- [522 - De Mattermost a Matrix](https://atareao.es/podcast/de-mattermost-a-matrix)
- [Conduit. El matrix escrito en rust](https://ugeek.github.io/blog/post/2022-07-11-conduit-el-matrix-escrito-en-rust.html)
- [Servidor de mensajería Matrix Synapse, en Raspberry, Ubuntu, Debian… con Docker](https://ugeek.github.io/blog/post/2021-01-28-servidor-de-mensajeria-matrix-synapse-en-raspberry-ubuntu-debian--con-docker.html)
- [Cinny](https://cinny.in)
- [Synapse](https://github.com/matrix-org/synapse)
- [Conduit](https://conduit.rs)

