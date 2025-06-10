# Usando HomePage. El Dashboard - 2

Como ya comente en el anterior [articulo](/2024-02-12-usando-homepage-1)  donde hablaba de que estaba usando **HomePage** con una configuración *normal* y muy *simple*, pero que a la vez era funcional, por no decir basica para cuando te inicias, pero me faltaba algo, en resumen, queria algo más...

<!--more-->

Entonces buscando información, acabe en el [github](https://www.github.com/gethomepage), que es lo que tenia que haber echo desde el principio, descubri esta [hilo](https://github.com/gethomepage/homepage/discussions/473) donde la gente, compartia sus *dashboards* junto con los ficheros de configuración. Y tengo que decir que habia cosas muy chulas y muy curradas y lo más importante, cosas que no sabia que se podian hacer.

Mirando lo que la gente subia, encontre uno, no fui el unico que pregunto, que era increible y muy funcional porque tenias al alcance toda la información que necesitabas.

Asi que toda la gente, le pidio si podia pasar 😁 los ficheros de configuración que usaba y le tengo que estar muy agradecido porque subio los ficheros de configuración que el usaba y que me sirvio para *estudiar* como lo tenia todo montado. Asi que lo adapte a mis necesidades quedando de la siguiente manera (en mi caso):

### Pestaña Home
![](/images/screenshot_004.png "ScreenShot")

### Pestaña Glances
![](/images/screenshot_005.png "ScreenShot")

Como se puede ver, uso dos *pestañas* donde en la primera pestaña se puede visualizar:
- La información de todos los *dockers* que uso junto con los links a las webs que más uso.
- Toda la información (graficas) de los 2 servidores, que tengo ahora mismo.

En el `settings.yaml` es donde se configuran los *tabs* o mejor dicho, las *pestañas*. Esto se consigue a traves de la variable **tab**, que es donde indicamos a que pestaña pertenece cada *sección*. Para que quede más claro, se puede decir que en la pestaña `tab: Home` tendremos lo siguiente:
- Virtualization
- Monitoring
- Media
- Network

En cambio, en la pestaña `tab: Glances` tendremos lo siguiente:
- Graficas *Servidor 1*
- Graficas *Servidor 2*

Ahora viene lo más importante, los ficheros de configuración que estoy usando:

#### settings.yaml
```yaml
#### Customization
headerStyle: clean
cardBlur: md
theme: dark
color: zinc
quicklaunch:
  searchDescriptions: true
  hideInternetSearch: false
  showSearchSuggestions: true
  hideVisitURL: false

#### Group layouts
layout:
### Homepage
  Virtualization:
    tab: Home
    icon: mdi-desktop-classic
  Monitoring:
    tab: Home
    icon: mdi-message-alert
  Media:
    tab: Home
    icon: mdi-video-vintage
  Network:
    tab: Home
    icon: mdi-lan

### Glances
  Servidor 1 (unRaid):
    tab: Glances
    useEqualHeights: true
    style: row
    columns: 3
    initiallyCollapsed: false
  Servidor 2 (Contabo):
    tab: Glances
    useEqualHeights: true
    style: row
    columns: 3
    initiallyCollapsed: false

### Bookmarks
  Blogs:
    icon: si-blogger
  Compres:
    icon: mdi-shopping-outline
  Comunicacio:
    icon: mdi-newspaper
  Videos:
    icon: mdi-movie-open-edit-outline
  VPS:
    icon: mdi-google-cloud
````
Es en el archivo `services.yaml` donde definimos lo que contiene cada **sección** (*Virtualization*, *Monitoring*, etc..). 

#### services.yaml
```yaml
- Virtualization:
    - unRaid:
        icon: unraid
        href: [url]
        description:
        ping: [url]
        siteMonitor: [url]

- Monitoring:
    - What's Up Docker?:
        icon: whats-up-docker-light.png
        href: [url]
        description: Notifications for New Container Version Releases
        ping: [url]
        siteMonitor: [url]
        widget:
          type: whatsupdocker
          url: [url]
          username: {{HOMEPAGE_VAR_WUDUSER}}
          password: {{HOMEPAGE_VAR_WUDPASS}}

    - Scrutiny:
        icon: https://repository-images.githubusercontent.com/289524449/fc01e480-e6ab-11ea-9e20-53257df6f326
        href: [url]
        description: S.M.A.R.T. Monitoring Dashboard
        ping: [url]
        siteMonitor: [url]
        container: scrutiny
        widget:
          type: scrutiny
          url: [url]
          fields: ["passed", "failed" ]

    - Gotify:
        icon: gotify.png
        href: [url]
        description: Simple, HTTP-based Pub-sub Notification Service
        ping: [url]
        siteMonitor: [url]
        container: gotify
        widget:
          type: gotify
          url: [url]
          key: {{HOMEPAGE_VAR_GOTIFY}}

- Media:
    - Jackett:
        icon: jackett.png
        href: [url]
        description: Servidor Indexers
        ping: [url]
        siteMonitor: [url]
        container: jackett
        widget:
          type: jackett
          url: [url]
    - Transmission:
        icon: transmission.png
        href: [url]
        description: Servidor Transmission
        ping: [url]
        siteMonitor: [url]
        container: transmission
        widget:
          type: transmission
          url: [url]

    - Jellyfin:
        icon: jellyfin.png
        href: [url]
        description: Servidor Multimedia
        ping: [url]
        widget:
          type: jellyfin
          url: [url]
          key: {{HOMEPAGE_VAR_JELLYFIN}}
          enableBlocks: true
          enableNowPlaying: false
          fields: ["movies", "series", "episodes" ]

    - Navidrome:
        icon: navidrome
        href: [url]
        description: Servidor Musica
        container: navidrome
        widget:
          type: navidrome
          url: [url]
          user: {{HOMEPAGE_VAR_NAVUSER}}
          token: {{HOMEPAGE_VAR_NAVTOKN}}
          salt: {{HOMEPAGE_VAR_NAVSALT}}

    - Calibre:
        icon: calibre.png
        href: [url]
        description: Software de gestió de llibres
        ping: [url]
        siteMonitor: [url]
        container: calibre

    - Calibre-Web:
        icon: calibre-web.png
        href: [url]
        description: Web per a la gestió de llibres (Calibre) i la seva BBDD
        ping: [url]
        siteMonitor: [url]
        container: calibre-web
        widget:
          type: calibreweb
          url: [url]
          username: {{HOMEPAGE_VAR_CALIBREUSER}}
          password: {{HOMEPAGE_VAR_CALIBREPASS}}

- Network:
    - Traefik:
        icon: traefik.png
        href: [url]
        description: Open-source Reverse Proxy and Load Balancer
        ping: [url]
        siteMonitor: [url]
        widget:
          type: traefik
          url: [url]
          username: {{HOMEPAGE_VAR_TRAEFIKUSR}}
          password: {{HOMEPAGE_VAR_TRAEFIKPWD}}
    - PiHole:
        icon: pi-hole.png
        href: [url]
        description: Servidor PiHole
        ping: [url]
        siteMonitor: [url]
        container: pihole
        widget:
          type: pihole
          url: [url]
          key: {{HOMEPAGE_VAR_PIHOLE}} 

- dasReich (unRaid):
    - CPU Usage:
        widget:
          type: glances
          url: [url]
          metric: cpu
    - Memory:
        widget:
          type: glances
          url: [url]
          metric: memory
    - Network:
        widget:
          type: glances
          url: [url]
          metric: network:eth0
    - Processes:
        widget:
          type: glances
          url: [url]
          metric: process
    - Disk I/O:
        widget:
          type: glances
          url: [url]
          metric: disk:nvme0n1
    - Disk I/O:
        widget:
          type: glances
          url: [url]
          metric: disk:sdb

- Wiking (Contabo):
    - CPU Usage:
        widget:
          type: glances
          url: [url]
          metric: cpu
    - Memory:
        widget:
          type: glances
          url: [url]
          metric: memory
    - Network:
        widget:
          type: glances
          url: [url]
          metric: network:eth0
    - Processes:
        widget:
          type: glances
          url: [url]
          metric: process
    - Disk Usage:
        widget:
          type: glances
          url: [url]
          metric: fs:/etc/hostname
    - Disk I/O:
        widget:
          type: glances
          url: [url]
          metric: disk:sda
```

Si os fijais, podreis ver que he usado *variables* del estilo **HOMEPAGE_VAR_CALIBREUSER** o **HOMEPAGE_VAR_PIHOLE**, esto lo usamos, para que el fichero quede los más **limpio** posible de passwords, keys, etc... que en caso de algun problema queden expuestos.

Entonces, para hacer esto, lo unico que se tiene que hacer, es crear un fichero `.env` con las *variables* que se necesiten, pero siempre tienen que venir precedidas de `HOMEPAGE_VAR_...` (os pondre las variables que yo he usado), pero aqui vosotros sois libres de crear más:
#### .env
```bash
# PASSWORDS CALIBRE-WEB
#
HOMEPAGE_VAR_CALIBREUSER=[user]
HOMEPAGE_VAR_CALIBREPASS=[password]

# PASSWORD TRANSMISSION
#
#HOMEPAGE_VAR_TRANSUSER=[user]
#HOMEPAGE_VAR_TRANSPASS=[password]

# KEY JELLYFIN
#
HOMEPAGE_VAR_JELLYFIN=[key]

# KEY GOTIFY
#
HOMEPAGE_VAR_GOTIFY=[key]

# TRAEFIK PASSWORD
#
HOMEPAGE_VAR_TRAEFIKUSR=[user]
HOMEPAGE_VAR_TRAEFIKPWD=[password]

# NAVIDROME
#
HOMEPAGE_VAR_NAVUSER=[user]
HOMEPAGE_VAR_NAVTOKN=[key]
HOMEPAGE_VAR_NAVSALT=[key]

# WHATS UP MY DOCKERS
#
HOMEPAGE_VAR_WUDUSER=[user]
HOMEPAGE_VAR_WUDPASS=[password]

# PIHOLE
#
HOMEPAGE_VAR_PIHOLE=[key]
```

#### widgets.yaml
```yaml
- logo:
    icon: [url]
- glances:
    type: glances
    url: [url]
    label: [label]
    mem: false
    cpu: false
    expanded: true
    disk:
      - /etc/hostname
- glances:
    type: glances
    url: [url]
    label: [label]
    mem: false
    cpu: false
    expanded: true
    disk:
      - /etc/hostname

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
````
#### bookmarks.yaml
```yaml
- Blogs:
    - Personal:
        - href: [url]
          icon: github-light.png
    - Desenvolupament:
        - href: [url]
          icon: github-light.png
    - Llibres:
        - href: [url]
          icon: wordpress.png
    - uGeek:
        - href: [url]
          icon: blogger.png
    - Lazaro:
        - href: [url]
          icon: blogger.png
    - Atareao:
        - href: [url]
          icon: blogger.png

- Compres:
    - Amazon:
        - href: [url]
          icon: amazon.png

    - Aliexpress:
        - href: [url]
          icon: aliexpress.png

- Comunicacio:
    - Mastodon:
        - href: [url]
          icon: mastodon.png
    - Telegram:
        - href: [url]
          icon: telegram.png
    - RiseUp:
        - href: [url]
          icon: mailu.png
    - EruenPlay:
        - href: [url]
          icon: youtube.png

- Videos:
    - Hispamula:
        - href: [url]
          icon: [url]
    - HDOlimpo:
        - href: [url]
          icon: [url]
    - Xbytes:
        - href: [url]
          icon: [url]
    - DonTorrent:
        - href: [url]
          icon: [url]
    - YouTube:
        - href: [url]
          icon: youtube.png

- VPS:
    - Contabo:
        - href: [url]
          icon: contabo.png
    - Google Cloud:
        - href: [url]
          icon: [url]
    - GitHub:
        - href: [url]
          icon: github-light.png
````

Espero que os pueda servir de ayuda esta información. A parte, asi la tengo tambien disponible para mi, cuando me explote el servidor 😁 y pierda toda la configuración que tengo ahora mismo.
#### Referencia
- [Github - Share your homepage](https://github.com/gethomepage/homepage/discussions/473) 

