# RSS-Funnel. Uno para controlarlos a todos

No se si lo habreis notado vosotros, pero escuchar podcast sobre tecnologia, informatica y dockers puede ser perjudicial para la salud y por extensión para vuestros servidores, o es solo una cosa que me pasa a mi solo?

Si os preguntareis a que viene esta afirmación, podeis seguir leyendo y todo quedara aclarado.

<!--more-->

Uno de mis podcast favoritos, es el de [uGeek](https://ugeek.github.io/list.html), si leeis mis articulos, os dareis cuenta, porque muchas de las ideas y modificaciones que hago en mi servidor salen de escuchar sus podcast. Además, da a conocer smuchas aplicaciones que seguramente para el resto de los mortales son desconocidas, pero que cuando las conoces, pues no estan tan mal y te pueden servir de ayuda como ha sido con la que explicaba él en este [podcast](https://ugeek.github.io/post/2024-03-06-rss-funnel-gestionando-y-optimizando-mis-feeds.html).

Dicha aplicacion es [rss-funnel](https://github.com/shouya/rss-funnel), que se la puede definir como un concentrador de podcas y asi tener todos los feeds en uno solo y que puedes, primero tener en tu propio servidor y segundo, lo puedes controlar tu.

Si solo escuchas un solo podcast, pues no te ayudara mucho, pero si sigues unos 10, como es mi caso, *pero si eso no es nada*, para mi ya son muchos 😉 pues no viene nada mal la aplicación que nos aconseja *uGeek*, y lo mejor de todo, es que puedes disponer de ella en docker. Que más se puede pedir.

Asi que me lance a por su instalacion en el VPS que tenia (Google Cloud). La instalación es muy facil, como todo en docker, aunque la configuración es un poco rebuscada, pero nada del otro mundo:

### docker-compose.yml
```yaml
rssFunnel:
  image: ghcr.io/shouya/rss-funnel:latest
  container_name: rssFunnel
  ports:
    - 4080:4080
  volumes:
    - ${HOME}/config/rss-funnel/funnel.yaml:/funnel.yaml
  environment:
    RSS_FUNNEL_CONFIG: /funnel.yaml
    RSS_FUNNEL_BIND: 0.0.0.0:4080
```
En mi caso, he cambiado el nombre del *servicio* y el nombre del contenedor, esto es porque lo voy a utilizar con *traefik* y asi es más facil a la hora de añadir los labels que afectan a *traefik*.

Una vez tienes el `docker-compose.yml`, solamente hacen falta las palabras magicas:
```bash
usuari@debian:~$docker compose up -d rssFunnel && docker logs -f rssFunnel
```

La segunda instrucción siempre la pongo, porque asi, puedo ver si el docker me da algun error. Que normalmente siempre me pasa, porque como nunca creo los ficheros que el contenedor necesita, pues. En este caso, el fichero que me faltaba era el `funnel.yaml` con toda la configuración de los podcast a seguir.

En mi caso, es la siguiente (que te puede servir de base a ti):

### funnel.yaml
```yaml
endpoints:
  - path: /rss_feed.xml
    source:
      format: rss
      title: Mi Feed de Podcasts que sigo.
    filters:
      - merge:
          source:
            - https://anchor.fm/s/5a5b39c/podcast/rss
            - https://anchor.fm/s/81022ad4/podcast/rss
            - https://anchor.fm/s/1218850/podcast/rss
            - https://feeds.redcircle.com/610e9ea8-edf0-407f-9e6c-72375a0e17db
            - https://anchor.fm/s/115eb3dc/podcast/rss
            - http://feeds.feedburner.com/papafriki
            # se que ya no existe, pero tiene algunos podcast que son geniales
            - https://podcastlinux.com/feed
            - https://anchor.fm/s/baa8920/podcast/rss
            - https://ugeek.github.io/podcast.xml
      # aqui indico los campos que no quiero que se carguen en el RSS para asi aligerar el peso del XML
      - js: |
          function modify_post(feed, post) {
            post.description = null;
            post.content = null;
            post.author = null;
            post.categories = [];
            post.comments = null;
            post.link = null;
            post.guid = null;
            post.source = null;
            post.extensions = {};
            post.itunes_ext = null;
            post.namespaces = {};
            post.dublin_core_ext = null;

            return  post;
          }
      # lo que intento aqui, es que como maximo me cargue 100 episodios de cada podcast, pero que no funciona
      - modify_feed: feed.items = feed.items.slice(0, 100);
```
En mi caso, añadi una opción para limitar los podcast que *rss-funnel* iba a añadir en el *feed*. Queria que fueran solamente 100, porque como añada los 550 que tiene atareao, el *feed* ocuparia 10Mb.

Habia añadido, segun la documentación era la que se tiene que usar `modify_feed: feed.items = feed.idtems.slice(0, 100);` pero como podia comprobrar, no funcionaba correctamente. Asi que, siguiendo el consejo de *uGeek* fui a preguntar directamente a la fuente para saber, como se tenia que hacer, me respondio y me añadio una modificación, que le agradezco mucho, la modificación para el fichero `funnel.yaml` además de otras modificaciones:

### funnel.yaml (modificado)
```yaml
endpoints:
  - path: /rss_feed.xml
    source:
      format: rss
      title: Mi Feed de Podcasts que sigo.
    filters:
      - merge:
          source:
            - https://anchor.fm/s/5a5b39c/podcast/rss
            - https://anchor.fm/s/81022ad4/podcast/rss
            - https://anchor.fm/s/1218850/podcast/rss
            - https://feeds.redcircle.com/610e9ea8-edf0-407f-9e6c-72375a0e17db
            - https://anchor.fm/s/115eb3dc/podcast/rss
            - http://feeds.feedburner.com/papafriki
            - https://podcastlinux.com/feed
            - https://anchor.fm/s/baa8920/podcast/rss
            - https://ugeek.github.io/podcast.xml
          # MODIFICACIÓ PER A LIMITAR A 100 EPISODIS A CADA PODCAST
          filters:
            - modify_feed: feed.items = feed.items.slice(0, 100);
      # MODIFICACIÓ PER ELIMINA INFORMACIO NO NECESSARIA A VISUALITZAR AL FEED
      # AMB AIXO ACONSEGUIM UN FEED AMB POC PES
      # QUE SI FAS SERVIR DES DE UN MOVIL, SEMPRE VA BE
      - modify_post: |
          post.description = null;
          post.content = null;
          post.author = null;
          post.categories = [];
          post.comments = null;
          post.link = null;
          post.guid = null;
          post.source = null;
          post.extensions = {};
          post.itunes_ext = null;
          post.namespaces = {};
          post.dublin_core_ext = null;
```

Con esta pequeña modificación, ya tengo el servicio en funcionamiento.

Lo unico que me quedaba por hacer era decidir como acceder al feed. Si a traves de un proxy **Cadddy** o a traves de una VPN **WireGuard**. Al final me decidi por el proxy a traves de *Caddy* y de momento me funciona perfectamente. Y además, el fichero `XML` que me descarga es de menos de 1Mb. No se puede pedir nada más.

Estoy contento con este servicio, porque es inmejorable. Y como bien dice el titulo, **y uno para controlarlos a todos**, porque en un unico *feed* tengo todos los podcast que sigo actualmente. Y en el caso de que quiera añadir uno más, solo lo tengo que añadir en el fichero *YAML* y a funcionar.

Aun le falta alguna mejoras, pero creo que creador esta con ello y eso si, si tienes cualquier duda te ayuda siempre (fue mi caso).
#### Referencia
- [RSS-Funnel](https://github.com/shouya/rss-funnel)
- [RSS-Funnel. Gestionando y optimizando mis feeds](https://ugeek.github.io/post/2024-03-06-rss-funnel-gestionando-y-optimizando-mis-feeds.html)

