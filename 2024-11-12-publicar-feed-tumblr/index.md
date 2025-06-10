# Publicar feed en Tumblr

Este articulo, podria decirse que es una continuación de este [articulo](/2022-11-14-publicar-feed-mastodon) pero en este caso, es para [Tumblr](https://www.tumblr.com).

La idea es la misma, pero para otra red social. Eso si, más pequeña y desconocida o al menos para mi. Nunca habia oido de ella, pero nunca se sabe y asi ya estoy en ella, aunque sea solamente para publicar los articulos que voy añadiendo a mi web / blog.

<!--more-->

Partimos de la base que antes de empezar tenemos que tener instalado:
```bash
usuari@debian:~$ pip install --user pytumblr
```
Tambien tenemos que tener `feedparser` que se usa para el tratamiento de los *XML* que si tienes este mismo **script** pero para *Mastodon*, seguramente ya lo tienes. Sino te tocara instalarlo.

El siguiente paso, es dar de alta *tu aplicación* en el *API* de *Tumblr*. Esto es un poco confuso, porque es dificil de encontrar, pero son los siguientes:
- [Darse de alta](https://www.tumblr.com/oauth/register)
- [Autentificar la aplicació](https://api.tumblr.com/console/calls/user/info)
 
Tener en cuenta una cosa, primero os aconsejo que os creeis la cuenta en *Tumblr* y que luego accedais a estos links, sino os pedira usuario y password. 
 
En el momento de dar de alta la aplicación se obtiene:
- *Consumer_key*
- *Consumer_secret*

Luego, cuando se autentifica la aplicación se obtiene:
- *Oauth_token*
- *Oauth_token_secret*

Para poder publicar en esta red. Después solamente tienes que tener el *script* en `Python` para publicar. 

En este caso, pondre el que yo estoy utilizando ahora mismo, aunque estoy estudiando hacerle unos cambios para añadir más información. Pero con esto ya teneis un principio.
```python
  #!/usr/bin/env python
  # -*- coding: utf-8 -*-

  # script que lee el feed rss de un blog y publica un articulo de forma aleatoria en twitter y mastodon

  # Tienes que tener instaladas las librerias feedparser, Twython, Mastodon

  # Autor: Victor Santos y un poco de ChatGPT
  # https://vctrsnts.github.io

  # Llama a los modulos Python
  import feedparser
  import pytumblr
  import random
  import xml.etree.ElementTree as ET

  consumer_key = 'xxxxxxxxxxxxxxx'
  consumer_secret = 'xxxxxxxxxxxxxxx'
  oauth_token = 'xxxxxxxxxxxxxxx'
  oauth_secret = 'xxxxxxxxxxxxxxx'

  # Authenticate and create a client
  client = pytumblr.TumblrRestClient(
      consumer_key,
      consumer_secret,
      oauth_token,
      oauth_secret
  )
  # Per extreure les categories del Feed
  def extract_categories_from_specific_entry(feed_url, entry_index=0):
      # Parse the feed using feedparser
      feed = feedparser.parse(feed_url)

      # If feed.entries is empty, we attempt to return categories from the first entry (index 0)
      if not feed.entries:
          return get_categories_from_entry(feed, 0)  # Return categories from index 0, if possible

      # If the feed has entries, extract from the specified index
      if len(feed.entries) > entry_index:
          entry = feed.entries[entry_index]
          # Extract categories (tags) from the entry and add '"' around each category
          categories = [category.term for category in entry.get('tags', [])]
          return ",".join(categories)
      else:
          print(f"Error: Feed has less than {entry_index+1} entries, returning categories from index 0.")
          return get_categories_from_entry(feed, 0)  # Return categories from index 0
          
  # Helper function to get categories from the first entry (index 0)
  def get_categories_from_entry(feed, index):
      if len(feed.entries) > index:
          entry = feed.entries[index]
          # Extract categories (tags) from the entry and add '"' around each category
          categories = [category.term for category in entry.get('tags', [])]
          return ",".join(categories)
      return ""  # Return empty string if no tags found

  # Seleccionamos el Feed
  feed = 'tu dirección web hacia el feed.xml'

  # Parseamos el Feed
  d = feedparser.parse(feed)

  # Extrae la longitud del Feed y aleatoreamente selecciona un articulo
  feedlen = len(d['entries'])
  num = random.randint(0, feedlen)

  # Inicializa la API de Twitter, escribe el nuevo estado y salimos d['entries'][0] es el último  articulo publicado
  link = d['entries'][num]['link']
  title = d['entries'][num]['title']
  status_text = d['entries'][num]['summary_detail']['value']
  description = ("<strong>Recordando articulos publicados:</strong>" + "<br>" + status_text)
  tags = extract_categories_from_specific_entry(feed, num)

  # Replace 'your-blog-name' with your actual Tumblr blog name
  blogName = "tuNombreDeBlog"

  # Create the post
  client.create_link(
    blogName,
    title=title,
    url=link,
    description=description,
    tags=[tag for tag in tags.split(",")]
  )
```
En este *script* hay que tener en cuenta unas cosas:
- *blogName*: Cuando te distes de alta en este red social, el nombre de usuario, es el nombre de tu blog y es el que tienes que poner aqui.
- *feed*: Es el fichero *xml* que quieres usar
- *consumer_key*: La primera clave que necesitas
- *consumer_secret*: La segunda clave que necesitas
- *oauth_token*: La tercera clave que necesitas
- *oauth_token_secret*: La ultima de las 4 claves que necesitas

Una vez, tengas el fichero creado, si quieres hacer pruebas, tienes que hacerlo de la siguiente manera:
```bash
   usuari@debian:~$ python3 nombreDelArchivo.py
```
Entonces, si no has tenido ningun problema, a tu cuenta de *Tumblr* te llegara un articulo aleatorio de tu web.

Como he dicho, aun lo tengo que mejorar, porque quiero añadir la imagen de la web, etc... Pero esto esta en estudio.

Después de hacer las pruebas que creas oportunas, solo te quedara configurar el cron, para que se ejecute cuando tu quieras.

Tambien, tengo otro *script* que publica el ultimo articulo publicado. Se puede utilizar este mismo script, pero tienes que hacer algunas modificaciones:
```bash
# Aixo ja no fa falta
import random

# Aixo tampoc fa falta
feedlen = len(d['entries'])
num = random.randint(0, feedlen)

#Aqui en comptes de 'num' ha de ser '0' quedan aixi
status_text = d['entries'][0]['title'] + '<br>' + d['entries'][0]['link']
articulo = ("<trong>Ultimo artículo publicado:</strong>" + '<br>' + status_text)
```
El resto de codigo para publicar es el mismo.
#### Referencia
- [tumblr/pytumblr](https://github.com/tumblr/pytumblr)
- [PyTumblr2 0.2.4](https://pypi.org/project/PyTumblr2)

