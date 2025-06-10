# Usando Calibre-Web

Después del descubrimiento de **docker**, tal como dije en otra entrada se ha abierto un nuevo mundo de posibilidades por explorar. Y en este caso hemos descubierto **calibre-web**.

La idea me gusto, porque así, voy quitando peso al portátil y doy más uso a la RPI3b (de momento a la espera de cambiar a una 4) y además, con el *HDD de 4Tb* que viene en camino, pues nos pusimos a ello.

<!--more-->

Lo primero fue bajarse la imagen correcta y construir el `docker-compose.yaml` correcto (a continuación pongo el que yo uso):

```yaml
calibre:
 image: linuxserver/calibre-web
 container_name: calibre
 restart: unless-stopped
 ports:
   - 9393:8083
 environment:
   - PUID=1001
   - PGID=1001
   - TZ=Europe/Madrid
 volumes:
   - ${STORAGE}/config/calibre:/config
   - ${MEDIA}/ebooks:/books
```

Luego hay que hacer un simple:

```bash
usuari@raspberry:~$ docker-compose up -d calibre
```

Ya lo tienes funcionando sin ningún problema (aunque no es del todo cierto) porque para empezar a funcionar correctamente tienes que ponerle la librería (*metadata.db*) que venias usando hasta este momento. Una vez hecho esto ya tienes tu **calibre-web** en funcionamiento.

El único problema que tenia yo y que no me gustaba, es que a la hora de subir los libros (tienes que dar permiso para que se pueda hacer) los datos del libro y la caratula, no te los coge de los metadatos del propio libro, sino que busca la información a través de **Google** o de **Douban** y esto yo no quería que fuera así.

Después de investigar, probar otras aplicaciones (es una lastima que no haya el **calibre** disponible para la arquitectura **ARM**, porque para **x86** si que esta), ninguna me gustaba tanto como **calibre-web**. Hasta que al final, revisando los ficheros que tiene el container, dentro del *directorio app* hay unos ficheros de información (podrían estar más accesibles o estar en la documentación del container) te informa que si instalas (la imagen se basa en ubuntu) el paquete **lxml** se puede tener acceso a los **metadatas** de los libros, así que me puse a ello:

```bash
usuari@raspberry:~$ sudo apt-get update
usuari@raspberry:~$ sudo apt-get install --no-install-recommends python3-lxml
```

Después de instalar el paquete, probé a subir un libro y ya si que funciono como yo quería, como la versión de calibre que te instalas en modo local.
#### Referencia

