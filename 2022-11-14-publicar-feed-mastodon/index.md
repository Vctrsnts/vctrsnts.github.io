# Publicar feed en Mastodon / Twitter

Descubri a traves del [Blog de Lazaro](https://elblogdelazaro.org), que si tienes cuenta en `Mastodon`, quien no tiene cuenta ahora tal como van las cosas en `Twitter`,  que puedes enviar de forma aleatoria alguno de los articulos que tienes publicados en tu web.

<!--more-->

Asi que después de leer su articulo y ver si yo podia hacer lo mismo, me lie la manta a la cabeza y al lio.

Lo primero, es tener una cuenta y después tienes que crear un aplicación en `Mastodon` de igual forma que se puede crear en Twitter (explicación más adelante ).

Aprovechando que en el servidor ya tengo Python instalado, hare que se ejecute en el mismo servidor. Eso si, también tienes que instalar:
```bash
usuari@debian:~$ pip install --user feedparser mastodon
```
Para que Python pueda realizar el tratamiento del fichero `xml`.

Una vez que ya tienes la aplicación creada, tienes que crear un fichero en `Python` que tiene que tener la siguiente estructura:
```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

# el fitxer original es de Carlos M. (https://elblogdelazaro.org )

# Tens que tindre instalats les llibreries feedparser, Mastodon

# Realitzem la crida als moduls de Python
import feedparser
import random
from mastodon import Mastodon

# Reallitzem la crida a les claus del Diccionari
CUSTOMER_KEY = 'xxxxxxxxxxxxxxx'
CUSTOMER_SECRET = 'xxxxxxxxxxxxxxxxx'
ACCESS_TOKEN = 'xxxxxxxxxxxx'
ACCESS_TOKEN_SECRET = 'xxxxxxxxxxxxxxxxxxx'

# Informem de l'adreça del feed
feed = 'tu dirección web hacia el feed.xml'

# Descodifiquem el feed (arxiu XML)
d = feedparser.parse(feed)

# Obtenim la longitud del feed i aleatoriament seleccionem un article
feedlen = len(d['entries'])
num = random.randint(0, feedlen)

# Iniciem l'API de Mastodon, i escribim l'estat
status_text = d['entries'][num]['title'] + '\n' + d['entries'][num]['link']
articulo = ("Recordando artículos publicados:" + '\n' + status_text)

# Token y url de la Instancia
mastodon = Mastodon(
 access_token = 'XXXXXXXXXXXXXXXXXXXXXXX',
 api_base_url = 'https://mastodon.online/'
)
# Publiquem a Mastodon
mastodon.status_post(articulo)
```

Lo que tienes que tener en cuenta, es informar correctamente de:
- **CUSTOMER_KEY**
- **CUSTOMER_SECRET**
- **ACCESS_TOKEN**
- **ACCESS_TOKEN_SECRET**
- **feed**

Una vez, tengas el fichero creado, si quieres hacer pruebas, tienes que hacerlo de la siguiente manera :
```bash
usuari@debian:~$ python3 nombreDelArchivo.py
```

Entonces, si no has tenido ningun problema, a tu cuenta de Mastodon te llegara un articulo aleatorio de tu web.

Después de hacer las pruebas que creas oportunas, solo te quedara configurar el cron, para que se ejecute cuando tu quieras.

Yo lo tengo a que lo haga una vez a la semana, pero me estoy replanteando cambiarlo a que lo haga 3 veces por semana, porque a veces, añado articulos, que a lo mejor cuestan mucho a que salgan. Se que hay otro script, que lo que hace es publicar los ultimos articulos creados. Pero eso lo tengo que estudiar.

También tengo en cuenta, que si lo hago 3 veces a la semana (publicar toot) creare muchos mensajes, pero lo que también se puede hacer, es configurar Mastodon, para que elimine todos los toot con más de 6 meses de antigüedad (o menos).

Para la configuración del `CRON` lo tengo de la siguiente manera:
```bash
@weekly /usr/bin/python3 /home/tu_usuario/lugar_donde_tengas_el_script/botMastodonPythonRss.py
```

En el caso de que lo quisieras hacer funcionar en `Twitter` tienes que tener en cuenta las siguientes modificaciones al archivo de `Python`:
```python
# En vez de usar la libreria "Mastodon" de Python, tienes que usar "Twython"
from twython import Twython

api = Twython(CONSUMER_KEY,CONSUMER_SECRET,ACCESS_KEY,ACCESS_SECRET)
```

Luego, solamente tienes que añadir la siguiente linea para publicar el articulo en `Twitter`:
```python
api.update_status(status=articulo)
```

Espero que te sirva tanto como me ha servido a mi. Y eso si, no se te olvide darle las gracias a [Carlos M](https://elblogdelazaro.org) por el increible articulo en que me he basado yo.
#### Referencia
- [Script de Python](https://elblogdelazaro.org/posts/2021-08-16-bot-en-python-para-publicar-un-feed-de-forma-aleatorios-en-twitter-y-mastodom/)

