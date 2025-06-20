# Mastodon, Jekyll y Github. Una combinación perfecta.

Desde que di el salto de **wordpress** a **Github**, lo más logico, si mi profesion, pasion hace referencia a la tecnologia y que tambien influyo que **wordpress** empezaba a tener muchos problemas con la creación y gestión del blog.

<!--more-->

Todo empezo a mediados del 2021 cuando cada vez tenia más problemas a la hora de crear articulos y subirlos a **wordpress**, aunque ahora le estoy dado otro [uso](https://vsantos.wordpress.com), asi que me puse a investigar y la mayoria de personas a las que sigo, lo tienen alojado en **Github** o **Gitlab**.

Investigue que diferencia habia entre los dos, pero no encontre ninguna a nivel de uso personal, asi que lance la moneda al aire y salio **Github**, me puse a ello. Después de investigar me cree mi repositorio.

Al principio me costo mucho entender como funciona **Github**, para que os hagais una idea, me las tuve y desee para crear mi primer repositorio, era dar un pasito hacia adelante y dos hacia atras, si lo reconozco, no he leido la documentación del funcionamiento y uso de **Github**, pero bueno, creo que asi he aprendido mucho más. Porque he tenido que aprender a lo bestia y descubrir las cosas que te puede ofrecer **Github** poco a poco. Y no me ha parecido mal.

Mis progresos han sido lentos, porque todo lo que hacia era la primera vez, e iba más a prueba y error y volver a repetir hasta que entendia lo que pasaba. Después de tener mi repositorio **personal**, fue tener en mi repositorio todos los ficheros del tema que iba a usar e ir subiendo o creando los ficheros `markdown` y ponerlos en donde indicaba la documentación del tema si entender bien que pasaba.

Después entendi lo que hacia **Github**, que era `compilar` (si se le puede decir asi) los archivos `markdown` y generar automaticamente el fichero `html`, segui investigando a ver si eso se podia hacer en local y resulto que si que se podia hacer, pero claro, para hacer eso, necesitabas tener un servidor **Jekyll** para que se realizase la compilación y solamente tener que subir los ficheros `compilados` y tener en mi poder, el codigo fuente del blog.

Sigo pensando que no me equivoque, porque gracias a ello, aprendi como crear un docker (mi primer docker). Era un [Docker](https://hub.docker.com/r/vctrsnts/jekyll-git) que tiene un servidor jekyll para poder realizar las compilaciones de los `markdown`. Tambien tengo que decir que no funciona muy bien, pero bueno, como primera experiencia en crear un docker, no me fue mal, porque entiendi mejor como funcionan los docker.

Cuando vi que la cosa no funcionaba correctamente, la idea era interesante, pero el resultado no era muy satisfactorio, me puse a buscar un docker ya creado y que fuera mejor que el mio. Y di con el. 

Su autor es [bretfisher](https://github.com/BretFisher/jekyll-serve), tengo que informar que es un poco lioso de usar, porque tiene 2 contenedores:
- [Jekyll](https://hub.docker.com/r/bretfisher/jekyll)
- [Jekyll-serve](https://github.com/BretFisher/jekyll-serve)

El unico que te tiene que importar es es el contenedor que hacer de **jekyll-serve**.

La configuración que tengo para usar la imagen de docker es la siguiente:
```yaml
jekyll:
  image: bretfisher/jekyll-serve
  container_name: jekyll
  # port d'access a traves de la web
  ports:
    - 4000:4000
  # on esta el codi font del blog
  volumes:
    - ../blog:/site
 ```
Cuando ya tenia este contenedor en marcha, ya pude empezar con la creación de mis articulos y es aqui, después de esta pequeña historia, donde explico la idea principal de este articulo. Unir **Jekyll**, **Mastodon** y **Github** y todo lo que me podia ofrecer este ultimo y una de estas posibilidades es la de publicar mis articulos a traves de un [bot](2022-11-14-publicar-feed-mastodon.md).

Pero lo que echaba de menos, porque no se veia ninguna imagen en la publicación en **Mastodon**, cuando lei uno de los toots de **Carlos M** de [elBlogdeLazaro](https://mastodon.online/@elblogdelazaro@mastodon.social), que sigo y que me ha dado el punto de inicio por donde empezar, se podia visualizar una imagen, o mejor dicho, el logo de su web.

Yo queria hacer lo mismo, pero no encontraba ninguna información donde se explicase como se tenia que hacer o como configurar **Mastodon**, después descubri que las modificaciones necesarias las tenia que hacer en los archivos de mi blog, y gracias a una pista que, como ya he dicho, me dio *Carlos. M* conseguir descubrir como hacerlo.

La pista fue (*Lazaro* usa Hugo, otra alternativa a Jekyll), me comento, que en su caso, esto es automatico y que a traves de `:EXPORT_hugo_custom_front_matter+: :image /images/......` es la manera que se muestra el logo en las publicaciones de **Mastodon**, pero ya era algo.

Me puse a buscar todo lo referente a la pista que me habia dado y que se podia hacer en **Hugo** y al final la encontre en esta [pagina](https://sherblog.pro/compartiendo-contenido-de-hugo-en-mastodon), encontre la gran pista que me llevaria hacia mi objetivo.

Todo consiste, en que **Mastodon** utiliza **OpenGraph** para todo el tratamiento de las publicaciones (seguramente es más complicado que esto), pero en mi caso me dio la pista definitiva que necesitaba. Lo que tenia que hacer, es buscar como poner en mi blog una imagen del tipo `og:image` en la pantilla. La solución la encontre en la siguiente [pagina](https://gist.github.com/davidensinger/5431869), donde se puede ver, el codigo necesario para usar `imagenes og`:
```javascript
<meta content="site.url/assets/img/posts/page.image" property="og:image">
```
Gracias a este codigo y después de modificarlo para poderlo usar en mi plantilla, la modificación la he hecho en `_layouts/default.html`:
```javascript
if site.lightavatar
  <meta content="site.lightavatar | relative_url" property="og:image">
else
  <meta content="site.darkavatar | relative_url" property="og:image">
endif
```
Consegui hacer lo que yo queria, porque ahora, a falta de más pruebas, he conseguido que cada vez, que se envia una publicación a **Mastodon** a traves del **bot automatico** se puede ver el logo de mi pagina web. Un logo simple, pero es el que más me gusta, porque mezcla mis 2 grandes pasiones.

**Egipto y GNU/Linux**
#### Referencia
- [Opciones og:image](https://gist.github.com/davidensinger/5431869)
- [Opengraph link previews in Jekyll](https://stackoverflow.com/questions/57493239/opengraph-link-previews-in-jekyll)
- [Twitter Cards on Jekyll](https://brianbunke.com/blog/2017/09/06/twitter-cards-on-jekyll)
- [Compartiendo contenido de Hugo en Mastodon](https://sherblog.pro/compartiendo-contenido-de-hugo-en-mastodon)

