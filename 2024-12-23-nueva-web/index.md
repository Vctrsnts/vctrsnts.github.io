# Nuevo sitio web

Que no cunda el panico ante el titulo de este articulo.

No voy a hacer ningun cambio en este web ni voy a borrarlo todo e irme de hermitaño a una cueva 🤣

Solamente es para informar, que como tenia **wordpress** una pagina web donde iba subiendo los libros que he ido leyendo durante estos años, pues ...

<!--more-->

De la misma manera que me paso antes, cuando di el salto a **GitHub** para tener un poco más de control sobre la web, más que *wordpress* seguro que lo tengo, pues he hecho lo mismo pero esta vez en **GitLab**.

A parte de toda la creación de los articulos, donde sigo usando **Jekyll** para la generación del sitio estatico, tambien me ha servido para aprender como es el funcionamiento de **GitLab**. Eso si, tengo que decir que es muy diferente a **GitHub** en todo, o en casi todo.

Lo veo todo más lioso y más confuso, me resulto más facil **GitHub**, pero eso si tengo que decir que los [articulos](https://elblogdelazaro.org/search/?q=GitLab) de **Lazaro** me sirvieron de punta de lanza para resolver todas las dudas que me iban surgiendo con respecto a funcionamiento y creación de un sitio en **GitLab**. 

De nuevo **gracias Lazaro por tus articulos**.

Tambien, tengo que decir que me apoye en **Copilot** (y tengo que decir que me ayudo más que **ChatGPT**), para crear un script que me facilitara el proceso de subir los archivos a mi repositorio, porque siempre lo he encontrado tedioso y complicado.

El script que estoy usando actualmente para subir los archivos resultantes de mi sitio a **GitLab**:

```bash
  #!/bin/bash

  # Up2GitLab 0.2
  # Actualitzar facil i rapidament el teu repositori de GitLab
  # (CC) 2024 Victor Santos
  # https://vctrsnts.github.io
  # Bajo licencia GNU/GPL

  # Mode de fer servir: executal de la següent manera:
  # sh up2GitLab.sh

  # Actualitzacio del public key amb GitLab perque sempre tenia problemes amb la key
  eval "$(ssh-agent -s)"
  ssh-add /root/.ssh/idKeyGitLab

  # Validació de que estem 'conectats' a gitlab
  ssh -T git@gitlab.com

  sleep 10

  # A traves de Docker, actualitzem el fitxer RSS
  # docker exec jekyll_book bundle exec jekyll build
  # cp ../Gemfile .
  docker exec jekyll_book bundle exec jekyll build

  sleep 10

  cp ../Gemfile .

  # Solicita el mensaje del commit
  read -p "Introduce el mensaje del commit: " commit_message

  rm -rf .fuse*

  # Asegúrate de estar en el directorio del repositorio
  repo_dir="directori on esta el _site de jekyll"
  cd "$repo_dir" || { echo "Directorio del repositorio no encontrado"; exit 1; }

  # Establecer el repositorio remoto (opcional, si no está ya configurado)
  remote_repo="el teu repositori de GitLab"
  git remote add origin "$remote_repo" 2>/dev/null

  # Configurar la reconciliación de ramas divergentes
  git config --global pull.rebase false

  # Añade todos los cambios al índice
  if ! git add .; then
      echo "Error al añadir cambios"
      exit 1
  fi

  # Realiza el commit amb el següent missatge
  if ! git commit -m "$commit_message"; then
      echo "Error al realitzar el commit. Verifica que hi hagi canvis per pujar."
      exit 1
  fi

  # Realiza el push a la rama master
  if ! git push origin main --force; then
      echo "Error al realitzar el push a la rama master"
      exit 1
  fi

  # Registre dactivitats
  log_file="$repo_dir/push_log.txt"
  echo "$(date): Commit realitzat amb el missatge '$commit_message' i push a la rama master" >> "$log_file"

  echo "Canvis pujats amb exit a la rama master."
```

Algunos os chocara el porque añado la **key** momentos antes de hacer el *push*, esto lo hago, porque como tengo a parte del repositorio de **GitLab** tambien tengo el repositorio de **GitHub** y a veces el sistema se volvia loco, no he encontrado explicación a esto, prefiero hacerlo de esta manera y asi me evito problemas y mezclo los ficheros entre los diferentes sitios. No tendria que pasar, pero nunca se sabe. Los caminos del señor son inescrutables 😇.

Asi mismo, tambien tengo un `sleep 10` porque de esa manera evito que a la hora de actualitzar mi repositorio me suba un ficher `.fuse*` a **GitLab**, pero no funciona del todo bien. Esto es debido, a que antes de actualizar el repositorio, ejecuto `docker exec jekyll_book bundle exec jekyll build` para regenerar los siguientes ficheros:
- `feed.xml`
- `sitemap.xml`
- `robots.txt`

Con la dirección correcta del sitio, porque sino, a la hora de subirlo al repositorio, me lo subia con la ip por defecto de **Jekyll**, que no es otra que *http://0.0.0.0:4000* y de esta manera, es lo que he encontrado yo, pone la correcta.

Con este script, subo los archivos al repositorio de **GitLab**, espero los 5 minutos de rigor para que se actulize el sistema y ya lo tengo todo actualizado y listo para visitar.

Además como tambien tiene el feed que junto al script que podeis encontrar en este [articulo](/2024-12-10-publicar-redes-sociales) voy publicando, eso si en [Tumblr](https://www.tumblr.com/vctrsnts), para no mezclar articulos de diferentes tematicas (informatica, tecnologia, etc..) con los articulos de los libros en Mastodon. Eso si, tengo que pensar si los publico en [BlueSky](https://bsky.app/profile/vctrsnts.bsky.social) o no que es más como un **Twitter - X** pero en sus comienzos. A ver cuanto dura.

Después de todo esto, [aqui](https://vsantos.envs.net) podeis encontrar la nueva pagina web donde voy colgando los libros que he leido.

{{< admonition tip >}}
Antes de nada, avisar que la web, esta en **Catalán**. Se que un sitio de este estilo, ya de por si, tendra pocas visitas y aun menos si esta en catalán. 

Y hasta aqui puedo leer, porque sino me encenderia y este no es ni el lugar para eso 🤬 🔥.
{{< /admonition >}}

Espero que os sea de utilidad y encontreis libros que os gusten y que yo ya he leido. Si teneis dudas, podeis contactar conmigo, para preguntar sobre alguno en concreto.
{{< admonition note >}}
Aun me faltan por añadir unos cuantos más. Es lo malo que tiene de ir a trabajar en Rodalies / Renfe, que tienes mucho tiempo libre 🤣.
{{< /admonition >}}
#### Referencia
- [Cómo crear un sitio web estático en Gitlab Pages](https://elblogdelazaro.org/posts/2018-12-10-sitio-web-estatico-gitlab)
- [Como crear un blog con Jekyll y Gitlab Pages](https://elblogdelazaro.org/posts/2017-09-23-jekyll-y-gitlab)
- [Parlem de llibres](https://vctrsnts.gitlab.io)

