# Usando Traefik - 3

Como recordais hice 2 articulos donde en el [primero articulo](/2024-05-06-usando-traefik-1) explicaba como se podia usar **traefik** con otros servicios de docker y en el [segundo articulo](2024-05-13-usando-traefik-2.md), explicaba como se le podia añadir una capa más de seguridad a nuestro servicio de *traefik* que consistia en bloquear las peticiones de paises de nuestra lista negra.

En este 3º articulo, explicare unas modificaciones que, como siempre me pasa, no acabe de entender al leer el articulo principal de [atareao](https://www.atareao.es){:target="_blank} y que gracias, no se si por inspiración divida de *Lorenzo* he acabado de entender.

<!--more-->

Estas modificaciones, si te fijas bien, en el articulo de *Atareao* y que esta al final, comenta que después de lo que se ha hecho, hay suficiente con estas lineas:
```yaml
- traefik.enable=true
- traefik.http.services.jellyfin.loadbalancer.server.port=8096
- traefik.http.routers.jellyfin.entrypoints=websecure
- traefik.http.routers.jellyfin.rule=Host(`${FQDN}`)
``` 
Para que *traefik* tenga en cuenta el servicio que nosotros le estamos indicando y lo configure correctamente e incluso con un certificado de **letsncrypt**. En el caso de **Lorenzo** el lo explica para *Jellyfin*, pero en mi caso, lo explicare para **rss-funnel**, que es el servicio de ejemplo que utilice en el primer articulo. Tambien pondre las modificaciones necesarias que se tiene que hacer en los ficheros de configuración de *traefik*.

Como podeis recordar en la configuración de `rss-funnel` del primer articulo, lo tenia configurado de la siguiente manera:
```yaml
 rssFunnel:
  image: ghcr.io/shouya/rss-funnel:latest
  container_name: rssFunnel
  restart: unless-stopped
  networks:
    - proxy
  ports:
    - 33333:4080
  volumes:
    - ${HOME}/config/rss-funnel/funnel.yaml:/funnel.yaml
  environment:
    RSS_FUNNEL_CONFIG: /funnel.yaml
    RSS_FUNNEL_BIND: 0.0.0.0:PORT
  labels:
    - traefik.enable=true
    - traefik.http.services.rssFunnel.loadbalancer.server.port=4080
    - traefik.http.routers.rssFunnel.entrypoints=web
    - traefik.http.routers.rssFunnel.rule=Host(`${PODCAST_SERVER}`)
    - traefik.http.middlewares.rssFunnel-https-redirect.redirectscheme.scheme=websecure
    - traefik.http.routers.rssFunnel.middlewares=rssFunnel-https-redirect
    - traefik.http.routers.rssFunnel-secure.entrypoints=websecure
    - traefik.http.routers.rssFunnel-secure.rule=Host(`${PODCAST_SERVER}`)
    - traefik.http.routers.rssFunnel-secure.tls=true
    - traefik.http.routers.rssFunnel-secure.tls.certresolver=letsencrypt
```
Pero siguiendo las pautas que ha dado *atareao*, tendria que quedar de la siguiente manera:
```yaml
 rssFunnel:
  image: ghcr.io/shouya/rss-funnel:latest
  container_name: rssFunnel
  restart: unless-stopped
  networks:
    - proxy
  volumes:
    - ${HOME}/config/rss-funnel/funnel.yaml:/funnel.yaml
  environment:
    RSS_FUNNEL_CONFIG: /funnel.yaml
    RSS_FUNNEL_BIND: 0.0.0.0:PORT
  labels:
    - traefik.enable=true
    - traefik.http.services.rssFunnel.loadbalancer.server.port=4080
    - traefik.http.routers.rssFunnel.entrypoints=websecure
    - traefik.http.routers.rssFunnel.rule=Host(`${PODCAST_SERVER}`)
```
Como veis, he quitado toda la parte del puerto, la sección del certificado y la sección de la redirección porque de todo esto, se encarga *traefik*, esto es como consecuencia de que en el fichero `traefik.yml` hemos puesto lo siguiente:
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
```
Que es el encargado de crear automaticamente los certificados de todos los dominios que ponemos con *traefik*. Y os puedo decir que funciona perfectamente.

Lo he aplicado a los siguientes contenedores:
- [SearxNG](/2024-01-10-searxng-uno-todo)
- [rss-Funnel](/2024-04-13-uno-juntarlos-todos)
- [Traefik](/2024-04-19-traefik)

Funciona de fabula. Como dice el dicho, nunca te iras a dormir sin conocer una nueva cosa.

Después de esto lo ultimo que me falta es ponerme con **crowdsec** que, una vez más, siempre habia pensado que era un *plugin* que se añadia a *traefik* y no, es un contenedor más con su respectiva configuración.

Pero ahora estoy más tranquilo, porque entiendo un poco más como funciona el mundo de *traefik* y con ayuda de la excelente documentación que tiene *Atareao* con respecto a esto, creo que no tendre ningun problema en implementarlo en mi servidor.

Como dice el dicho **La suerte favorece a los valientes**
#### Referencia
- [532 - Exprimiendo tu proxy inverso Traefik](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik)

