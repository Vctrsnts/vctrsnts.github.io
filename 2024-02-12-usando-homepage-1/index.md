# Usando HomePage. El Dashboard

Despúes de escuchar el [podcast](https://ugeek.github.io/post/2021-05-24-homer-mi-dashboard-favorito.html) de **uGeek** donde hablaba de los **dashboard** y en especial del que el usaba, **Homer**, me decidi a probarlo a ver que tal funcionaba la cosa, porque la idea de tener todo lo que más utilizo al alcance de la mano o la información más importante de tu servidor siempre disponible, pues es interesante. Asi que me decidi a instalar y probar **Homer**.

<!--more-->

Al principio, no necesitaba nada más, pero poco a poco, cuanto más te adentras en el mundo de los **dashboards**, ves las infinitas posibilidades que tienes a tu alcance y que en el caso de **Homer** no me lo daba. Asi que, me decibi a buscar otros que pudieran ampliar la información que me podian mostrar y no encontraba el más adecuado hasta que lei el [articulo](https://elblogdelazaro.org/posts/2023-06-21-docker-homepage-dashboard/) de **Lazaro** donde hablaba de [HomePage](https://github.com/gethomepage/homepage) y de las multiples opciones que tenia. Y puedo decir que si, tiene muchas opciones de configuración que te pueden ayudar a visualizar toda la información que puedas necesitar.

Como además, **Homer** tambien tiene esta posibilidad, se podia usar a traves de **docker** que más se podia pedir. Asi que me dispuse a crear el container de **HomePage**. En mi caso, todo lo tengo concentrado en un fichero `yaml` que contine todos los dockers que uso:
```yaml
homepage:
  image: ghcr.io/gethomepage/homepage:latest
  container_name: homepage
  restart: unless-stopped
  ports:
    - 2000:3000
  environment:
    PUID: 1000
    PGID: 1000
  volumes:
    - ${STORAGE}/config/homepage:/app/config
    - /var/run/docker.sock:/var/run/docker.sock
  labels:
    - diun.enable=true
```
Asi se quedo, con un par de opciones más, **transmission**, **navidrome**, **jellyfin** y el uso de **CPU**, **Memoria** y **HDD** del servidor. Con esto ya lo tenia todo. Pero como dice el refran, siempre deseas lo que tienen los otros... Y asi sucedio...

Aqui tengo que hacer un inciso, porque a parte de tener el **dashboard** de **HomePage** otra de las muchas cosas que siempre quiero controlar, es el estado de los 2 servidores que tengo ahora mismo (el servidor local y el servidor de Oracle) y esto lo podia controlar a traves del docker **Glances** que conoci después de leer el [articulo](https://atareao.es/software/utilidades/glances-una-potente-alternativa-al-monitor-del-sistema/) que hizo [Lorenzo](https://atareao.es) donde hablaba de el. Una versión resumida de este articulo, es que **Glances** es una especió de **htop** pero vitaminado. 

Asi que tambien lo instale, porque con el podia obtener toda la informació (accediendo a ella a traves de la web) de los 2 servidores.
```yaml
glances:
  image: nicolargo/glances:latest-full
  container_name: glances
  restart: unless-stopped
  pid: host
  privileged: true
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
    - /run/user/1000/podman/podman.sock:/run/user/1000/podman/podman.sock
    - ${STORAGE}/config/glances/glances.conf:/glances/conf/glances.conf
  environment:
    - TZ='Europe/Madrid'
    - "GLANCES_OPT=-C /glances/conf/glances.conf -w"
  ports:
    - 61208:61208
```
Sin saberlo tenia todo lo necesarió para obtener mucha más información de la que me estaba facilitando **HomePage** hasta el momento y que yo desconocia que se podia obtener, hasta que en el canal de Telegram de [HomeLabs.club](https://homelabs.club) empezaron a hablar de ello y de las multiples posibilidades que habia, junto con una captura de pantalla de toda la información que se podia obtener. Y yo, tenia a mi disposición toda esa información, pero desconocia como obtenerla.

Después de pedir ayuda o si me podian facilitar los archivos de configuración que usaban, me podian servir como base para asi yo poder hacer mi configuración. Hay que remarcar, que para configurar **HomePage** se necesitan de 5 archivos **yaml** donde:

#### settings.yaml
```yaml
#
# La configuració basica del dashboard (color de fons, idioma, disposició de la informació, etc...)
#
title: HomePage
language: ca

color: slate
headerStyle: boxed
hideVersion: true
useEqualHeights: true

layout:
 servidoLocal:
   header: false
   style: columns
   columns: 3

 Oracle:
   header: false
   style: columns
   columns: 3

 Dockers:
   header: false
   style: row
   columns: 3

 Media:
   header: false
   style: row
   columns: 2
```
#### services.yaml
```yaml
#
# Es configuran els serveis que volem visualitzar per pantalla
#
- servidorLocal:
  - Network:
      widget:
        type: glances
        url: [url]
        metric: network:eth0
        chart: false
  - Memory:
      widget:
        type: glances
        url: [url]
        metric: memory
        chart: false
  - Process:
      widget:
        type: glances
        url: [url]
        metric: process
        
- Oracle:
  - Network:
      widget:
        type: glances
        url: [url]
        metric: network:eth0
        chart: false
  - Memory:
      widget:
        type: glances
        url: [url]
        metric: memory
        chart: false
  - Process:
      widget:
        type: glances
        url: [url]
        metric: process
        
- Dockers:
  - Transmission:
      icon: transmission
      href: [url]
      description: Servidor Transmission
      container: transmission
      widget:
        type: transmission
        url: [url]
        username: [usuari]
        password: [password]
  - aMule:
      icon: https://raw.githubusercontent.com/amule-project/amule/master/amule.png
      href: [url]
      description: Servidor aMule
      container: amule
  - Jackett:
      icon: jackett.png
      href: [url]
      description: Servidor Indexers
      container: jackett
      widget:
        type: jackett
        url: [url]
  - PiHole:
      icon: pi-hole.png
      href: [url]
      description: Servidor PiHole
      container: pihole
      widget:
        type: pihole
        url: [url]
        key: [key]
  - SpeedTest:
      icon: https://cdn.icon-icons.com/icons2/3053/PNG/512/speedtest_macos_bigsur_icon_189707.png
      href: [url]
      container: speedtest
      widget:
        type: speedtest
        url: [url]
  - Scrutiny:
      icon: https://repository-images.githubusercontent.com/289524449/fc01e480-e6ab-11ea-9e20-53257df6f326
      href: [url]
      container: scrutiny
      widget:
        type: scrutiny
        url: [url]
        
- Media:
  - Jellyfin:
      icon: jellyfin.png
      href: [url]
      description: Servidor Multimedia
      container: jellyfin
      widget:
        type: jellyfin
        url: [url]
        key: [key]
  - Navidrome:
      icon: navidrome
      href: [url]
      description: Servidor Musica
      container: navidrome
      widget:
        type: navidrome
        url: [url]
        user: [usuari]
        token: [token]
        salt: [salt]
```
Lo que podeis hacer, yo lo tengo montado, más información en este [articulo](/2024-01-10-searxng-uno-todo), es tener montado vuestro propio buscador y hacer todas las busquedas en el y asi confundirr en todo lo posible al **Gran Hermano**.

#### widgets.yaml
```yaml
#
# On es pot configurar el teu buscador preferit o visualitzar diverses informacions del teu servidor
# En el meu cas, visualitzar la informació (CPU, MEMORIA, UPTIME) de 2 servidores diferents (servidor local i Oracle)
#
- glances:
  url: [url]
  label: servidorLocal
  cpu: true
  mem: true
  uptime: true

- glances:
  url: [url]
  label: Oracle
  cpu: true
  mem: true
  uptime: true

- search:
  provider: custom
  url: [url]
  focus: true
  target: _blank

- datetime:
  locale: nl
  text_size: xs
  format:
    dateStyle: short
    timeStyle: short
    hourCycle: h23
```

#### bookmarks.yaml
```yaml
#
# links a les pagines web més utilizades en el meu cas
#
- Blogs:
  - Personal:
      - href: [url]
        icon: github-light.png
  - uGeek:
      - href: [url]
        icon: blogger.png
  - Lazaro:
      - href: [url]
        icon: blogger.png
  - EruenPlay:
      - href: [url]
        icon: youtube.png

- Social:
  - Mastodon:
      - href: [url]
        icon: mastodon.png
  - Telegram:
      - href: [url]
        icon: telegram.png
  - RiseUp:
      - href: [url]
        icon: mailu.png
```
Teoricamente, con esta configuración tendria que funcionar todo correctamente y realizar la integración correctamente con docker, pero no era asi. En mi caso, no veia ningun tipo de información relacionada con los dockers. Y todo lo que encontraba, es que esto tenia que funcionar si o si.

Entonces me puse a buscar información del motivo por el cual en mi caso no me funcionaba, tambien lo pregunte en el canal, pero todo el mundo me decia que tenia que funcionar correctamente y sin ningun problema, hay que tener en cuenta una cosa, en el canal de Telegram cuando exponia mi problema, todos los que me decian que tenia que funcionar correctamente, lo tenian instalado en [Unraid](https://unraid.net/) y seguramente **UnRaid** hace alguna cosa para que funcione automaticamente, cosa que si tu lo haces manualmente y sin **UnRaid** no funciona. 

Despues de buscar, encontre en la documentación que hacia referencia a [docker](https://gethomepage.dev/v0.7.4/configs/docker/#using-docker-socket-proxy) en **HomePage** que para que la integración funcionase correctamente se tenia que instalar un **proxy** que es el que realiza la comunicación entre **docker** y **HomePage**.

Para ello, se necesitaba el siguiente container:
```yaml
dockerproxy:
  image: ghcr.io/tecnativa/docker-socket-proxy:latest
  container_name: dockerproxy
  environment:
    - CONTAINERS=1 # Allow access to viewing containers
    - SERVICES=1 # Allow access to viewing services (necessary when using Docker Swarm)
    - TASKS=1 # Allow access to viewing tasks (necessary when using Docker Swarm)
    - POST=0 # Disallow any POST operations (effectively read-only)
  ports:
    - 127.0.0.1:2375:2375
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock:ro # Mounted as read-only
  restart: unless-stopped
```
Una vez que ya lo tienes en funcionamiento, solamente tienes que configurar en el archivo `docker.yaml` de la siguiente manera:

#### docker.yaml
```yaml
#
# Per a realitzar la integració de docker amb HomePage i visualitzar tota la informació dels contenidors
#
my-docker:
  host: dockerproxy
  port: 2375
```
Una vez esto, solamente tenemos que añadir en el archivo `services.yaml` la opción `server` de la siguiente manera:
```yaml
- Dockers:
    - Transmission:
        icon: transmission
        href: [url]
        description: Servidor Transmission
        # AQUI VA LA MODIFICACIÓ NECESSARIA PER A LA COMUNICACIÓ AMB DOCKER
        server: my-docker
        # I EL NOM DEL CONTAINER
        container: transmission
        widget:
          type: transmission
          url: [url]
          username: [usuari]
          password: [password]
```
Al final si, ya lo tenia todo funcionando correctamente. Pero cuando comente de la solución que habia tomado en el canal de Telegram, me dijeron que no hacia falta tener un contener más para que todo funcionase correctamente, sino que solamente hacia falta crear el siguiente fichero `override.conf` de la siguiente manera:
```bash
usuari@debian:/sudo mkdir /etc/systemd/system/docker.service.d
```

#### /etc/systemd/system/docker.service.d/override.conf
```yaml
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd=/run/containerd/containerd.sock
```
Luego, solamente nos queda reiniciar el servicio del `daemon` y `docker`:
```bash
usuari@debian:/sudo systemctl daemon-reload
usuari@debian:/sudo systemctl restart docker.service
# CON LA SIGUIENTE INSTRUCCION PODEMOS COMPROBAR QUE EL DEMONIO DE DOCKER ESTA FUNCIONANDO CORRECTAMENTE Y EL PUERTO ASIGNADO
usuari@debian:/sudo netstat -lntp | grep dockerd
```
Si todo ha ido bien, ya podemos detener el container `dockerproxy` y proceder a modificar ya por ultima vez el archivo `docker.yaml` de **HomePage** de la siguiente manera:

#### docker.yaml
```yaml
my-docker:
  host: [IP SERVIDOR]
  port: 2375
```
Con esto ya lo tendriamos todo en funcionamiento y para que veais como lo tengo en mi caso:

![](/images/screenshot_003.png "Screenshot")

Pero eso si, como dice el refran **para gustos, colores**. Vosotros podeis hacerlo a vuestro gusto.
#### Referencia
- [Homer. Mi Dashboard](https://ugeek.github.io/blog/post/2021-05-24-homer-mi-dashboard.html)
- [Docker: Homepage dashboard](https://elblogdelazaro.org/posts/2023-06-21-docker-homepage-dashboard/)
- [Glances una potente alternativa al Monitor del Sistema](https://atareao.es/software/utilidades/glances-una-potente-alternativa-al-monitor-del-sistema/)
- [HomePage - Docker](https://gethomepage.dev/v0.7.4/configs/docker/#using-docker-socket-proxy)

