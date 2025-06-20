# Publicando nuevos articulos en RRSS

Este nuevo articulo, se puede decir que es la fusión de este [articulo](/2022-11-14-publicar-feed-mastodon) y este [otro](/2024-11-12-publicar-feed-tumblr) donde explicaba como dar publicidad o informar en las diferentes redes sociales que estoy, **Mastodon**, **Tumblr** y ahora **BlueSky** de los articulos nuevos que voy añadiendo asi como de los antiguos, porque nunca se sabe si algun articulo anterior puede servir de ayuda a alguna persona.

<!--more-->

Pero después del anuncio que hizo **@Yoyo308** de que se habia apuntado en la nueva red social llamada [BlueSky](https://bsky.app) que quiere llegar a ser como la antigua **Twitter** o la nueva **X**. Eso si, espero que no se convierta en lo mismo que es ahora **X**. Lo hice, solamente para *reservar* mi nombre de usuario.

Eso si, tambien os digo, que la unica que uso actualmente es **Mastodon**. Esto lo digo con conocimiento de causa, porque hace un mes intente volver a **X** y solo dure una semana, todo era 💩. Para que os hagais una idea, una porqueriza esta más limpio que **X**. 

Por el mismo motivo tambien me di de alta en [tumblr](https://www.tumblr.com/vctrsnts), prefiero tener el nombre que yo quiero y asi luego no arrepentirme. Ya me paso con **X** y no quiero que me pase lo mismo.

Despues de haberos pegado la chapa con esta explicación, vayamos a por lo importante, porque tengo la sensación de que este articulo sera un poco largo, el script que ahora mismo estoy utilizando para informar de antiguos **articulos** que tengo en mi web para su consulta, pero en este caso, para las 3 redes sociales y a la vez. Se puede decir que es la unión del script de [mastodon](https://elblogdelazaro.org/posts/2021-08-16-bot-en-python-para-publicar-un-feed-de-forma-aleatorios-en-twitter-y-mastodom) que nos brindo [Carlos M.](https://elblogdelazaro.org) pero ampliado, para que funcione tambien en **BlueSky** y **Tumblr** y con mis granitos de sal junto con el condimento de [Copilot](https://copilot.microsoft.com/onboarding), que tengo que decir, que para aclarar dudas y dar ideas nuevas para programar va mejor que [ChatGpt](https://chatgpt.com), me ha salido un script en *Python* muy majo.

El script en cuestión es el siguiente:

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Aquest script, llegeix el FEED RSS del teu blog i publicat un article de forma aleatoria  ( Mastodon, Tumblr, BlueSky )
#
# Tens que tindra instalats els següents paquets de python:
#  - os
#  - feedparser
#  - random
#  - requests
#  - atproto
#  - mastodon
#  - pytumblr
#  - python-dotenv
#
# Modificat per: Victor Santos
# Web: https://vctrsnts.github.io
#
import os
import random
import requests
import feedparser
from atproto import Client as BskyClient, models as BskyModels
from mastodon import Mastodon
import pytumblr
from dotenv import load_dotenv

def load_environment_variables():
    # CARREGA LES VARIABLE D'ENTORN DES DE EL FITXER GENERAL
    load_dotenv()
    return {
        'bsky_user': os.getenv('BSKY_USER', False),
        'bsky_pass': os.getenv('BSKY_PASS', ""),
        'mastodon_token': os.getenv('MASTODON_TOKEN'),
        'mastodon_url': os.getenv('MASTODON_URL'),
        'consumer_key': os.getenv('CONSUMER_KEY'),
        'consumer_secret': os.getenv('CONSUMER_SECRET'),
        'oauth_token': os.getenv('OAUTH_TOKEN'),
        'oauth_secret': os.getenv('OAUTH_SECRET'),
        'feed_url': os.getenv('FEED_URL'),
        'image_url': os.getenv('IMAGE_URL'),
        'blog_name': os.getenv('BLOG_NAME'),
        'postBsky': os.getenv('POST_TO_BSKY', 'false').lower() == 'true',
        'postMastodon': os.getenv('POST_TO_MASTODON', 'false').lower() == 'true',
        'postTumblr': os.getenv('POST_TO_TUMBLR', 'false').lower() == 'true'
    }

def fetch_feed_entries(feed_url):
    # LLEGEIX EL FEED I ENS RETORNAR ELS ITEMS DEL FEED
    feed = feedparser.parse(feed_url)
    return feed.entries, feed.feed.title

def select_random_item(entries):
    # ES SELECCIONAR UN ARTICLE ALEATORI
    return random.choice(entries)

def fetch_image_data(image_url):
    # OBTENIM DADES DE LA IMATGE DE LA URL
    response = requests.get(image_url)
    response.raise_for_status()
    return response.content

def post_to_bluesky(user, password, feed_url, image_url):
    client = BskyClient()
    client.login(user, password)
    
    entries, feed_title = fetch_feed_entries(feed_url)
    item = select_random_item(entries)
    
    titulo = item.title
    uri = item.link
    
    img_data = fetch_image_data(image_url)

    thumb = client.upload_blob(img_data)
    embed = BskyModels.AppBskyEmbedExternal.Main(
        external=BskyModels.AppBskyEmbedExternal.External(
            title=feed_title,
            description=titulo,
            uri=uri,
            thumb=thumb.blob,
        )
    )
    client.send_post('Recordant articles ja publicats:', embed=embed)

def fetch_random_article(feed_url):
    d = feedparser.parse(feed_url)
    feedlen = len(d['entries'])
    num = random.randint(0, feedlen - 1)
    entry = d['entries'][num]
    title = entry['title']
    link = entry['link']
    summary = entry.get('summary', '')
    tags = [tag.term for tag in entry.get('tags', [])]
    return title, link, summary, tags

def post_to_mastodon(token, url, feed_url):
    mastodon = Mastodon(access_token=token, api_base_url=url)
    title, link, summary, tags = fetch_random_article(feed_url)
    status = f"Recordant articles ja publicats:\n{title}\n{link}"
    mastodon.status_post(status)

def authenticate_tumblr(client_vars):
    client = pytumblr.TumblrRestClient(
        client_vars['consumer_key'],
        client_vars['consumer_secret'],
        client_vars['oauth_token'],
        client_vars['oauth_secret']
    )
    return client

def create_tumblr_post(client, blog_name, feed_url):
    title, link, summary, tags = fetch_random_article(feed_url)
    description = f"<strong>Recordant articles ja publicats:</strong><br>{summary}"
    client.create_link(
        blog_name, 
        title=title, 
        url=link, 
        description=description, 
        tags=tags
    )

def main():
    env_vars = load_environment_variables()
    
    if env_vars['postBsky']:
        post_to_bluesky(env_vars['bsky_user'], env_vars['bsky_pass'], env_vars['feed_url'], env_vars['image_url'])
    
    if env_vars['postMastodon']:
        post_to_mastodon(env_vars['mastodon_token'], env_vars['mastodon_url'], env_vars['feed_url'])
    
    if env_vars['postTumblr']:
        client = authenticate_tumblr(env_vars)
        create_tumblr_post(client, env_vars['blog_name'], env_vars['feed_url'])

if __name__ == "__main__":
    main()
```

A continuación, os explico lo que hace cada función ( más o menos ):

### main()
Función de inició y la que se encarga de:
- Cargar las variables del fichero general `load_environment_variables()`
- Verifica si `postBsky`, `postMastodon`, `postTumblr` es `true`, porque si es `false`, la función de postear un mensaje en la red social correspondiente (Mastodon, Tumblr o BlueSky), no se ejecutaria.

### create_tumblr_post(client, blog_name, feed_url)
Función que se encarga de enviar un post a **Tumblr**, necesita:
- `Client`, la conexión con **Tumblr**.
- `blog_name`, nombre de tu blog en esta red social, esto es asi, porque puedes tener más de uno.
- `feed_url`, archivo RSS de nuestra web.

### authenticate_tumblr(client_vars)
Función que por decirlo de alguna manera, se encarga de hacer la conexión con **Tumblr**.

### post_to_mastodon(token, url, feed_url)
Función que se encarga de postear los mensajes a **Mastodon**, necesita:
- `token`, validación con **Mastodon**.
- `url`, instancia que utilizamos.
- `feed_url`, archivo RSS de nuestra web.

### fetch_random_article(feed_url)
Función que se encarga de seleccionar aleatoriamente un articulo para postear en las redes que tengo configuradas en este momento (Mastodon y Tumblr), no se usa para **BlueSky** porque esta funciona de una manera diferente. El fin es el mismo, pero 😅
- `feed_url`, archivo RSS de nuestra web.

### post_to_bluesky(user, password, feed_url, image_url)
Función que se encarga de posterar los mensajes a **BlueSky**, necesita:
- `user`, `password`, usuario y password de validación.
- `feed_url`, archivo RSS de nuestra web.
- `image_url`, imagen que queremos que acompañe a nuestro post.

### fetch_image_data(image_url)
Función que se encarga de obtener la información de la imagen que quieres que acompañe al post de **BlueSky**.

### select_random_item(entries)
Función que se encarga de seleccionar aleatoriamente un articulo pero para **BlueSky**.

### fetch_feed_entries(feed_url)
Función que se encarga de cargar todos los items / articulos del fichero RSS.

### load_environment_variables()
Función que se encarga de cargar todas las variables necesarias para el correcto funcionamiento del script, que en este caso son las siguientes:
- `BSKY_USER`, `BSKY_PASS` usuario y password para **BlueSky**
- `MASTODON_TOKEN`, `MASTODON_URL` token y dirección del servidor para **Mastodon**
- `CONSUMER_KEY`, `CONSUMER_SECRET`, `OAUTH_TOKEN`, `OAUTH_SECRET`, las validaciones de credenciales para **Tumblr**.
- `FEED_URL`, dirección del `feed` de nuestra pagina web.
- `IMAGE_URL`, dirección de la imagen que queremos que se visualize en **BlueSky**
- `BLOG_NAME`, nombre del blog que usamos en **Tumblr**.
- `POST_TO_BSKY`, `POST_TO_MASTODON`, `POST_TO_TUMBLR`, en que redes sociales queremos postear. Tiene que ser `true` para que se *activen*.

Solo nos falta, antes de nada probarlo. Que en mi caso, fue en un *entorno virtual* de pruebas que tiene **Python**, no sabia que eso existia, y se hace de la siguiente manera:

```bash
usuari@debian:~$ python -m venv .venv
usuari@debian:~$ source .venv/bin/activate
``` 

Ahora si que podemos hacer todas las pruebas que queramos si necesidad de estropear o ensuciar nuestro sistema, porque una vez que hemos acabado, se desactiva y todo queda igual de limpio que antes de empezar las pruebas.

Eso si, para hacer funcionar el script, tenemos que tener instalados los siguientes paquetes o modulos de **Python**:

```bash
usuari@debian:~$ pip3.9 install feedparser twython Mastodon.py PyTumblr python-dotenv atproto requests
```
Por ultimo, ahora si, nos queda añadir este script en nuestro servidor, que en mi caso es *unRaid* para que cada noche se ejecute (vendito modulo **user_scripts**) y ya lo tendriamos todo listo y funcionando.
#### Referencia
- [Script de Python para publicar un Feed de forma aleatoria en Twitter y Mastodom](https://elblogdelazaro.org/posts/2021-08-16-bot-en-python-para-publicar-un-feed-de-forma-aleatorios-en-twitter-y-mastodom)
- [ChatGpt](https://chatgpt.com)
- [Copilot](https://copilot.microsoft.com/onboarding)

