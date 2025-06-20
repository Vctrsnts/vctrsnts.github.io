# Como funciona esta web y su creación

Después de leer el [articulo](https://elblogdelazaro.org/posts/2023-05-08-como-publico-este-blog) que habia publicado **Carlos M.** en su blog, pense, que porque no hacer lo mismo con el mio.

<!--more-->

Eso si, tengo que indicar antes, que su articulo, es mucho mejor que el mio, porque el funcionamiento de mi pagina web es muy parecido a la suya, pero con alguna diferencias. La primera y más importante, es que yo no uso **Emacs** ni **Org-Mode**.

Mi web es mucho más simple, pero eso si, intentaremos seguir un poco la guia que puso **Lazaro**, para que sea facil seguir la mia.

### Hardware
Es un poco subjetivo, en mi caso decir **Hardware**, porque en mi caso, todo depende de 2 ordenadores. El primero es mi portatil de uso normal (personal) que es desde donde escribo los articulos gracias a `markdown` y esto lo hago a traves de [Geany](https://www.geany.org), si ahora es cuando todos me vais a echar en cara que habia dicho en este [articulo](2022-12-19-cambiando-de-editor-neovim.md) que estaba usando `nvim` y que esta decisión, habia venido después de ver el video de [Atareao](https://www.youtube.com/watch?v=SoDjVPr5_Go&list=PL3lTiK2rXrUEL52KOZcTBsoLMndfFBV2Q) donde explicaba que habia echo el cambio de `vim` a `neovim` para mejorar su productividad.

Yo hice lo mismo, pero después de unos meses de usarlo, me he dado cuenta, que en mi caso, para el uso que le doy a `neovim`, que es solo para los articulos de mi blog, me resultaba todo más lento y esto es porque aun me falta mucho por aprender de `vim` y de `neovim` y como no le voy a dar todo el uso que tendria que darle, pues la curva de aprendizaje seria muy lenta y sobretodo, tediosa porque como digo, no voy a sacarle todo el partido, por ese motivo, me he tirado a `Geany` que es lo más parecido a `notepad++` que era el que usaba cuando estaba programando y con el que estuve más comodo.

Pero no nos vayamos por las ramas y volvamos al **hardware**, como he dicho antes, para escribir los articulos uso mi portatil personal y que gracias a las ideas que saque del articulo de Lazaro, lo sincronizo con mi [servidor](2023-08-01-de-nuevo-cambiando-servidor.md) que junto con el container, docker, de Jekyll veo el resultado de como quedara todo.

Una vez, hechas todas las comprobaciones y validaciones, uso otro script, tambien en bash, que actualiza mi arbol del projecto de ***GitHub*** que es donde tengo alojada mi web.

Como veis, uso 2 ordenadores, seguramente podria usar uso solo, pero de momento, estoy comodo con este funcionamiento.

### Scripts
Como he dicho antes, tengo 2 scripts para la sincronización de los articulos con el servidor y luego otro para sincronizar con el arbol de GitHub.

El primero de estos scripts, el de sincronizar con el servidor funciona a traves `rsync` de la siguiente manera:
```bash
#!/bin/bash
rsync -azvhP --rsh='ssh -pPORT' --exclude='draff' DIRECTORI_ORIGEN USUARI@IP_SERVIDOR:/DIRECTORI_DESTI
```

Usando este script, hay que tener en cuentas unas cosas (como yo lo tengo configurado):
- **PORT**: Es el puerto que uses para comunicarte con el servidor, en mi caso, no uso el por defecto de `SSH`
- **exclude**: el / los directorios que quieres excluir a la hora de sincronizar los directorios.
- **DIRECTORI_ORIGEN**: Es el directorio donde tenemos los ficheros `origen`
- **USUARI@IP_SERVIDOR**: El usuario y ip del servidor al que nos tenemos que conectar
- **DIRECTORI_DESTI**: Directorio de destino, es el que `rsync` actualizara los archivos que esten en el directorio de origen.

El segundo script, tambien en bash, sirve para sincronizar el projecto que tengo en local con el projecto que tengo en GitHub. 

Lo primero que hay que tener en cuenta, es que para usarlo, lo que se tiene que hacer, tal como yo lo tengo, es que el servidor tenga las claves `SSH` dadas de alta en GitHub para que asi, no tengas que estar insertando todo el rato el usuario y el password.

Si esto ya lo tienes, ahora solo falta el script:
```bash
#!/bin/bash

# UpToGit 0.1
# Actualiza facilmente tu repositorio Git
# (CC) 2011 Alfonso Saavedra "Son Link"
# http://sonlinkblog.blogspot.com
# Bajo licencia GNU/GPL

# Modo de uso: copia o mueve este script a /usr/bin o /usr/local/bin y desde el directorio donde se encuentre la copia de un repo git, ejecútalo de esta manera:
# uptogit <ficheros>

# Comprobamos si el directorio en el que estamos es de un repositorio git
if [ ! -d '.git' ]; then
  echo 'Esta carpeta no contiene un repositorio Git'
  exit -1
fi

# Ahora comprobamos si se le paso algun parametro
if [ $# == 0 ]; then
  echo "UpToGit: ¡Error! No se le a pasado ningún parámetro"
  echo "uptogit fichero1 fichero2 ... ficheroN"
  exit -1
else
  # Recorremos los parametros para comprobar si son ficheros o directorios
  for file in $*; do
    if [ ! -e $file ]; then
      echo "UpToGit: El archivo o directorio $file no existe"
      exit -1
    fi
  done

  # Si llegamos hasta aquí, indicamos a Git los archivos a subir
  git add $*

  # Esto nos pedira el mensaje del commit
  echo "Introduce el mensaje del commit:"
  read TXT
  git commit -m "$TXT"

  # Y terminamos subiendo los archivos
  git push --force origin master

fi
```
Este script, tal como he dicho antes, actualiza nuestro repositorio de GitHub. Para su uso se ejecuta de la siguiente manera:
```bash
usuari@debian:~$sh up2Git.sh arxiu1, arxiu2, etc...
```

Donde:
- `arxiu1, arxiu2, etc...`: Son los archivos que quieres sincronizar. Si pones el `.` estas indicando que quieres sincronizar todo el directorio.
- `Introduce el mensaje del commit`: Nos esta pindiendo un mensaje para describir la acción que vamos a llevar a cabo (yo lo entiendo asi).

Con esto, ya tenemos actualizado nuestro repositorio con GitHub.

### Publicación
Para la publicación, se puede decir, que ya se ha hecho con el segundo de los scripts que antes he puesto.

Lo unico que falta, es otro script, esta vez hecho en `python`, de factoria tambien de [Carlos M.](https://elblogdelazaro.org/posts/2021-08-16-bot-en-python-para-publicar-un-feed-de-forma-aleatorios-en-twitter-y-mastodom) que lo que hace es crear un toot en **Mastodon** con el ultimo articulo publicado en nuestro blog.

En el articulo, puedes ver como se hace tanto para `Twitter` como para `Mastodon`, pero en mi caso yo solo uso `Mastodon`.

El script es el siguiente:
```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

# script que lee el feed rss de un blog y publica el ultimo articulo creado en Mastodon

# Tienes que tener instaladas las librerias feedparser, Twython, Mastodon

# Autor: Carlos M.
# https://elblogdelazaro.org

# Llama los modulos Python
import feedparser
from twython import Twython
from mastodon import Mastodon

# Llamando a las llaves del Diccionario (Twitter)
CONSUMER_KEY = "xxxxxxxxx"
CONSUMER_SECRET = "xxxxxxxxx"
ACCESS_KEY = "xxxxxxxxx"
ACCESS_SECRET ="xxxxxxxxx"

# Seleccionamos el Feed
feed = 'ADREÇA DEL FEED'

# Parseamos el Feed
d = feedparser.parse(feed)

# Inicializa la API de Twitter, escribe el nuevo estado y salimos d['entries'][0] es el último articulo publicado
status_text = d['entries'][0]['title'] + '\n' + d['entries'][0]['link']
articulo = ("Ultimo articulo publicado:" +'\n' + status_text)

# Publica en mastodon

# Token y url de la Instancia
mastodon = Mastodon(
  access_token = 'TOKEN_MASTODON',
  api_base_url = 'https://URL_TU_MASTODON/'
)

mastodon.status_post(articulo)
```

Con esto, esta explicado todo el funcionamiento desde la creación del articulo hasta la publicitación de dicho articulo en Mastodon. Seguramente, el articulo de **Lazaro** le da mil vueltas al mio, pero...
#### Referencia
- [Como publico este blog - el blob de lazaro](https://elblogdelazaro.org/posts/2023-05-08-como-publico-este-blog)
- [Geany](https://www.geany.org)
- [Actualiza facilmente tu repositorio de GitHub](https://sonlinkblog.blogspot.com)
- [Script para publicar el ultimo articulo en Mastodon](https://elblogdelazaro.org/posts/2021-08-16-bot-en-python-para-publicar-un-feed-de-forma-aleatorios-en-twitter-y-mastodom)

