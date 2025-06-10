# Usando Traefik - 4

Tal como indique en este [articulo](/2024-04-19-traefik), lo unico que me faltaba por añadir a **traefik** para tener mi VPS lo más seguro posible era **crowdsec** y por fin, ya lo tengo instalado.

Antes de lanzarte a la piscina directamente, te aconsejo que les eches un vistazo a este [articulo](https://atareao.es/podcast/mas-herramientas-para-proteger-tu-linux) de **atareao** donde habla de *crowdsec* y tambien a este [video](https://www.youtube.com/watch?v=-GxUP6bNxF0), que me ha servido como guia en todo el proceso.

<!--more-->

Si sigues leyendo este articulo, es que ya has revisado los articulos y el video que te he aconsejado antes, asi que ya podemos empezar. Para empezar, partimos de la configuración inicial que tengo en **traefik** y que podeis ver en los diferentes articulos, podemos empezar con la instalación de **crowdsec**.

Lo primero y antes de nada, hice una pequeña modificación a la configuración de **traefik** para asi tener mejor identificado el volumen que esta utilizando. Ahora mismo, el `docker-compose` donde tengo **traefik** lo tengo de la siguiente manera:
```yaml
traefik:
 volumes:
   - traefik_log:/var/log/traefik

volumes:
  traefik_log:
    name: traefik_log
```
De esta manera, tal como comento, tengo mejor identificado el `volumen` de *traefik*.

Después de esto ya podemos pasar a la instalación de **crowdsec**. Tengo que informar antes de empezar, que la instalación se divide en varias fases y que hay que ir, con un poco de cuidado, porque sino...

La primera de ellas es la creación de los directorios y archivos que nos haran falta para el correcto funcionamiento de **crowdsec** y **bouncer-traefik**.

Lo primero es crear el directorio **crowdsec**. Yo lo tengo en el mismo directorio donde tengo la configuración de **traefik** quedando de la siguiente manera:
```yaml
|-- config
|---- traefik
|---- crowdsec
|------ acquis
|-------- ssh.yaml
|------ acquis.yml
|------ mywhitelist.yml
```
Donde tendremos:

### acquis/ssh.yaml
Que es el encargado de controlar las conexiones **ssh** a nuestro servidor y asi, hacemos que **crowdsec** tambien las controle (ya explicaremos como).
```yaml
filenames:
   - /logs/auth.log
   - /logs/syslog
labels:
    type: syslog
```

### acquis.yml
Los ficheros *log* de **traefik**, tanto el `access.log` como el `traefik.log`.
```yaml
filenames:
  - /var/log/traefik/*
labels:
  type: traefik
```
Por ultimo

### mywhitelist.yml
```yaml
name: crowdsecurity/whitelists
description: "Whitelist events from my ip addresses"
whitelist:
  reason: "my ip ranges"
  ip:
    - "XXX.XXX.XXX.XXX"
```
Que es el fichero donde indicaremos a **crowdsec** las **IP** que son de confianza. Yo he puesto, la ip desde la que siempre me conecto al *VPS* para que asi no la tenga encuenta, aunque más adelante haremos una prueba para ver el funcionamiento de **crowdsec** con respecto a esta *IP*.


{{< admonition note >}}
Antes de nada, informar que en el fichero de `docker-compose.yml` donde tengo **traefik** tambien tengo la configuración de **crowdsec**, porque me ha resultado más facil, si lo haces con diferentes ficheros `yml` hay que tener un par de cosas en cuenta que ya os informare llegado el momento.
{{< /admonition >}}

Una vez que tenemos esto claro, empezamos añadiendo a nuestro fichero de `docker-compose.yml` lo necesario para **crowdsec**:
```yaml
#
# CROWDSEC - SEGURETAT PER A TRAEFIK I EL SERVIDOR
#
 crowdsec:
   image: crowdsecurity/crowdsec:v1.6.2
   container_name: crowdsec
   restart: unless-stopped
   networks:
     - proxy
   init: true
   environment:
     GID: "${GID-1000}"
     COLLECTIONS: "crowdsecurity/linux crowdsecurity/traefik crowdsecurity/sshd"
   volumes:
     - ${HOME}/config/crowdsec/acquis.yml:/etc/crowdsec/acquis.yaml
     - ${HOME}/config/crowdsec/mywhitelists.yml:/etc/crowdsec/parsers/s02-enrich/mywhitelists.yaml
     - ${HOME}/config/crowdsec/acquis/:/etc/crowdsec/acquis.d/
     - crowdsec-db:/var/lib/crowdsec/data/
     - crowdsec-config:/etc/crowdsec/
     - traefik_log:/var/log/traefik/:ro
     - /var/log/auth.log:/logs/auth.log:ro
     - /var/log/syslog.log:/logs/syslog.log:ro
   depends_on:
     - traefik
```
En la configuración hay que tener en cuenta un par de cosas:
- `depedens_on:` Aqui le indicamos a **crowdsec** que no puede iniciarse sino esta antes **traefik** en funcionamiento. Es como una medida de seguridad.
- `COLLECTIONS: "crowdsecurity/linux crowdsecurity/traefik crowdsecurity/sshd"` 
  - Yo lo entiendo, como las alertas o lo que tiene que *tener en cuentra* **crowdsec** para luego tomar las acciones necesarias. Hay muchas más opciones que puedes ir añadiendo. Las puedes encontrar [aqui](https://app.crowdsec.net/hub/collections). En mi caso he puesto:
    - `crowdsecurity/linux` para los posibles **bugs** que pueda tener **Linux**
    - `crowdsecurity/traefik` para los posibles **bugs** de **traefik**
    - `crowdsecurity/sshd` para los posibles **bugs** de **ssh**
- `networks` tanto *traefik*, *crowdsec* y *bounces-traefik*, que lo explicare más adelante, tienen que estar en la misma *red* para que se puedan comunicar entre ellos. 
- Tambien tenemos que tener en cuenta los *volumenes* que vamos a usar en **crowdsec**, que en este caso son los que pongo a continuación:
```yaml
 volumes:
    crowdsec-db:
      name: crowdsec-db
    crowdsec-config:
      name: crowdsec-config
    traefik_log:
      name: traefik_log
```

{{< admonition note >}}
Si os fijais, he puesto el mismo nombre de volumen para los logs que tengo en *traefik* a *crowdsec* porque comparten el mismo fichero de `docker-compose.yml`, pero aqui hay que tener una cosa en cuenta, en caso de que lo tengas en *ficheros / stacks* diferentes tienes que añadir, en el caso de los *logs* de *crowdsec* que afectan a *traefik*, la opción `external: true` porque indicas que los *logs* estan en otro *docker-compose*, si se puede decir asi, quedando de la siguiente manera:
{{< /admonition >}}

```yaml
 volumes:
    crowdsec-db:
      name: crowdsec-db
    crowdsec-config:
      name: crowdsec-config
    traefik_log:
      name: traefik_log
      external: true
```
Una vez que tenemos esto, ya podemos *activar* la primera fase de *crowdsec*:
```bash
usuari@debian:~$docker compose up -d crowdsec
```
Despues de esto, podemos revisar los *logs* de *crowdsec* para ver si de momento vamos por buen camino y tambien podemos verificar si *traefik* aun esta vivo.
```bash
usuari@debian:~$docker logs -f crowdsec
```
{{< admonition note >}}
Si has llegado hasta aqui, el unico fallo que puedes tener es que los *logs* de *traefik* no esten accesibles a *crowdsec*, para eso fijate bien en como *montas* los volumenes.
{{< /admonition >}}

Otra pruebas que puedes hacer es acceder a *crowdsec* y ver si tienes acceso directo a los ficheros de la siguiente manera:
```bash
usuari@debian:~$docker exec -it crowdsec sh
crowdsec:~ cd /var/log/
```
Si llegado a este punto, no ves el directorio de **traefik** es que el error lo tienes en los volumenes. Aqui te tocara investigar un poco 😀 pero en cambio si ves el log de **crowdsec** puedes seguir adelanta con el siguiente paso.

El siguiente paso, es *actualizar* el sistema de alertas o *bugs* que tiene que controlar **crowdsec**. Para hacer esto, se hace de la siguiente manera:
```bash
usuari@debian:~$docker exec crowdsec cscli hub update
```
Por ultimo, es aplicar estas actualizaciones a la **base de datos** de **crowdsec** a traves de:
```bash
usuari@debian:~$docker exec crowdsec cscli hub upgrade
```
Lo que podemos hacer con las actualizaciones de las alertas, es ponerlo en el cron, para que cada dia, en mi caso, se actualize esta **BBDD**. Tu lo puedes poner como quieros, como dice el refran, *para gustos, colores*.

Después de esto, viene la parte más importate de todo, instalar, el contenedor de *bouncer-traefik* o en pocas palabras, el que comunicara *traefik* con *crowdsec*. A lo mejor lo que digo, no es del todo cierto, pero yo lo entiendo de esta manera.

Para hacer esto, solamente necesitamos lo siguiente (yo sigo en el mismo `docker-compose.yml` donde tengo *traefik* y *crowdsec*):
```yaml
 bouncer-traefik:
   image: docker.io/fbonalair/traefik-crowdsec-bouncer:latest
   container_name: bouncer-traefik
   restart: unless-stopped
   networks:
     - proxy
   init: true
   environment:
     CROWDSEC_BOUNCER_API_KEY: XXXXXXXXXXXXXXX
     CROWDSEC_AGENT_HOST: crowdsec:8080
   depends_on:
     - crowdsec
```
Aqui a parte del `depends_on`, donde indicamos a **bouncer-traefik** que no se puede iniciar si antes no esta **crowdsec**, `networks`, lo mismo que con **crowdsec** y **traefik**, los 3 en la misma red. 

{{< admonition note >}}
En este contenedor, lo más importante y con lo que tenemos que tener más cuidado es con `CROWDSEC_BOUNCER_API_KEY`. Es la *API* que nos da *crowdsec* para *bouncer-traefik* y solo aparece una vez, sino te apuntas este codigo, en pocas palabras, tendras que volver a realizar la instalación de *traefik*, *crowdsec* y *bouncer-traefik*. Te lo digo por experiencia. Seguramente hay alguna manera de evitar esto, pero yo no lo he encontrado. Y a demás, asi se aprende algo nuevo.
{{< /admonition >}}

Para obtener el codigo de la **API** se hace a traves de la siguiente instrucción:
```bash
usuari@debian:~$docker exec crowdsec cscli bouncers add bouncer-traefik
```
Que, tal como he dicho antes, nos da el codigo una unica vez y no más. Si quieres lo que puedes hacer primero es guardarlo y luego lo añades donde toca, o sino, lo pones en el fichero `variables.yml` o sino en `.env` para utilizarlo aqui.

Después solamente nos queda *activar* el contenedor:
```bash
usuari@debian:~$docker compose up -d bouncer-traefik
```
Como siempre, pueder verificar los *logs* de **traefik** y **crowdsec** para ver si todo sigue funcionando correctamente o intentando acceder a los servicios. Si puedes, de momento todo va bien.

Ahora lo unico que nos queda es indicar a **traefik** que tiene instalado **crowdsec** y **bouncer-traefik** y que haga uso de ellos. Esto se consigue modificando los siguientes ficheros:

### dynamic.yml
Le indicamos a **traefik** que tiene *bouncer-traefik* en funcionamiento y que puede hacer las consultas mediante la dirección `http://bouncer-traefik:8080/api/v1/forwardAuth`.
```yaml
http:
  middlewares:
    crowdsec-bouncer:
      forwardauth:
        address: http://bouncer-traefik:8080/api/v1/forwardAuth
        trustForwardHeader: true
```

### traefik.yml
En el fichero `traefik.yml` le indicamos en que *consultas* tiene que usar **crowdsec** y esto se hace de la siguiente manera:
```yaml
api:
  dashboard: true

entryPoints:
  web:
    address: ":80"
    http:
      middlewares:
        - crowdsec-bouncer@file
  websecure:
    address: ":443"
    http:
      middlewares:
        - crowdsec-bouncer@file
```
Le estamos indicando que tanto en consultas `http` como en `https` haga las consultas a **crowdsec**.

Cuando ya tenemos **traefik** configurado, solamente nos quedara *recrear* el contenedor de **traefik**:
```bash
usuari@debian:~$docker compose up -d traefik --force-recreate
```
Si volvemos a revisar los *logs* de **traefik** y todo sigue funcionando correctamente es que lo hemos conseguido. Otra prueba que podemos hacer es acceder a los servicios que tenemos en el servidor que si todo funciona bien, tendremos acceso, sino, la hemos cagado 💩

{{< admonition note >}}
Ahora pasamos a ver el funcionamiento de **crowdsec** en vivo, esto lo podemos hacer de la siguiente, pero os informo, queda a vuestra libre elección. Esta prueba, consiste en bloquear nuestra ip de acceso al servidor. Esto se hace de la siguiente manera:
{{< /admonition >}}

```bash
usuari@debian:~$docker exec crowdsec cscli decisions add --ip nuestra_ip_de_acceso
```
Una vez que *hemos baneado nuestra propia ip*, para asegurarnos de ello, pasamos a verificar que es asi mediante:
```bash
usuari@debian:~$docker exec crowdsec cscli decisions list
```
Donde veremos que, ciertamente, hemos baneado nuestra ip. Y para ver como funciona, nos conectamos a los servicios que tenemos alojados en el VPS / servidor y nos tiene que aparecer el mensaje de **forbidden**. Pero tranquilo, no te asustes para revertir este *baneo* tenemos que hacer la instruccion contraria:
```bash
usuari@debian:~$docker exec crowdsec cscli decisions delete --ip nuestra_ip_de_acceso
```
Si volvemos a ejecutar la orden:
```bash
usuari@debian:~$docker exec crowdsec cscli decisions list
```
Nos tiene que aparecer el mensaje de *No active decisions*. Ya puedes respirar 🥳. 

Tambien, puedes ver un poco lo que esta haciendo **crowdsec** y **traefik**, para ello puedes usar las siguientes instrucciones:
```bash
### CONTROLAS LAS OPCIONES ACTIVADAS QUE TIENE CROWDSEC
usuari@debian:~$docker exec crowdsec cscli metrics
```
Con esto:
```bash
### CONTROLAS LOS BANEOS QUE SE HAN PRODUCIDO EN TU SERVIDOR
usuari@debian:~$docker exec crowdsec cscli alerts list
```
Con esto podemos dar por concluida la instalación de **crowdsec** y **bouncer-traefik** juntamente con **traefik** en nuestro *servidor / VPS*.

Espero que te sirva y que puedas aprender tanto como he aprendido yo.
#### Referencia
- [Documentación - CrowdSec & Traefik Tutorial](https://technotim.live/posts/crowdsec-traefik)
- [Video - CrowdSec & Traefik Tutorial](https://www.youtube.com/watch?v=-GxUP6bNxF0)
- [528 - Más herramientas para proteger tu Linux](https://atareao.es/podcast/mas-herramientas-para-proteger-tu-linux/)
- [GitHub Atareao - Traefik](https://github.com/atareao/self-hosted/blob/main/traefik/traefik.yml)
- [GitHub Atareao - Crowdsec](https://github.com/atareao/self-hosted/blob/main/crowdsec/docker-compose.yml)

