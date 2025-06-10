# Servicio para actualizar imagenes docker

Como he tenido malas experencias a la hora de usar servicios para mantener las imagenes actualizadas, he cambiado el servició que tenia actualmente **whatsup** por **cup**.

<!--more-->

En estos 3 articulos donde explico todo el proceso:
- [Usando watchtower](/2023-01-25-usando-watchtower)
- [Cambiando watchtower por diun](/2023-02-19-actualizacion-watchtower)
- [Donde digo dije, digo Diego](/2023-04-29-donde-dije-digo-digo-diego)

Pero no me hacia mucha gracia, asi que cambie a **Whatsup**, pero me volvia un poco loco y buscaba algo más facil y simple, que simplemente me informara de lo que hay, sin tantas complicaciones como me daba **Whatsup**.

Hasta que encontre este [articulo](https://elblogdelazaro.org/posts/2024-10-04-comprueba-las-actualizaciones-de-tus-imagenes-docker-con-cup-docker) en el **blog de lazaro** donde daba una alternativa a **Whatsup**. Este nuevo servicio es [cup](https://github.com/sergi0g/cup), donde el funcionamiento es muy parecido a **Whatsup** pero más simple.

Asi que me lei el articulo y me resulto muy interesante asi que lo he instalado en mi servidor y me ha gustado mucho y lo he dejado instalado porque me parece muy interesante. Aunque tiene algunos errores, ten en cuenta, que este servicio esta en construcción, asi que a lo mejor cuando uses tu, el error que tengo yo (no puedo cambiar el tema de la web), puede que este ya solucionado, pero...

La instalación es muy simple. Yo en mi caso lo he instalado a traves de `docker-compose` de la siguiente manera:
```yaml
cup:
  image: ghcr.io/sergi0g/cup:latest
  container_name: cup # Optional
  restart: unless-stopped
  networks:
    - internal
  command: -c /config/cup.json serve
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    - ${HOME}/config/cup/cup.json:/config/cup.json
  labels:
    - traefik.enable=true
    - traefik.http.services.cup.loadbalancer.server.port=${PORT}
    - traefik.http.routers.cup.entrypoints=websecure
    - traefik.http.routers.cup-secure.middlewares=myauth@file
    - traefik.http.routers.cup.rule=Host(`${CUP_SERVER}`)
```
Como podeis ver, en mi caso, uso **traefik** por eso tengo las respectivas etiquetas. Pero funciona de la misma manera sin estas etiquetas, pero si es asi, tienes que añadir el puerto que quieres usar:
```yaml
cup:
  ports:
    - 8000:8000
```
Con esto tendras una pagina web, a la que accederas desde el puerto que tu indiques y veras los servicions que estan disponibles junto con los que tienen disponible la actualización.

A parte de tener este servicio, se que podria usar **diun**, volver a **whatsup** o **watchtower**, tambien me he echo un script en `bash` para actualizar los servicios más facilmente, lo hago yo manualmente, pero me resulta más comodo de esta manera, pero para simplificar las instrucciones necesarias. 

El script tiene lo siguiente:
```bash
   #!/bin/bash

   for param in "$@"; do
     docker compose pull $param && docker compose up -d $param && docker image prune
   done
```
Se usa de la siguiente manera:
```bash
usuari@debian:~$ sh update_docker.sh docker_1 docker_2 ...
```
Con esto ya he finalizado este articulo rapido y facil. Que ha veces son los más dificiles de hacer.
#### Referencia
- [Pasar parámetros Bash script desde la Shell](https://es.ccm.net/ordenadores/linux/2368-bash-los-parametros)
- [Comprueba las actualizaciones de tus imágenes docker con cup](https://elblogdelazaro.org/comprueba-las-actualizaciones-de-tus-im%C3%A1genes-docker-con-cup/)

