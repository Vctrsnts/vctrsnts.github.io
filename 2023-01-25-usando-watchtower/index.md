# Usando Watchtower

Si quieres echarle la culpa tendreis que mirar a [Angel de uGeek](https://ugeek.github.io/blog/post/2019-07-26-actualizaci%C3%B3n-autom%C3%A1tica-de-tus-dockers.html), a [Lorenzo de Atareao.es](https://atareao.es/podcast/como-actualizar-imagenes-docker-automaticamente) y por ultimo a [ElBlogdeLazaro](https://elblogdelazaro.org/posts/2018-09-12-actualiza-automaticamente-tus-contenedores-docker) porque ellos son los culpables de todas las mejoras o modificaciones que le estoy haciendo a mi servidor y esta que voy a explicar a continuación **watchtower** es una de ellas 😉

<!--more-->

No voy a explicar que hace esta aplicación, porque si leeis los articulos que *uGeek*, *Lorenzo* o *Lazaro*, estaran mejor explicadas, pero en pocas palabras, te mantiene actualizado todos los contenedores de docker, siempre que le actives el **label** para que **watchtower** los tenga en cuenta.

Eso si, hay que tener en cuenta que si no piensas bien que contenedores quieres que te actualize puedes liar un caos en tu servidor que puede ser de ordago.

Un ejemplo de este caos (yo de momento no tengo activada su auto-actualizació) es el proxy inverso (caddy), porque imaginate que se actualiza, pero da un error y ya no puedes acceder a tus servicios desde el exterior. Por eso, en mi caso pienso bien que contenedores quiero que se actualizen automaticamente.

Eso si, os voy a poner mi `docker-compose.yml` que uso para la instalación de **watchtower**. Tener en cuenta que es una recopilación de todos los ficheros de configuración que he visto para su instalación.
```yaml
watchtower:
  image: containrrr/watchtower:latest
  container_name: watchtower
  restart: unless-stopped
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
  environment:
    - WATCHTOWER_LABEL_ENABLE=true
    - WATCHTOWER_CLEANUP=true
    - WATCHTOWER_INCLUDE_RESTARTING=true
    - WATCHTOWER_INCLUDE_STOPPED=true
    - WATCHTOWER_REVIVE_STOPPED=false
    - WATCHTOWER_NO_RESTART=false
    - WATCHTOWER_TIMEOUT="30s"
    # AQUESTA OPCIÓ LA TINC DESACTIVADA, PERQUE TINC DUBTES DE QUE FUNCIONI CORRECTAMENT, ENCARA QUE EL LOG DONAR CONSTANCIA DE QUE SI
    #- WATCHTOWER_SCHEDULE=0 0 4 * * *
    # L'HE SUBSTITUIT PER AQUESTA
    - WATCHTOWER_POLL_INTERVAL=86400
    - WATCHTOWER_NOTIFICATION_URL=telegram://token_telegram@telegram/?channels=id_canal
    - WATCHTOWER_NOTIFICATIONS_HOSTNAME=nombreServidor
    #WATCHTOWER_NOTIFICATIONS: gotify
    #WATCHTOWER_NOTIFICATION_GOTIFY_URL: https://gotify.tuservidor.es
    #WATCHTOWER_NOTIFICATION_GOTIFY_TOKEN: AAAAAAAAAAAAAAA
    - WATCHTOWER_DEBUG=true
    - TZ=Europe/Madrid
```

Al principio, **watchtower** no me funcionaba correctamente, en pocas palabras no funcionaba ni hacia nada.

Así que me toco investigar que podia ser y al final después de mucho buscar, vi que me faltaba informar de en que red iba a trabajar el contenedor. Esto se configura de la siguiente manera:
```yaml
network_mode: bridge
```

Tambien hay que tener en cuenta, que para informar a **watchtower** de los contenedores que queremos que vigile por si tiene alguna actualización es de la siguiente manera (tener en cuenta, que tiene que estar en todos los contenedores que queremos sean controlados):
```yaml
labels:
 - com.centurylinklabs.watchtower.enable="true"
```

En teoria ya tendria que funcionar. Al principio no parece que funcionaba y estaba con la mosca detras de la oreja, porque no me actualizada nada. Asi que le puse que se ejecutara cada minuto y al final, a partir de que configure correctamente la red empezo a funcionar, me actualizo un par de contenedores y asi quedo.

Se actualizo y desde entonces, no ha vuelto a actualizar ningún contenedor más. Y es la duda que tengo, no se si es porque no hay ninguna actualización o porque no esta funcionando correctamente.

Seguire observando si funciona correctamente.
#### Referencia
- [Atareao.es - Watchtower](https://atareao.es/podcast/como-actualizar-imagenes-docker-automaticamente/)
- [ElBlogdeLazaro - Watchtower, 1 parte](https://elblogdelazaro.org/posts/2018-09-12-actualiza-automaticamente-tus-contenedores-docker)
- [ElBlogdeLazaro - Watchtower, 2 parte](https://elblogdelazaro.org/posts/2022-10-17-actualiza-automaticamente-tus-contenedores-docker-ii/https://elblogdelazaro.org/posts/2022-10-17-actualiza-automaticamente-tus-contenedores-docker-ii/https://elblogdelazaro.org/posts/2022-10-17-actualiza-automaticamente-tus-contenedores-docker-ii)
- [uGeek - Watchtower](https://ugeek.github.io/blog/post/2019-07-26-actualizaci%C3%B3n-autom%C3%A1tica-de-tus-dockers.html)

