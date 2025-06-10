# Instalando y configurando Traefik

Aprovenchando que tengo el [nuevo VPS](/2024-04-17-nuevo-VPS) queria ponerle [traefik](/2024-04-19-traefik) y que además se puede hacer a traves de docker y asi poder aprovechar todas las posibilidades que nos da. Al final (cuando estoy escribiendo esto) lo tengo todo en funcionamiento, pero me ha costado horrores y aqui os explico mi odisea.

<!--more-->

Lo que primero que hice, fue empaparme muy bien de los videos de [atareao](https://atareao.es) donde explica el proceso que uso el para su instalación. Os aconsejo que empeceis con estos 2:
- [Video 1](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik)
- [Video 2](https://atareao.es/tutorial/self-hosted/mil-servicios-con-traefik)

Tiene unos cuantos más, pero lo mejor es ir directamente a la fuente, yo he puesto los que más han hecho servicio.

Lo primero de todo es crear el fichero de `docker-compose.yml` que en mi caso, es el siguiente:

### docker-compose.yml
```yaml
traefik:
  image: traefik:v2.11.2
  container_name: traefik
  init: true
  restart: unless-stopped
  security_opt:
    - no-new-privileges:true
  # ES LA RED QUE FARA SERVI TRAEFIK I QUE UTILIZAREM PER A LA RESTA DE SERVEIS
  # QUE VULGUEM CONECTAR AMB TRAEFIK
  networks:
    - proxy
  ports:
    - 80:80
    - 443:443
  environment:
    - TZ=Europe/Madrid
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock:ro
    - ${HOME}/config/traefik/traefik.yml:/traefik.yml:ro
    - ${HOME}/config/traefik/dynamic.yml:/dynamic.yml:ro
    - ${HOME}/config/traefik/users.txt:/users.txt:ro
    - ${HOME}/config/traefik/acme.json:/acme.json
    - logs:/var/log/traefik
  labels:
    - traefik.enable=true
    - traefik.http.services.traefik.loadbalancer.server.port=80
    - traefik.http.routers.traefik-secure.entrypoints=websecure
    - traefik.http.routers.traefik-secure.rule=Host(`${TRAEFIK_SERVER}`)
    - traefik.http.routers.traefik-secure.middlewares=myauth@file
    - traefik.http.routers.traefik-secure.service=api@internal
    - traefik.http.routers.traefik-secure.tls=true
    - traefik.http.routers.traefik-secure.tls.certresolver=letsencrypt

volumes:
  logs: {}
# XARXA PER A TRAEFIK
networks:
  internal: {}
  proxy:
    external: true
```
{{< admonition warning >}}
Antes de lanzarnos a la piscina con la instalación, tenemos que tener en cuenta 2 cosas, en mi caso estoy usando un fichero `.env` donde tengo las variables, los passwords y las URL que utilizo:
- `${HOME}` que es el directorio *HOME* de mi usuario
- `${TRAEFIK_SERVER}` que es la *URL* de acceso a este servicio.
{{< /admonition >}}

Una vez tenemos el fichero, lo siguiente y antes de ponerlo en marcha es mejor crear los 4 ficheros que necesita para su correcto funcionamiento que son los siguientes:

### traefik.yml
```yaml
api:
  dashboard: true

entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
          permanent: true
  websecure:
    address: ":443"
    http:
      tls:
        certresolver: letsencrypt

serversTransport:
  maxIdleConnsPerHost: 1

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
    watch: true
    network: proxy
  file:
    filename: /dynamic.yml

log:
  level: INFO
  filePath: "/var/log/traefik/traefik.log"
accessLog:
  filePath: "/var/log/traefik/access.log"
  bufferingSize: 100
  fields:
    defaultMode: keep
    names:
      ClientUsername: keep
    headers:
      defaultMode: keep
      names:
        Content-Type: keep
        X-Forwarded-For: keep
  filters:
    statusCodes:
      - "300-302"
      - "400-409"
    retryAttempts: true
    minDuration: "10ms"
    
certificatesResolvers:
  letsencrypt:
    acme:
      email: elteu@email.com
      storage: acme.json
      httpChallenge:
        entryPoint: web
# ESTIC FEN PROVES PER VEURE COM FUNCIONA
# PERO DE MOMENT NO TINC SORT
#experimental:
#  plugins:
#    GeoBlock:
#      moduleName: "github.com/PascalMinder/geoblock"
#      version: "v0.2.5"
```

### dynamic.yml
```yaml
# FITXER ON ESTAN, EN AQUEST CAS LA CONFIGURACIÓ DE LA SEGURETAT PER ACCEDIR ALS LLOCS
http:
  middlewares:
    myauth:
      basicAuth:
        usersfile: /users.txt
```
Ahora en el caso de querer securizar (pedir usuario y password) para acceder a los servicios que tenemos detras de *traefik*, se puede hacer a traves del archivo:
```bash
usuari@debian:~$ls -l users.txt
```
Para añadir los usuarios que tienen acceso, se realiza con la siguiente orden:
```bash
usuari@debian:~$sudo apt install apache2-utils
usuari@debina:~$htpasswd -nb usuario contraseña >> users.txt
```
Ahora el archivo que contendra los certificados:
```bash
usuari@debian:~$ls -l acme.json
```
Pero antes de nada, tenemos que crear la `red proxy`, porque sino, luego a la hora de hacer el *docker compose* no dara error. Esto se hace de la siguiente manera:
```bash
usuari@debian:~$docker network create proxy
```
Una vez que ya tenemos todo preparado solamente nos falta decir las palabras magicas
```bash
usuari@debian:~$docker compose up -d traefik
```
Como podeis observar, estoy haciendo uso de `docker compose` y no de `docker-compose`. Esto se debe, creo, que con las nuevas versiones, se ha unificado, lo que antes era un paquete solo `docker-compose` y lo han convertido en una opción más de *docker*.

Si todo va bien, ya lo tenemos en funcionamiento y además, con el certificado SSL para conectarnos al **dashboard** y si hemos activado la seguridad de acceso a traves de usuarios, antes del acceso, nos pedira el usuario y password.

Con esto, ya tenemos la instalación de traefik en marcha. Ahora viene lo más dificil, que es configurar el resto de servicios para que hagan uso de **traefik** y poder usarlo.
{{< admonition note >}}
Aqui tengo que informar que el fichero `docker-compose.yml` de *traefik* ha sufrido algunas modificaciones como consecuencia de lo que podeis leer en este [articulo], quedando de la siguiente manera:
{{< /admonition >}}
```yaml
  labels:
    - traefik.enable=true
    - traefik.http.services.traefik.loadbalancer.server.port=80
    - traefik.http.routers.traefik-secure.entrypoints=websecure
    - traefik.http.routers.traefik-secure.rule=Host(`${TRAEFIK_SERVER}`)
    - traefik.http.routers.traefik-secure.middlewares=myauth@file
    - traefik.http.routers.traefik-secure.service=api@internal
#    - traefik.http.routers.traefik-secure.tls=true
#    - traefik.http.routers.traefik-secure.tls.certresolver=letsencrypt
```
#### Referencia
- [532 - Exprimiendo tu proxy inverso Traefik](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik)
- [Mil servicios con Traefik](https://atareao.es/tutorial/self-hosted/mil-servicios-con-traefik)

