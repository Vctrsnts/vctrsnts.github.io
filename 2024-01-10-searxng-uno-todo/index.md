# Searxng. Uno para controlarlos a todos

Como ha he dicho muchas veces, docker te abre un mundo de infinitas posibilidades y entre una de estas posibilidades es tener tu propio buscador web y esto se consegui gracias a **SearxNG**.

<!--more-->

Aunque esto no es del todo cierto, lo que ocurre, es que **Searxng** es un concentrador de buscadores que lo unifica todo en un unico buscador, para mostrate todos los resultados posibles de todos los buscadores que hay actualmente (DuckDuckgo, Google, Bing, etc...) para asi evitar que tengas que hacer la busqueda en todos ellos. Y como además lo puedes usar a traves de docker, pues mejor que mejor.

La unica pega que tiene, es que si lo usas a nivel personal, los diferentes buscadores conoceran tu IP, porque siempre es la misma y nunca cambio, lo bueno, seria que lo abrieras a todo el mundo asi, seria dificil que los diferentes buscandores te relacionases con las posibles busquedas y todo seria más anonimo, pero claro, tienes que abrirlo a toda la web, con el peligro que ello conlleva.

En mi caso, como tengo el servidor de Oracle, lo tengo montado hay, para dentro de lo que cabe, asi les cueste un poco más relacionar mis busquedas con mi IP, ayuda un poco, pero no es la panacea. Y repito, como lo puedes usar a traves de **docker** que más se puede pedir. En mi caso, el `docker-compose.yaml` que estoy usando yo es el siguiente:

```yaml
searxng:
 image: searxng/searxng:latest
 container_name: searxng
 restart: unless-stopped
 networks:
   - searxng
 ports:
   - "8111:8080"
 volumes:
   - ${STORAGE}/config/searx:/etc/searxng:rw
 environment:
   - SEARXNG_BASE_URL=https://${SEARXNG_HOSTNAME:-localhost}/
 cap_drop:
   - ALL
 cap_add:
   - CHOWN
   - SETGID
   - SETUID
 logging:
   driver: "json-file"
   options:
     max-size: "1m"
     max-file: "1"

networks:
  searxng:
    ipam:
      driver: default
```

Con esto, ya tienes en funcionamiento nuestro buscador **Searxng**, pero claro, en mi caso, lo tengo en el servidor de Oracle, si quiero acceder a el, o lo hago a traves de una VPN o lo abro al mundo a traves de un proxy invero, en mi caso [Caddy]({%link _posts/2022-12-25-rpi-caddy-proxy-manager.md) y asi poder acceder a el desde cualquier parte del mundo. Yo ahora mismo lo estoy usando tanto en mi ordenador personal, como en mi movil.

Después de configurar **Caddy** para que nos de acceso al contenedor y accedamos a el por primera vez, tenemos que configurar el buscador (orden de prioridad de los buscadores, selección de imagenes, etc...). Tienes mil opciones con las que jugar.

En mi caso, fui a lo facil, modifique alguna cosas, active otras y ya me puse a usarlo. Y si que tengo que decir, que desde ese momento, no he vueltro a usar ningun otro buscador.

Como digo **uno para controlarlos a todos**.
#### Referencia
- [SearxNG. Buscador privado](https://ugeek.github.io/blog/post/2023-03-20-searxng-buscador-privado.html)

