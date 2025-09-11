# Matrix - 2. PushBits, la pasarela que faltaba

Como bien explique en el anterior [articulo](/2025-03-25-instal-config-matrix), explicaba la instalación y configuración, nada facil, de mi servidor de **matrix** ahora os vengo a traer el siguiente articulo, donde explico el uso que le he dado y los problemeas que me he encontrado asi como los planes de futuro.

<!--more-->

Después de la instalación de *matrix* ahora tenia que configurar los servicios para que pudiera utilizar este nuevo servicio que he instalado y aqui es donde me he encontrado algunos problemas, porque no todos los servicios que tengo actualmente incluyendo a *unRaid* no estan del todo preparados para su uso. Ya lo ireis viendo si seguiis leyendo.

El primer servicio que queria que utilizar *matrix* es [flexget](https://www.flexget.com), y asi en vez de usar *telegram* usaria *matrix*. Segun la documentación de [flexget](https://flexget.com/en/Plugins/Notifiers/matrix), este servicio estaba soportado, aunque tengo que decir, que la documentación, siento usar estas palabras, es un poco penosa, no se como pueden poner esa información. Podrian explicar que tipo de mensajes soporta esta aplicación, de que manera se tienen que enviar, etc... cosas que te pueden servir de ayuda para tu después utilizarlo de la manera que quiereas. 

Pero lo unico que te indican es lo siguiente:
```yaml
notify:
  entries:
    via:
      - matrix:
          server: "https://matrix.org"
          token: senders token
          room_id: room identifier
```
Nada más. Eso si, te explican que es cada cosa (*server*, *token* y *room_id*), pero ya esta. Lo siento, pero para mi esto no es una documentación, más bien son los apuntes de alguien.

Siento decir que esto solo es el principio, porque cuando me puse a hacer las pruebas, no habia manera de hacerlo funcionar con la instalación de *Conduit* que yo tenia. No funcionaba ni para atras. Cambiando script, haciendo pruebas con todo lo que me encontrada por internet, haciendo preguntas a *Copilot*, que teoricamente tiene acceso a todo lo de *GitHub* y *flexget* esta hay. Cambiando de *Conduit* a *Synapse*, pero ni con esas habia manera de enviar un simple mensaje a mi servidor de *matrix*.

La unica respuesta que obtenia de *flexget* era lo siguiente:
```bash
root@08aa614bcf06:/config# Error while sending notification to `matrix`: 404 Client Error: Not Found for url: https://matrix.myServer.org/_matrix/client/r0/rooms/roomID/send/m.room.message?access_token=TOKEN
```
Al final después de muchas preguntas al *Slack* de *flexget*, consegui que me respondieran, y lo que me dijeron de que el problema, por el mensaje que me estaba dando *flexget*, era de que este estaba utilizando la antigua versión del envio de mensajes `r0`, en vez de la más actual que ya implemtan todos los servidores de *matrix* asi como todos los clientes 😱. 

Es una cosa que pude comprobar yo mismo, porque encontre el archivo que utiliza *flexget* para manejar las notificaciones, y se podia ver claramente como los envios se hacen mediante una versión anterior a la que se usa actualmente en *matrix*. Pues empezamos bien. La primera en la frente.

Tambien queria usar *matrix* para que mi servidor de *unRaid* me enviara todas las notificaciones, y aqui va la segunda en la frente, *unRaid* no esta preparado, de momento, para hacer uso de *matrix*. Que bien empezamos. Con lo que habia sufrido para instalar *matrix* y voy y me encuentro que las 2 primeras cosas que quiero usar *matrix* no estan soportadas. Asi, que iba hacer ahora. Desinstalar *matrix* y volver a *telegram*. 
{{< admonition note >}}
Como decia [Geoge S. Patton](https://es.wikipedia.org/wiki/George_Patton) **Nunca estás vencido hasta que lo admites**.
{{< /admonition >}}

Asi que me puse a investigar por la opción más importante y *necesaria*, hacer que *unRaid* pudiera enviar las notificaciones a *matrix*. Después de mucho investigar, encontre esta [pregunta](https://forums.unraid.net/topic/122107-matrix-notification-agent) en el foro de *unRaid*, que al principio no acababa de entender, pero me explicaron, que hay un servicio en docker, que se llama [PushBits](https://www.pushbits.io) que hace de puente entre *matrix* y cualquier otro servicio, porque **simula** que estas enviando los mensajes a un servidor de **Gotify** y actualmente hay muchos más que pueden enviar notificaciones a *Gotify* que a *matrix*, y uno de estos es *unRaid* que a parte poder enviar las notificaciones a un servidor *Gotify* tambien permite el envio de notificaciones a *PushBits*.
{{< admonition note >}}
Tengo que decir que esto mismo lo hace [atareao](https://atareao.es) pero a traves de **webhooks**, creo que se dicen, pero es un tema que no acabo de entender del todo, asi que de momento voy por este camino. Eso no quiere decir que en el momento que entienda más del tema haga el cambio.
{{< /admonition >}}

Pues ya tenia todo lo necesario, para que tanto *unRaid* como *flexget*, pueden enviar mensajes a *Gotify*. Seguro que lo tenia todo? Faltaba la parte más dificil de todas, la instalatación y configuración. Y aqui se viene otro baño de realidad. En el repositorio de [Pushbits](https://github.com/pushbits/server) no encontraba nada de como hacer posible la instalacion a traves de `docker-compose.yml` y como usarlo después.

Asi que de nuevo a investigar. Nunca se va acabar esto de investigar 😓. Lo unico que me alegra, es que cuando deje de investigar solamente sera por 2 posibilidades, o soy tan listo que lo se todo 🤣, cosa dificil, o es que estoy muerto 💀.

Pero lo que es la vida, no se como, pero encontre la web de *PushBits* donde te puede llevar tanto al repositorio como a la documentación, no se como no lo vi antes, y en la documentación, aqui si, es donde obtuvo lo primero, el fichero del `docker-compose` para poderlo usar:
```yaml
 pushbits:
   image: ghcr.io/pushbits/server:latest
   container_name: matrixPushbits
   networks:
     - proxy
   volumes:
     - /etc/localtime:/etc/localtime:ro
     - /etc/timezone:/etc/timezone:ro
     - ${HOME}/config/matrix/pushbits:/data
   environment:
     PUSHBITS_DATABASE_DIALECT: 'sqlite3'
     PUSHBITS_ADMIN_MATRIXID: '@user:matrix.myServer.org' # The Matrix account on which the admin will receive their notifications.
     PUSHBITS_ADMIN_PASSWORD: 'passwordAdmin' # The login password of the admin account. Default username is 'admin'.
     PUSHBITS_MATRIX_USERNAME: 'userMatrix' # The Matrix account from which notifications are sent to all users.
     PUSHBITS_MATRIX_PASSWORD: 'passwordMatrix' # The password of the above account.
   labels:
     - traefik.enable=true
     - traefik.http.services.pushbits.loadbalancer.server.port=5050
     - traefik.http.routers.pushbits.entrypoints=websecure
     - traefik.http.routers.pushbits.rule=Host(`${NOTIFY_SERVER}`)
```
Luego me faltaba entender su funcionamiento, y siento decir que la documentación a excepción de su instalación, tambien peca un poco, o a lo mejor soy yo que no encuentro las cosas, que tambien puede ser. 

Pero de nuevo la suerte fue mi aliada, que seria de mi, sin las incidencias que entra la gente, porque encontre esta [incidencia](https://github.com/pushbits/server/issues/71) donde explicaba todo lo que se tiene que hacer para usar *PushBits*, pero en ese caso, fallaba, pero para mi ya era algo. Habia conseguido toda la información necesaria para usar este nuevo servicio.

A parte de saber como se tiene que usar, tambien tienes que tener el fichero de configuración, que puedes obtener un ejemplo del repositorio, aunque yo pongo el que estoy utilizando ahora mismo y que me funciona perfectamente:
```yaml
# A sample configuration for PushBits.
# Populated fields contain their default value.
# Required fields are marked with [required].
debug: false

http:
    # The address to listen on. If empty, listens on all available IP addresses of the system.
    listenaddress: ''
    # The port to listen on.
    port: 5050
    # What proxies to trust.
    trustedproxies: []
    # Filename of the TLS certificate.
    certfile: ''
    # Filename of the TLS private key.
    keyfile: ''

database:
    # Currently sqlite3, mysql, and postgres are supported.
    dialect: 'sqlite3'
    # - For sqlite3, specify the database file.
    # - For mysql specify the connection string. See details at https://github.com/go-sql-driver/mysql#dsn-data-source-name
    # - For postgres, see https://github.com/jackc/pgx.
    #   Also consider the canonical docs at https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING.
    connection: 'pushbits.db'

admin:
    # The username of the initial admin.
    name: 'admin'
    # The password of the initial admin.
    password: 'admin'
    # The Matrix ID of the initial admin, where notifications for that admin are sent to.
    # [required]
    matrixid: ''

matrix:
    # The Matrix server to use for sending notifications.
    homeserver: 'https://matrix.myServer.org'
    # The username of the Matrix account to send notifications from.
    # [required]
    username: '@user:matrix.myServer.org'
    # The password of the Matrix account to send notifications from.
    # [required]
    password: ''

security:
    # Wether or not to check for weak passwords using HIBP.
    checkhibp: false

crypto:
    # Configuration of the KDF for password storage. Do not change unless you know what you are doing!
    argon2:
        memory: 131072
        iterations: 4
        parallelism: 4
        saltlength: 16
        keylength: 32

formatting:
    # Whether to use colored titles based on the message priority (<0: grey, 0-3: default, 4-10: yellow, 10-20: orange, >20: red).
    coloredtitle: false

# This settings are only relevant if you want to use PushBits with alertmanager
alertmanager:
    # The name of the entry in the alerts annotations or lables that should be used for the title
    annotationtitle: title
    # The name of the entry in the alerts annotations or labels that should be used for the message
    annotationmessage: message

repairbehavior:
    # Reset the room's name to what was initially set by PushBits.
    resetroomname: true
    # Reset the room's topic to what was initially set by PushBits.
    resetroomtopic: true
```
A parte del fichero de configuración, tambien necesitas crear una *sala / aplicación* (yo asimilo sala de *matrix*, con aplicación de *PushBits*), donde primero tienes que dar de alta la aplicación, del que obtendras un **TOKEN** que podras usar para identificar quien esta enviando los mensajes a *matrix*. Y esto se consigue de la siguiente manera:
```bash
usuari@debian:~$ docker exec -it matrixPushbits sh
# PER SABER LA IP DEL CONTENIDOR DE PUSHBITS, AMB AQUESTA INSTRUCCIÓ ES POT ACONSEGUIR
$ docker inspect <container_name> | grep "IPAddress"

# VISUALITZEM LES SALES / APLICACIONS QUE TENIM ACTUALMENTE
/app $ pbcli application list --url http://172.20.0.5:8080 --username admin

# En el cas de que en vulguessim crear una sala / aplicació, haures de fer el següent
# En aquest cas, estic creant una sala / aplicació per a flexget
/app $ pbcli application create flexget --url http://172.20.0.5:8080 --username admin
```
{{< admonition note >}}
Cuando pongais la **URL** tener en cuenta que es la url del contenedor donde esta corriendo pushbits
{{< /admonition >}}

Cuando tengas creada la sala / aplicación, obtendras un **token** que sera el que tendras que utilizar para validarte con *Pushbits* y a su vez, este se comunicara con la sala de *matrix*. Y te puedo asegurar que funciona a la perfección 🎉.

Ya solo nos queda configurar, *unRaid* para que se envien las notificaciones y como este, esta preparado para *PushBits* pues todo perfecto:

![](/images/PushBits.png "PushBits")

De la misma manera que *unRaid* funciona con *PushBits*, *flexget*, como tiene la posibilidad de enviar notificaciones a traves de *Gotify* y *PushBits* puede *simular* a este, pues nada más sencillo:
```yaml
notify-all:
  notify:
    entries:
      title: 'Nou Video'
      message: |+
        *Titol:* { original_title | replace('.XXX.720p.HEVC.x265.PRT', '') | replace('.XXX.720p.HD.WEBRip.x264-TGxXX', '') | asciify | strip_symbols }
        # Aixo son provas per enviar images a matrix, pero que de moment no funcionant.
        [Image](https://img.freepik.com/free-photo/side-view-woman-bdsm-aesthetics_23-2151117274.jpg)
      via:
        - gotify:
            # Adreça de PushBits
            url: '{? credencials.gotify.server ?}'
            * Token que ens ha donat al donar d'alta l'aplicació
            token: '{? credencials.gotify.token ?}'
            # Prioritat del missatge. Aqui et recomano que revisis la documentación de Gotify
            # En el meu cas, jo tinc possat el valor 1
            priority: '{? credencials.gotify.priority ?}'
            # Format dels missatges
            content_type: 'text/markdown'
```
Ahora si que podemos decir que todo lo que yo queria ya lo tengo en funcionamiento. Aunque tengo que seguir investigando la posibilidad de poder enviar imagenes como mensajes adjuntos, pero esto ya lo dejo para más adelante. Lo siguiente es hacer, como tiene en funcionamiento *atareao* un *bot de matrix* para que me vaya informando de los mails que voy recibiendo y luego, el tiempo ya dira...
#### Referencia
- [PushBits](https://www.pushbits.io)
- [Request failed at creating new application](https://github.com/pushbits/server/issues/71)
- [Matrix notification agent](https://forums.unraid.net/topic/122107-matrix-notification-agent)

