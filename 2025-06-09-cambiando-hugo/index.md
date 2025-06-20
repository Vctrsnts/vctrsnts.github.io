# Cambiando a Hugo

Antes de seguir con nuestro ultimo articulo sobre las copias de seguridad (*Restic, Backrest y Minio*) y seguramente  ya lo habreis notado si visitais este blog, es que ha habido un cambio sustancial en su diseño.

<!--more-->

Como informaba en este [articulo](/2024-05-30-cambios-blog-2), informba de los cambios que le habia hecho a mi blog esperando que fuera el ultimo cambio que hiciera, pero como pasa siempre, nunca digas **que de este agua no bebere**. Porque es lo que ha pasado.

Todo empezo mientras veia los articulos que iba publicando [Carlos M.](https://elblogdelazaro.org), donde explicaba como era el funcionamiento de **Hugo** y el porque el habia efectuado el cambio. En principio, después de leer sus articulos, me parecia que todo era igual a **Jekyll** que era lo que estaba usando en ese momento y asi se lo pregunte.

Me dijo que en principio, todo era igual, pero con una mejora muy sustancial, que en el caso de **Jekyll**, cuando instalas un tema, se tienen que descargar *modulos* que necesita el tema para su correcto funcionamiento, y en el caso de **Hugo** esto no es asi, porque todo el tema ya tiene implementado todo lo que va a necesitar y no necesitas descargar nada externo. Y como soy un culo inquieto, pues me puse a investigar como es realmente el funcionamiento de **Hugo** en comparación de **Jekyll**.

Entonces, me propuse cambiar mi blog personal de **Jekyll** a **Hugo** y ver como iba todo y como tengo el servidor local, pues que mejor sitio para hacer pruebas y no estropear nada de lo que ya tengo en funcionamiento.

La instalació de **Hugo** en mi servidor local, no la voy a explicar, porque teneis este [articulo](https://elblogdelazaro.org/hugo-server-en-lugar-de-nginx-o-apache-para-autoalojar-tu-sitio-web), lo que si que tengo que puntualizar, es que sino tienes creado el fichero `config.yml` o `hugo.toml` junto con cualquier tema, puedes poner el que quiera, porque lo necesita **Hugo** para iniciar, porque sino te da error.

Despues de iniciar el servidor, accedemos al contenedor:

```bash
usuari@debian:~$ docker exec -it hugoBlog sh

/app:~ hugo new site .
```

Es posible, que a la hora de usar esta instrucción, te da error porque te indica que ya existe un *sitio*, entonces, lo que yo hago, sin detener el contenedor, es borrar el fichero de configuración del tema, en mi caso es `hugo.toml` y entonces vuelvo a hacer la instrucción de antes, pero con la coletilla de `--force`, para que *si o si* me cree el nuevo sitio.

Una vez que se hace esto, se crea toda la estructura de directorios del nuevo sitio. Y aqui es cuando ya tienes a tu disposición el servidor **Hugo** con la siguiente estructura:
```bash
|- archetypes
|- assets
|- content
|- data
|- i18n
|- layouts
|- public
|- resources
|- static
|- themes
  |- LoveIt
|- hugo.toml
```
Entonces, en el directorio `themes`, descargas el tema que quieres utilizar (en mi caso después de probar muchos el que más me ha gustado es [LoveIt](https://github.com/dillonzq/LoveIt).

Una vez que ya tenemos nuestro tema preferido, ahora es cuando nos ponemos realmente a configurar el tema a nuestro gusto.

{{< admonition note >}}
Esta es la parte más dificl, porque hasta que no te habituas al fichero de configuración de **Hugo** vas un poco perdido. Es extraño que esto no me pasase con Jekyll, veia más ameno la configuración de este ultimo.
{{< /admonition >}}

Eso si, una vez que entiendes más o menos con va todo y para que sirve cada opción, se avanza más rapidamente.

{{< admonition tip >}}
Lo que si que hay que tener en cuenta, es la versión de **Hugo** que estas utilizando, porque no todos los temas estan actualizados para las nuevas versiones.
{{< /admonition >}}

Lo primero que hice, fue modificar la configuración del buscador, por defecto utiliza **algolia**, pero cuando hice pruebas, en mmi caso, no funcionaba nada bien, no se si la culpa es porque comente algun codigo que era necesario anteriormente.. En este caso, lo que yo hice fue usar **lunr**, que en mi caso me funciona perfectamente y me gusta más.
```yaml
  # Search config
  [params.search]
    enable = true
    # type of search engine ["lunr", "algolia"]
    type = "lunr"
```

Otras de las modificaciones que yo he realizado y se que esta como petición en la web del tema, es que se pueda desactivar la opción de cambiar el tema (blanco a negro), yo en mi caso, he modificar el siguiente fichero `header.html` y listo.

En mi caso, como usuario de *Mastodon* y *BlueSky* tambien me interesa tener disponibles el acceso desde la web a estas redes sociales. La de **Mastodon** es la más facil, porque el fichero de configuración, ya esta preparado para su configuración, lo que no esta disponible, es la de **BlueSky**, per en este caso, es muy facil, porque hay un [Pull Request](https://github.com/dillonzq/LoveIt/discussions/887), que hace referencia a esta petición y una persona explica las modificaciones que se tienen que hacer, que son las siguiente:

Para implementar **BlueSky** en el tema, lo primero, es descargar el icono, [simpleicons](https://simpleicons.org/?q=blues) en formato svg y ponerlo en la siguiente ruta `/assets/lib/simple-icons/icons/bluesky.svg`, una vez que ya hemos descargado el icono procedemos a modificar el fichero `social.yml` añadiendo lo siguiente:
```yaml
# Bluesky
bluesky:
  Weight: 73
  Title: Bluesky
  Icon:
    Simpleicons: bluesky
```

En este caso, sustituye el icono que viene por defecto en el fichero `social.yml` por este, yo lo cambie por el 5 que era el de FaceBook 😁 y con esto, ya hemos añadido **BlueSky** a nuestro tema.
{{< admonition note >}}
Cuando digo que me gusta mucho este tema es por estas cosas, porque el proyecto aunque parece que esta abanadonado no lo esta.
{{< /admonition >}}

Para finalizar, siguiendo otro de los muchos y fantasticos articulos que puedes encontrar en el [blogdelazaro](https://elblogdelazaro.org/adi%C3%B3s-a-google-analitycs-con-umami) que tiene como me gusta usar **Umami** para saber quien accede a mi sitio web, podeis estar tranquilos, porque es el sistema menos intrusivo de *analizadores* que por defecto no esta implementado en el tema y que yo iba a hacer añadiendo el script en el *header* de la web y listo. Pero de nuevo, cada vez, me gusta más este tema, alguien, tambien habia hecho la petición y habia implementado un [Pull Request](https://github.com/dillonzq/LoveIt/pull/761/files) sobre esta petición donde explicaba todas las modificaciones necesarias para activar esta nueva funcionalidad.

Lo primero, es añadir esto en el fichero de configuración `hugo.toml`:
```yaml
    # Umami Analytics
    [params.analytics.umami]
      # Es el servidor de umami
      src = ""
      # Identificador
      dataWebsiteId = ""
```
Luego unicamente nos queda añadir el script en si en el siguiente fichero `layouts/partials/plugin/analytics.html` con el siguiente codigo:
```html
{{- /* Umami Analytics */ -}}
{{- with $analytics.umami.src -}}
    {{- dict "Source" $analytics.umami.src "Async" true "Defer" true "Attr" ($analytics.umami.dataWebsiteId | printf `data-website-id="%v"`) | partial "plugin/script.html" -}}
{{- end -}}
```

Después de añadir estas nuevas funcionalidades, ya pase a revisar los errores que me daba **Hugo** y los más graves era que no encontraba los siguientes ficheros donde tenian que estar:
- `themes/LoveIt/layouts/_default/_markup` - aqui se tienen que modificar los siguientes ficheros:
  - `render-codeblock-goat.html`
  - `render-codeblock-mermaid.html`
  - `render-codeblock.html`
  - `render-image.html`
  - `render-link.html`
- `themes/LoveIt/layouts/partials/internal` - aqui se tienen que modificar los siguientes ficheros:
  - `x.html`
  - `x_simple.html`
- `themes/LoveIt/layouts/shortcodes` - aqui se tienen que modificar los siguientes ficheros:
  - `x.html`
  - `x_simple.html` 

Para solucionar el problema, lo que hice fue comentar el codigo que hacia la llamada a estos ficheros y todo se soluciono, se que no es lo correcte, pero a ver si en la proxima actualización del tema, esto se soluciona y como todo esta integrado en el tema, pues se solucionara solo.

Después de estas modificaciones, ya lo tenia todo para que funcionase todo correctamente, a parte, de tener que realizar las modificaciones necesarias en los ficheros `markdown` de los posts para el correcto funcionamiento con este tema.

Una vez realizada todas las modificaciones necesarias, el arbol de directorio con respecto al tema, quedaba de la siguiente manera:
```bash
|- assets
  |- data # donde se encuentra el fichero social.yml que hemos modificado para BlueSky
  |- images # donde ponemos el logo de nuestra web
  |- libs
    |- simple-icon
      |- icon # donde ponenos el icono / imagen de BlueSky
|- content
  |- posts # donde tenemos los articulos de nuestra web
  |- images # las imagenes que utilizamos en nuestra web, no confundir con el logo ni con favicon
  |- about # nuestro fichero about
|- data
|- i18n
|-layouts
  |- _default # ya lo explicare más adelante
  |- partial
    |- head # donde esta el fichero meta.html y que lo utilizo para añadir la opción de fediverse:creator
    |- plugin # donde esta el fichero analytics.html para umami
    |- header.html # lo hemos modificado para desactivar la opción de cambiar el estilo de la web
    |- footer.html # lo hemos modificado para añadir la opción de mastodonRelme
|- public
|- resource
|- static # donde se encuentran los iconos de la web (favicon)
|- theme
  |- LoveIt
```



Lo que si que tengo que decir que lo que más me gusta, es que para sobreescribir los ficheros del tema original, no tienes que modificar los ficheros del tema original, sino que creas un fichero igual pero con las modificaciones que quieres dentro del directorio `layouts` y este sobreescribe a los ficheros del tema original. Esto es lo que más me gusta, porque en el caso de que actualizes el tema original, estas modificaciones no las pierdes.

En principio, con todo esto, ya pensaba que tenia en marcha mi nuevo sitio web (local), con el que podria hacer pruebas para ver como se maneja todo. 

Entonces me di cuenta, que todo lo referente a los **Tags** (etiquetas) y **Categorias** no funcionaba tal como tenia que ser, a parte de que esta era una parte que no acababa de entender muy bien su funcionamiento, lo que provoco que me volviere literalmente me volvi loco buscando información de como se tenia que configurar. Ya me veis preguntando a **Copilot** como tenia que ir, y como siempre, la **IA** divagando, que lo hace con buena intención 😆 pero a veces lia más que otra cosa. Y se que tenia que funcionar, porque cuando hacia pruebas con otros temas, todo el tema de las **etiquetas** y las **categorias** funcionaban correctamente. Porque en este tema en concreto no iba.

Lo que si que me dejo claro la **IA** es que todo el tema de las **etiquetas** y **categorias** se controla con, en principio, con 2 unicos ficheros:
- `list.html`: Es la pagina que se encarga de hacer las listas, tanto de categorias como de etiquetas en **Hugo** en este tema en concreto.
- `term.html`: Es la pagina que te muestra los articulos que concuerdan con el **Tag / Categoria** que has seleccionado en este tema en concreto.

Miles de cambios, miles de configuraciones, modificaciones de ficheros, de nombres y sin conseguir nada. Lo unico que conseguia era como maximo un *404 - Not Found* o una pantalla en blanco, y se que tenia que funcionar, porque el ejemplo de **LoveIt** funciona correctamente.

{{< admonition tip >}}
Eso si, tengo que decir, que el ejemplo que ponen en los temas, lia un poco, porque no concuerda con la estructura que luego tu tienes, pero como base, sirve.
{{< /admonition >}}

Hasta que ayer, no se si la inspiración vino en mi ayuda, y eso fue, cuando la **IA** me dijo, que en las nuevas versiones de **Hugo**, los 2 ficheros que se encargan de las *Etiquetas* y las *Categorias* se tienen que ubicar en el directorio `_default`. Ya no perdia nada, asi que lo probe. Y funciono a la primera. No se porque antes no habia funcionado correctamente, porque esta misma prueba ya la habia hecho anteriormente, eso si, como modificaciones en el fichero `hugo.toml`, y no se si era por eso que no funcionaba, pero ahora, todo funcionaba perfectamente.

Aqui si que fue, cuando vi la luz al final del tunel, ya tenia el nuevo tema en **Hugo** y funcionando a las mil maravillas. Y que quereis que os diga, me gusta mucho porque, tiene todo lo que yo necesito, la maxima amplitud de la pantalla con el texto del articulo, porque eso de que los articulos ocupen tan poco, no me gusta nada. Además, los enlaces, sin que tu tengas que hacer nada, ya te los abre en una nueva pestaña. O sea que tiene todo lo que yo necesito.

Además, como tiene, que el lo que más me gusta, que en eso si que tengo que darle la razon a **Lazaro**, no necesitas instalar nada nuevo, todo lo que necesitas esta en el tema. Pues...

Cuando veais este articulo, significara que ya he hecho la migración de **Jekyll** a **Hugo**, aunque la unica parte que vosotros veis es el resultado en **HTML** que es el que subo a **GitHub**.

Pero al menos, ya tengo nuevos conocimientos, que primero nunca estan de más y segundo, me abre nuevas puertas para cambiar mi otra pagina [web](https://vsantos.envs.net) utilizando el servidor **Hugo**, porque lo que tambien me gusta, es que no tengo que usar nada ajeno a **unRaid** sino que el container esta en la tienda de aplicaciones, no como **Jekyll** que tenia que instalarlo a traves de un `docker-compose` y que nunca actualizaba por miedo a estroperar alguna cosa.

Pues bueno, aqui teneis como ha ido mi odisea en el cambio de **Jekyll** a **Hugo** y tengo que darle las gracias a **Lazaro** por todos los articulos que ha ido subiendo hablando sobre este ultimo y que me han ayudado mucho en esta migración.

Muchas gracias **Lazaro**.
#### Referencia
- [Hugo](https://elblogdelazaro.org/tags/hugo)
- [Added supported for umami](https://github.com/dillonzq/LoveIt/pull/761/files)
- [How to add bluesky icon and to show a pdf file](https://github.com/dillonzq/LoveIt/discussions/887)
- [Icon BlueSky](https://simpleicons.org/?q=blues)

