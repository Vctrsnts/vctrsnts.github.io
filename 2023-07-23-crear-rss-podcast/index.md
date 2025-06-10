# Crear RSS de los podcast que sigo

No se vosotros, pero no os habeis fijado que estos ultimos meses ha habido un auge con respecto a los podcast? No se si es porque la calidad ha subido o porque hay más, pero...

<!--more-->

Yo siempre he escuchado un programa de radio de ***Catalunya Radio*** que trata sobre la historia en general y como soy un entusiasta de la historia, pues este programa no podia faltar, pero claro, me lo programan a unas horas, que es imposible seguirlo. Asi que decidi mirar si tenian la opcion de descargar los programas en formato podcast, y resulto que si era posible.

Asi mismo, tambien empece a seguir a unos podcaster que hablan sobre tecnologia ([uGeek](https://ugeek.github.io), [Atareao](https://atareao.es), [PapaFriki](https://papafriki.gitlab.io/podcast), etc...) y me he aficionado a ellos, asi que tambien los puse en la lista de seguimiento. Pero claro, yo los puedo escuchar cuando puedo y este año (2023) ha sido un poco dificil, porque he tenido un año muy complicado.

Entonces empece a investigar la manera de descargar los podcast automaticamente y si que existe, más información en este [articulo](/2021-05-30-flexget-podcast). Y que además, tambien se puede hacer lo mismo con los otros podcast, mientras tengan un fichero ***RSS***, se puede descargar. Asi que lo más importante, conseguir los podcast ya estaba echo. Pero claro, ahora faltaba la parte de poderlos escuchar.

{{< admonition note >}}
Antes un pequeño inciso sobre mi manera de tratar los ficheros de podcast. Al principio, los podcast los trataba como si fueran ficheros de musica normales y corrientes, pero siempre intentaba tenerlos separados de la musica, en un directorio los podcast y en otro la musica, pero a la hora de escuchar, siempre acababan juntandose en la aplicación del movil que usaba (**D-Sub**, **Tempo**, etc...), asi que me puse a investigar y gracias a unos de los podcast, valga la redundancia, de [uGeek](https://ugeek.github.io/post/2022-12-07-charla-con-atareao-sobre-servicios-y-mucho-mas.html), donde explicaba que el estaba intentando crear su propio feed de los podcast que seguia, para que asi, a traves del movil o cualquier otra aplicacion, poderlos escuchar cuando fuera posible.
{{< /admonition >}}
Esa idea me gusto mucho y me puse a investigar, porque los conocimientos que tengo yo de bash son muy pocos y llegar al nivel para hacer lo que estaba explicando **uGeek** seria muy complicado. 

Despues de mucho buscar y probar, encontre este [proyecto](https://github.com/amsehili/genRSS) en github, que a traves de un fichero python, se crea automaticament el fichero RSS del directorio que tu le indicabas junto con el titulo y descripción y después, este mismo fichero RSS, lo puedes exponer a internet, para que cualquier aplicacion lectora de RSS (sobre todo las aplicaciones de podcast que funcionan a traves de ellos) pudiera tener acceso a estos podcast.

Aqui pongo un ejemplo de como uso yo este fichero:
```bash
usuari@debian:~$python3 /home/usuari/genRSS/genRSS.py -e mp3 -d directorio_podcast -H http://ip_servidor:puerto -i https://imagen_de_la_caratula.jpg -t "Titulo_del_Podcast" -p "Descripción del Podcast" -C -r -o fichero.rss.rss
```

Hay que tener un par de cosas a la hora de usar este fichero:
* Las caratulas de los podcast tiene que ser externa. No puedes tener la imagen en el servidor. Al menos en mi caso, yo no he conseguido que funcionen con imagenes de dentro del servidor.
* Yo tengo varias lineas (una por cada podcast que sigo) y asi me generar un RSS, y todo lo tengo en un fichero bash que cada dia se ejecuta para actualizar los RSS con los nuevos podcast que se han descargado.

Ahora, solo faltaba elegir un buen podcaster, creo que se llaman asi, para poder escuchar mis podcast, y me decidi por ***AntennaPod*** donde se podia añadir los RSS creados por mi mismo y poderlos escuchar.

Tengo que añadir, que para tener acceso a los ficheros RSS que habia creado en mi servidor, tenia que tener acceso a ellos y, en mi caso, esto lo hacia a traves de ***WEBDAV*** (como contenedor de docker), si quereis saber como se puede configurar, ***uGeek*** tiener un buen [articulo](https://ugeek.github.io/blog/post/2019-10-22-docker-servidor-webdav.html) donde explica como se hace y como hacerlo, especificamente en docker.

Tengo que decir que funcionaba todo perfectamente, pero eso si, abierto al peligroso mundo de internet y más, después de escuchar este [episodio](https://ugeek.github.io/post/2023-07-31-seguridad-en-mis-servicios.html) de **uGeek** que habla sobre la seguridad de nuestros servidores abiertos al mundo y se te ponen los pelos de punta.

La solución que daba, era usar una VPN (wireguard que ya tengo montada), en este [articulo](https://ugeek.github.io/blog/post/2021-05-28-el-modo-mas-facil-de-instalar-administrar-wireguard.html) podeis encontrar como se puede hacer y asi poder conectar a nuestro servidor y simular como si estuvieramos en nuestra propia red pero sin estarlo.

Tengo que decir que, ahora mismo, es como lo tengo funcionando y funciona a la perfección. Sin ningun corte ni nada, todo perfecto. Y para más inri, tambien tengo la musica en mi servidor y accedo a ella a traves de la VPN y sin problemas.

O sea, todo perfecto y funcionando a las mil maravillas, pero como ya se sabe, nunca se puede decir que todo esta perfecto, porque no es asi. Ahora estoy buscando información de como unificar las 2 aplicaciones (*AntennaPOD* y *Tempo*) para asi, poder escuchar todo (aunque sea por separado) pero en una sola aplicacion.

Asi que ya os explicare como acaba la cosa.
#### Referencia
- [WebDav - uGeek](https://ugeek.github.io/blog/post/2019-10-22-docker-servidor-webdav.html)
- [Seguridad en mis servicios - uGeek](https://ugeek.github.io/post/2023-07-31-seguridad-en-mis-servicios.html)
- [Charla con Atareao y algo más - uGeek](https://ugeek.github.io/post/2022-12-07-charla-con-atareao-sobre-servicios-y-mucho-mas.html)
- [El modo más facil de instalar y administrar Wireguard - uGeek](https://ugeek.github.io/blog/post/2021-05-28-el-modo-mas-facil-de-instalar-administrar-wireguard.html)
- [genRSS](https://github.com/amsehili/genRSS)

