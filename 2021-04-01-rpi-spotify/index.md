# Creando tu propio Servidor de Musica privada

Cuando tienes un servidor de bajo consumo como una Raspberry y empiezas a usar docker, a parte de descubrir un nuevo mundo (no me canso de decirlo), tambien descubres nuevas formas de torturar tu mente.

<!--more-->

Porque digo eso, porque cuando piensas que ya has conseguido todo lo que necesitas, tu cabezita piensa "aprovechate de tu servidor y escucha tu musica en el movil".

![](/images/cerebro.jpg "Pensando")

Ahi es cuando te dices, porque no me pongo a investigar si existe esta posibilidad??

Solamente falta que sigas a [uGeek Podcast](https://ugeek.github.io) (increible todo lo que llega a hacer con su servidor) y ya te mete el gusanito en el cuerpo de *si el puedo, porque yo no* y ya la tenemos liada.

He seguido todos sus cambios de contenedores que el ha hecho y los he probado todos:
- [Supysonic](https://github.com/spl0k/supysonic): El primero que use y estuvo bien, hasta que...
- [Gonic](https://github.com/sentriz/gonic): Uno de los mejores que he usado, pero no se, encuentro que le falta algo, pero no se que es...
- [Navidrome](https://github.com/navidrome/navidrome): Junto a Gonic el mejor y este si que tiene un noseque que siempre vuelvo a el (sera la web, desde el que puedes escuchar musica)

El mejor, en mi opinion, como he dicho antes **navidrome**, no se que es, pero me encanta, su simpleza, los pocos recursos que consume del servidor. Lo tiene todo. Eso si, no tiene nada que echarle en cara a **Gonic**, pero a este ultimo le falta algo que no se que es y eso que es igual de facil y consume tan pocos recursos como **navidrome**.

Despúes de esta breve explicación, pasamos a la instalación y configuración de mi **Spotify** privado.

Como todo en docker, solamente se tiene que añadir en tu fichero `docker-compose.yml` la configuración necesaria para instalar **navidrome** que en mi caso es la siguiente:
```bash
navidrome:
 image: deluan/navidrome:latest
 container_name: navidrome
 user: 1000:1000 
 ports:
   - "4533:4533"
 restart: unless-stopped
 environment:
   ND_TRANSCODINGCACHESIZE: 100MB
   ND_SCANSCHEDULE: "@every 1h"
   ND_SESSIONTIMEOUT: 24h
   ND_LASTFM_ENABLED: "true"
   ND_LASTFM_APIKEY: "API DE LASTFM"
   ND_LASTFM_SECRET: "API DE LASTFM"
   ND_LASTFM_LANGUAGE: "es"
   ND_SPOTIFY_ID: "API DE SPOTIFY"
   ND_SPOTIFY_SECRET: "API DE SPOTIFY"
 volumes:
   - ${STORAGE}/config/navidrome:/data
   - ${MEDIA}/audio/Music:/music:ro
```

Yo he puesto las opciones de configuración que uso o las que más me interesan que son:
- `ND_SCANSCHEDULE`: Cada cuando actualiza la biblioteca
- `ND_LASTFM_ENABLED`: Si quiero usar la api de LastFM (para que me de una descripción de los artistas que tengo)
- `ND_SPOTIFY_ID`: Si quiero usar la api de Spotify  (lo mismo que en el caso de LastFM)

Ahora solamente queda levantar el contenedor:
```bash
usuari@raspberry:/# docker-compose up -d navidrome
```

Aqui es cuando se hace la magia. A lo mejor tarda un poco en estar disponible, porque esta escaneando toda la musica que tienes, pero cuando digo tardar, son un par de segundos. Porque lo escanea todo a una velocidad increible.

Lo unico que te queda es instalar una app en tu movil, en mi caso [substreamer](https://substreamerapp.com), conectarte a tu servidor, que en este caso, te viene bien tener configurado un [proxy server](/2021-05-07-rpi-nginx-proxy-manager) con su correspondiente certificado y disfrutar.
#### Referencia
- [Navidrome](https://ugeek.github.io/blog/post/2020-09-16-navidrome-la-alternativa-a-airsonic-desarrollada-en-go.html)
- [Gonic](https://ugeek.github.io/blog/post/2020-05-06-gonic-el-mejor-y-mas-ligero-servidor-de-musica-con-api-subsonic.html)
- [Supysonic](https://ugeek.github.io/blog/post/2019-12-31-supysonic-0-5-0-total-compatibilidad-con-todos-los-clientes-subsonic.html)

