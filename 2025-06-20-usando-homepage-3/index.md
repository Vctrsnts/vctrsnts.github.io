# Usando HomePage. El Dashboard - 3

Un nuevo articulo hablando sobre **homepage**, este magnifico *dashboard* al que le tengo mucho cariño y que hace un tiempo, realizo una actualización en su configuración y que en mi caso, usuario de portatil no me funcionaba correctamente, porque las **5 columnas** que yo utilizo no se veian correctamente, abri un *issue* sobre este problema y parece ser que con la ultima actualización, ha solucionado este problema y ahora explicare como lo he hecho.

<!--more-->

Explicare como lo tenia actualmente instalado en mi servidor **unRAID** y que ahora he cambiado y me lo apunto por si en algun futuro lo necesito y nunca se sabe, a lo mejor os puede servir de ayuda.

Lo primero es la instalación que yo tenia en **unRAID**. Yo lo tenia a traves del plugin **compose**, pero cada vez que se reiniciaba el servidor, aunque son pocas veces, **homepage** dejaba de funcionar y tenia que detener el contenedor y luego volverlo a iniciar.

Pero claro, llega un momento que te cansas de estar asi y te pones a solucionar este problema y hoy ha sido ese dia.

Lo que he hecho, ha sido usar la tienda de **unRAID** para instalar **homepage** pero eso si, usando la configuración que estaba usando actualmente. Pero no todo iba a ser tan bonito de funcionar a la primera.

Cuando me iba a la ip de **homepage** me salia un error donde me indicaba que revisase el log y me aparecia el siguiente mensaje de error:
```bash
[2025-03-14T19:25:15.419Z] error: Host validation failed for: 192.0.0.40:2000. Hint: Set the HOMEPAGE_ALLOWED_HOSTS environment variable to allow requests from this host.
[2025-03-14T19:25:15.424Z] error: Host validation failed for: 192.0.0.40:2000. Hint: Set the HOMEPAGE_ALLOWED_HOSTS environment variable to allow requests from this host.
[2025-03-14T19:25:15.428Z] error: Host validation failed for: 192.0.0.40:2000. Hint: Set the HOMEPAGE_ALLOWED_HOSTS environment variable to allow requests from this host.
[2025-03-14T19:25:15.433Z] error: Host validation failed for: 192.0.0.40:2000. Hint: Set the HOMEPAGE_ALLOWED_HOSTS environment variable to allow requests from this host.
[2025-03-14T19:25:15.455Z] error: Host validation failed for: 192.0.0.40:2000. Hint: Set the HOMEPAGE_ALLOWED_HOSTS environment variable to allow requests from this host.
```

Anteriormente este error no me daba, hasta que me he dado cuenta que en el `docker-compose.yml` tenia puesto lo siguiente:
```yaml
services:
  homepage:
    #image: ghcr.io/gethomepage/homepage:v0.10.9
    image: ghcr.io/gethomepage/homepage:latest
    container_name: homepage
    restart: always
    ports:
      - "2000:3000"
    volumes:
      - /mnt/user/appdata/homepage/config:/app/config
      - /mnt/user/appdata/homepage/icons:/app/public/icons
      - /var/run/docker.sock:/var/run/docker.sock:ro
    environment:
      # ES LA OPCIO PROBLEMATICA
      - HOMEPAGE_ALLOWED_HOSTS=192.0.0.1:2000
    env_file:
      - .env
    healthcheck:
      disable: false
```
Pero claro, aqui lo tenia asi, pero en el caso de querer hacerlo mediante la aplicación de **unRAID**, como se tiene que hacer? Además en **homepage** como sabeis, hay unas variables para pasar parametros a las opciones que puedes ser, que normalmente esta en un archivo `.env`, pero claro como se hace para pasar el este fichero a **homepage**.

De nuevo, a buscar más información, si os dais cuenta, he empezado por una cosa y aun no he acabado y tengo más problemas, pero vayamos por partes 😀. Lo primero es lo primero, y esto es conseguir pasar archivo `.env` a **homepage** y esto al final despues de buscar en **unRAID** se hace de la siguiente manera.

Cuando instalas la aplicación, se tiene que activar la opción **expert** que te da más opciones que modificar. Una vez la tienes activada, tienes que ir a la opción **Extra Parameters** y añadir lo siguiente:

![](/images/homepage_01.png "Afegim fitxer .env")

He iniciamos la aplicación. Pero en mi caso, seguia apareciendo el mensaje y eso que habia añadido la variable **HOMEPAGE_ALLOWED_HOSTS** con la ip de servidor y el puerto, esto se tiene que hacer, siempre que no uses el puerto por defecto (3000). Pues nada, a seguir investigando.

Al final he encontrado la solución, que es añadir en la plantilla de **homepage** esta opcion de la siguiente manera:

![](/images/homepage_02.png "Afegim fitxer .env")

Se puede ver que tanto el identificador de la variable como la variable en si, yo les he puesto el mismo nombre, **HOMEPAGE_ALLOWED_HOSTS** y como valor, la ip de mi servidor y de nuevo a reinicar el contenedor. Pero esta vez hemos tenido suerte y **homepage** a empezado a funcionar perfectamente y con la configuración que tenia anteriormente.

Lo unico malo, es que tengo algunos iconos descargados porque no los tiene implementados este dashboard. Asi que tenia que buscar la manera de suplir lo que tenia antes con el nuevo funcionamiento. He probado de todo:
- Modificar el fichero de configuración por si era un problema del *path*.
- Copiar los iconos junto el fichero de configuración.
- Copias el directorio de iconos dentro del directorio de configuración.
- etc...

Pero no habia manera de que nada hiciera que se visualizaran los iconos que tenia, hasta que al final, he revisado como estaba el arbol de directorios de **homepage** dentro del contenedor y he visto lo siguiente:
```bash
|- app
  |- config # el directorio donde tengo los ficheros de configuración.
  |- public
    |- locales
    |- favicon.ico
    |- favicon-16x16.png
  |- src
```
Entonces he copiado los iconos aqui dentro y todo ha funcionado correctamente, pero claro, en el caso de detener el contenedor los iconos se perderan porque no se guardan y al final, he utilizado la magia de *docker* y los volumenes, he creado el directorio `/public/icons`, pero que icons esta en el host y esto lo he hecho a traves de un nuevo **path** que se añade en la plantilla de configuración de la siguiente manera:

![](/images/homepage_03.png "Afegim Path")

Y con esto, tengo acceso al directorio `public` donde tengo los iconos pero sin perderlos. Ya tenemos a la vista la meta de esta nueva instalación de **homepage** mediante la tienda de aplicaciones de **unRAID**.

Asi mismo, la otra cosa que tambien me traia de cabeza, es que en el widget de **PiHole** no podia ver ninguna información, porque el codigo de API me ha cambiado, es un tema que siempre me ha llevado de cabeza y no soy el [unico](Pihole V6 widget API authentication error) que tiene este problema.

Al final me he puesto con ello, buscando información de como se tiene que hacer correctamente. Habia encontrado este [video](https://www.youtube.com/watch?v=mC3tjysJ01E) donde explica como se tiene que hacer, pero es un poco antiguo, porque en este sentido, **PiHole** ha cambiando su manera de obtener el codigo de **API**.

Pero al final, después de mucho buscar, he [manera](https://github.com/gethomepage/homepage/discussions/4818) de conseguir la **API** de **PiHole**. En principio la cosa es facil, pero sino lo encuentras o esconden esta opción, pues...

Todo se basa, en que tienes que ir al *GUI* de **PiHole** y:
- Accedes a *System -> Settings -> Web Interface/Api*
- Una vez hecho echo, activas la opción *Expert*
- Le  das a *Configure app password* y copias el password que te aparece medianamente camuflago y acceptas.
  - No te asustes porque una vez hecho esto, te saca de la aplicación.
- Copias este *password* en el fichero de variables `.env` junto con la variable `HOMEPAGE_VAR_PIHOLE`.
- Recuerda, que en el fichero de los *servicios* de **homepage**, cuando defines la sección de **PiHole** tambien tienes que poner en nombre de la variable en *Key*:
```yaml
- PiHole:
  icon: pi-hole.png
  # IP DEL SERVIDOR PIHOLE
  href: http://192.0.0.3/admin/login
  description: Servidor PiHole
  siteMonitor: http://192.0.0.3
  container: pihole
  widget:
    type: pihole
    # IMPORTANT SI ESTEU A LA VERSIO 6
    version: 6
    url: http://192.0.0.3
    key: {{HOMEPAGE_VAR_PIHOLE}}
```
Ahora solo falta reiniciar el contenedor de **homepage** y todo volvera a funcionar correcttamente y como siempre tendria que haber funcionado, pero por desidia, nunca me habia puesto.

{{< admonition note >}}

{{< /admonition >}}

#### Referencia
- [Meet Homepage - Your HomeLab Services Dashboard](https://www.youtube.com/watch?v=mC3tjysJ01E)
- [Pihole V6 widget API authentication error](https://github.com/gethomepage/homepage/discussions/5061)
- [Updated pi-hole from 5 to 6 and the API key does not work anymore](https://github.com/gethomepage/homepage/discussions/4818)

