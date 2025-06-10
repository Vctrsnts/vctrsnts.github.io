# Cambios en el blog - 2

Como ya explique en el anterior [articulo](/2024-05-24-cambios-blog-1), comentaba que habia actualizado mi **Blog / Pagina Web** con un nuevo tema gracias a *Jekyll* y al final hice el cambio, con unos cuantos problemas pero lo hice. Y aqui podeis ver el resultado...

<!--more-->

Pero aun asi, habia cosas que no acababan de funcionar y eran:
- El feed no se creaba correctamente porque las direcciones de los posts apuntaban a http://0.0.0.0:4000
  - Esta es la dirección por defecto del servidor de jekyll de desarrollo.
- En los articulos salia la opción de **SHARE** y aun desactivando las redes sociales, esta opción no desaparecia.

La parte más facil fue la de hacer desaparecer la opción **SHARE** de los post. Hice una modificación al codigo para que a partir de una variable *activase* la opción de **SHARE** o no. 

La primera modificación se tenia que hacer en el archivo `_data/social.yml` donde tenemos que añadir lo siguiente:
```yaml
# add this new option:
# For share on general
share_buttons: false
```

Una vez realizada esta modificación, la siguiente modificación se tenia que hacer en `_includes/social/share_buttons.liquid` donde teniamos que añadir el siguiente codigo:
```javascript
{% if site.data.social.share_buttons %}
...
{% endif %}
```
Y con esto se conseguia que los iconos de **SHARE** no se visualizaran.

Una vez realizada esta modificación, hable con el creador del tema para plantearle esta modificación y que se lo añadiera al tema. Después de un pequeño problema de comunicación, al final nos entendimos los dos con respecto a lo que le estaba proponiendo y le pareció una buena idea y que no habia ningun problema, que o yo hacia el **PULL REQUEST**, o sino tenia mucha prisa el se encargaria de hacer las modificaciones oportunas.

Le dije que mejor lo hiciera el, porque hacer los **PR** en codigo ajeno al mio no me hace mucha gracias, no vaya ser que la lie. Además no tenia prisa.

Y asi quedo la cosa, con esta modificación a la espera, pero en mi caso, como ya la tenia, pues adelante. Pero pasado un dia, el desarrollador del tema, me respondiendo a mi petición, indicando que esto ya lo hacia por defecto. A mi me extraño mucho, porque yo lo habia probado y no habia pasado nada.

El me puntualizo, que para activar esta funcionalidad, en el fichero `_data/social.yml` tenia que poner a `false` todas las redes sociales y con esto ya funcionaba lo que yo queria:
```yaml
# For the share button options at the bottom of the articles
share:
  email: false
  facebook: false
  linkedin: false
  pinterest: false
  pocket: false
  reddit: false
  tumblr: false
  twitter: false
  wordpress: false
```
Asi que lo probe y tenia razon. Lo que el decia funcionaba perfectamente.

Ahi fue cuando le pregunte, si ese fichero no es el que controla los iconos que aparecen en el **footer** de la web, y su respuesta fue, que no, ese fichero es el que controla la opción **SHARE**. El que controla el footer es `_data/icons.yml`. Entonces dije, *tierra tragame*.

Eso me pasa por no revisar concienzudamente el codigo para asi entender lo que esta haciendo, porque lo más fuerte es que el codigo es muy facil de entender. Lo que hace estar fuera de este mundo durante un par de años. Que todo avanza muy rapidamente.

Asi que deshice las modificaciones que habia hecho y todo funciono correctamente.

Pero ahora venia el problema más grave, como solucionar el tema del `feed.yml` que no apuntaba correctamente a la dirección de los articulos cuando se subia a **github.com**. Me pase dias y dias intentando buscar la solución al problema. Mucha gente decia que si ponias en el fichero `_config.yml`, en la opción *feed* la opción *url* de la siguiente manera:
```yaml
feed:
  url: https://tudominio.github.io
```
Funcionaba sin ningun problema. Pero no era mi caso. Y era muy frustante no conseguir hacer funciona el *feed* correctamente. Asi que si no puedes con el, hazte uno propio y fue lo que hice, construir mi propio feed, para que a la hora de generar el sitio en **github** se creara automaticamente. El codigo que use era el siguiente:
```html
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:sy="http://purl.org/rss/1.0/modules/syndication/">
  <channel>
    <title>{{ site.name | xml_escape }}</title>
    <description>{% if site.description{{ site.description | xml_escape }}{% endif</description>
    <sy:updatePeriod>{{ site.feed_update_period | default: "daily" | xml_escape }}</sy:updatePeriod>
    <sy:updateFrequency>{{ site.feed_update_frequency | default: 1 | xml_escape }}</sy:updateFrequency>
    <link>{{ site.url }}</link>
    <atom:link href="{{ site.url }}/{{ page.path }}" rel="self" type="application/rss+xml" />
    <lastBuildDate>{% for post in site.posts limit:1{{ post.date | date_to_rfc822 }}{% endfor</lastBuildDate>
    {% assign feed_items = site.feed_items | default: 10
    {% for post in site.posts limit:feed_items
      <item>
        <title>{{ post.title | xml_escape }}</title>
        {% if post.author.name
          <dc:creator>{{ post.author.name | xml_escape }}</dc:creator>
        {% endif
        {% if post.excerpt
          <description>{{ post.excerpt | xml_escape }}</description>
        {% else
          <description>{{ post.content | xml_escape }}</description>
        {% endif
        <pubDate>{{ post.date | date_to_rfc822 }}</pubDate>
        <link>{{ site.url }}{{ post.url }}</link>
        <guid isPermaLink="true">{{ site.url }}{{ post.url }}</guid>
        </item>
    {% endfor
  </channel>
</rss>
```

Como cogia la información del fichero `_config.yml` para la creación de los links, pues no habia problema.

Pero yo no queria esta chapuza, por llamarlo de alguna manera. Yo queria utilizar todo el potencial de *jekyll* y que fuera él, el que me creara el feed, porque sino, para eso, me hago yo el tema. Lo unico que me quedaba, era preguntar directamente a la [fuente](https://talk.jekyllrb.com/t/jekyll-always-0-0-0-0-4000/9204), donde explique el problema y como hacia para construir el sitio y después subirlo a **GitHub**.

Aqui fue donde explique que usaba un archivo sh, este en [concreto](/2023-08-10-como-funciona-esta-web) que hacia las siguientes funciones:
- Construir el sitio añadiendo los nuevos posts, recordar que yo todo esto lo tengo en docker:
```bash
   docker exec jekyll bundle exec jekyll serve build
```
- Subir los archivos `html` a **GitHub**.

La primera respuesta que me dieron, que tienen mucha razon, fue, porque hacia eso, si eso lo podia hacer **GitHub** directamente y tienen toda la razon, pero les dije, que no me hacia mucha gracias subir todo el `codigo fuente` de mi web. Que preferia, en mi caso, tener el control del codigo fuente y subir solamente el codigo html final.

Hay fue donde me dijeron que entonces, el problema lo tenia yo, porque no entendia bien como funcionaba **jekyll**, 😭 lo que siempre me pasa por no leer y comprender el funcionamiento de las cosas, y en este caso de *jekyll*. Entonces me explicaron, que la instrucción que yo estaba usando, lo que hacia era:
- `serve` es crear, más o menos, con lo parametros del servidor de docker y mostrarme el resultado, pero sino ninguna modificación.
  - O sea usando por defecto la dirección del servidor `http://0.0.0.0:4000`
- `build` lo que hace es construir el sitio usando la configuración del fichero `_config.yml`.

Lo que yo estaba haciendo a parte de no tener sentido era *crear* y *construir* el sitio con los valors por defecto del servidor y por eso, el feed no se creaba correctamente. Que lo correcto, era usar `jekyll build`. Y asi que me fue.

Lo que puede pasar por no entender lo que haces. Y funciono 🥲. Al usar *build* el feed y todo el resto de ficheros, *sitemap.yml*, *robots.txt*, se creaban usando los valores de `_config.yml`.

Pues ya estaba todo. Por fin tenia todo el tema funcionando correctamente y lo mas impportante, sin necesidad de utilizar ninguna funcionalidad externa a *jekyll*, para que asi, en un futuro, espero que lejano, si quiero cambiar de nuevo de tema, no tener que volver a pelearme con el codigo para conseguir que funcione correctamente.

Aunque esto no es del todo cierto, porque cada tema, tiene su manera particular de crear los posts, pero bueno, eso es otro tema.

Hasta aqui hemos llegado. Con mi sitio con un tema nuevo y a pleno rendimiento y con tiempo para decidar a otras cosas que tengo pendientes y sin tener que preocuparme por su funcionamiento. Lo unico que me queda, si, nunca se puede decir que todo esta perfecto, es, como el tema tiene esa posibilidad, la de añadir alguna imagen de cabecera de los articulos. Pero eso ya se vera.
#### Referencia
- [Modificar opción SHARE](https://github.com/sylhare/Type-on-Strap/discussions/442)
- [Jekyll always 0.0.0.0:4000](https://talk.jekyllrb.com/t/jekyll-always-0-0-0-0-4000/9204)

