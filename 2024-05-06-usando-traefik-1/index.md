# Usando Traefik - 1

Como os explique en este [articulo](/2024-04-19-traefik), aprovechando que tenia nuevo VPS, queria sacarle el maximo partido y después de haber instalado **traefik** aun tenia más ganas.

Y aqui es donde os aviso, he estado 3 dias intentando hacerlo funcionar correctamente y hasta que al final, me vino una **inspiración** y pude conseguir que funcionara correctamente.

<!--more-->

Lo más importante es que como base, sigo los articulos que ha posteado [atareao](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik) que podeis encontrar en su pagina web y la información que tiene en [gitHub searxNG](https://github.com/atareao/self-hosted/tree/main/searxng) que explica con un ejemplo muy claro, aunque hay que remarcar que cuesta de seguirle el ritmo, como usar **traefik** pero ya junto con los contenedores de docker.

En mi caso, os pondre la configuración que he usado, que puede seros de mucha ayuda asi como el problema que tuve y que me volvio loco.

Partiendo de la base, que el archivo `docker-compose.yml` y los archivos `traefik.yml`, `dynamic.yml`, `users.txt` y `acme.json` que estais utilizando son los mismo que puse en el anterior [articulo](/2024-04-19-traefik) donde hablaba de **traefik**, ahora, lo más normal seria poder sacarle todo el potencial que tiene traefik y para eso, os voy a explicar como lo uso, para el servicio [rssFunnel](2024-04-13-uno-juntarlos-todos.md) que tengo activo.

Todo empieza en la configuració del **docker-compose** de dicho servició y para ello, se tiene que hacer añadir las siguientes lineas:
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
Partimos de la base, de que este servició lo tenemos configurado para el puerto **33333** que lo redirigira hacia el puerto **4080** por defecto de **rssFunnel**.

Lo que tambien tenemos que tener en cuenta, es que tenemos que configurar este servicio para que use la misma red que **traefik**, que en este caso es **proxy**. Después de esto vienen las 9 lineas magicas que hace que todo funcione correctamente y que me volvio loco durante 3 dias, y estas lineas son las siguientes:
```yaml
labels:
  # INDICAMOS A TRAEFIK QUE CONTROLE ESTE SERVICIO
  - traefik.enable=true
  # AQUI ES DONDE ESTA LA MADRE DEL CORDERO. LO MAS IMPORTANTE DE TODO Y QUE SI NO LO TENEMOS BIEN
  # NO VA A FUNCIONAR
  # INDICAMOS A TRAEFIK, QUE TODO LO QUE VENGA A ESTE SERVICIO LO REDIRIGA DIRECTAMENTE AL PUERTO POR DEFECTO 4080
  # NO AL 33333 QUE TENEMOS CONFIGURADO NOSOTROS.
  - traefik.http.services.rssFunnel.loadbalancer.server.port=4080
  # QUE TIPO DE ACCESO TENDRA (WEB - 80, WEBSECURE - 443)
  - traefik.http.routers.rssFunnel.entrypoints=web
  # NOMBRE DEL DOMINIO QUE LO TENEMOS DEFINIDO EN UN FICHERO .ENV
  - traefik.http.routers.rssFunnel.rule=Host(`${PODCAST_SERVER}`)
  # QUE ACCIÓN TIENE QUE REALIZAR. EN ESTE CASO, TIENE QUE REDIRIGIR A WEBSECURE
  - traefik.http.middlewares.rssFunnel-https-redirect.redirectscheme.scheme=websecure
  - traefik.http.routers.rssFunnel.middlewares=rssFunnel-https-redirect
  - traefik.http.routers.rssFunnel-secure.entrypoints=websecure
  # NOMBRE DE DOMINIO EN EL CASO DE WEBSECURE
  - traefik.http.routers.rssFunnel-secure.rule=Host(`${PODCAST_SERVER}`)
  # ACTIVAMOS EL CERTIFCADO SSL
  - traefik.http.routers.rssFunnel-secure.tls=true
  # CREAMOS EL CERTIFICADO SSL
  - traefik.http.routers.rssFunnel-secure.tls.certresolver=letsencrypt
```
En el fichero `.env`, en mi caso, lo tengo de la siguiente manera:
```bash
# ADRECES PER A SERVIDOR TRAEFIK
PODCAST_SERVER=dominio.duckdns.org
```
Con esto, solamente tendremos que hacer un:
```bash
usuari@debian:~$docker compose up -d traefik rssfunnel
```
Para actualizar / reconstruir el servicio de **traefik** y de **rssfunnel** si es que ya lo teniamos instalado.

Proximamente ire subiendo más articulos con mis avances sobre **traefik**.
#### Referencia
- [532 - Exprimiendo tu proxy inverso Traefik](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik)

