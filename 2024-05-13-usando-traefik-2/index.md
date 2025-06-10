# Usando Traefik - 2

De nuevo, con otro articulo de **Traefik**, en este caso, como se instala / activa el plugin **GeoBlock** para asi, tal como indica su nombre, **Traefik** en base al pais de origen de la **IP**, lo bloquea o no.

En este caso, igual que en el anterior articulo, partimos de la base de que tambien me encontre con problemas a la hora de poder usar este plugin, tanto en su instalación, como en su configuración. Pero como ya tenia la experiencia de instalar y activar toda la sección  de la redirección, esta vez, me resulto un poco más facil, solo un poco, todo porque ya entendia, más o menos como funcionaba **traefik**.

Hay que tener en cuenta, que la información, o el hilo del que tirar lo encontre gracias a nuestro querido Lorenzo ([atareao](https://atareao.es)) y en especial de este [articulo](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik).

<!--more-->

Para activar este plugin, lo primero es acceder a nuestra web de configuración de **traefik** e iremos a la sección de **plugins** y buscamos el que queremos instalar, que en este caso es **GeoBlock**. Aqui hay que tener una cosa en mente, si buscamos, nos apareceran 2 plugins pero con una pequeña diferencia. La versión de cada uno:
- GeoBlock v0.2.2
- GeoBlock v0.2.8

En nuestro caso, iremos a por la documentación de la versión **v0.2.8**, pero utilizaremos una version anterior para que nuestro sistema sea más estable (en mi caso, he usado la versión **v0.2.5**). Lo que si que podemos hacer, es cuando veamos que todo funciona correctamente, es pasar a una versión superior (**v0.2.6 - 7**).

Ahora es cuando viene la parte más importante, como **instalar** este plugin. Para ello, nos tenemos que ir al archivo de configuración de `traefik.yml`:

#### traefik.yml
Añadimos las lineas que **instalan** y **activan** este plugin:
```yaml
experimental:
  plugins:
    geoBlock:
      moduleName: "github.com/PascalMinder/geoblock"
      version: "v0.2.5"
```
Con esto indicamos lo siguiente:
- Queremos que use el plugin que se encuentra en **github.com/PascalMinder**
  - Esto es asi, porque tambien tenemos la posibilidad de instalar este plugin desde local.
- La versión que usaremos, que en este caso es la versión **v0.2.5**

Aqui lo importante es el nombre que le hemos dado en la configuración de `GeoBlock`, porque más adelante lo usaremos y si no ponemos el mismo, tendremos problemas.

Una vez, ya tenemos hecho esto, pasamos a la configuración del plugin en si, que se hace desde el archivo `dynamic.yml`:

#### dynamic.yml

{{< admonition info >}}
Recordar que ya habiamos añadido la configuración del usuario y password para los servicios que nos interesan, la configuración de **GeoBlock** se añade a continuación:
{{< /admonition >}}

```yaml
http:
  # EL NOMBRE DE LA SECCIÓN DE CONFIGURACIÓN DE GEOBLOCK
  myGeoBlock:
    plugin:
      # EL MISMO NOMBRE QUE TENEMOS EN EL ARCHIVO TRAEFIK.YML
      geoBlock:
        silentStartUp: false
        allowLocalRequests: true
        logLocalRequests: false
        logAllowedRequests: true
        logApiRequests: false
        api: "https://get.geojs.io/v1/ip/country/{ip}"
        cacheSize: 15
        forceMonthlyUpdate: true
        allowUnknownCountries: false
        unknownCountryApiResponse: "nil"
        countries:
          - PAISES QUE TIENEN ACCESO A NUESTROS SERVICIOS
```
Esta sección tiene muchas posibilidades para añadir, pero en mi caso, siguiendo las pautas de **Lorenzo** he usado las siguientes:
- **Countries**: Los paises que tienen acceso a este proxy.
- **API**: Con esta opción, es desde donde a partir de la IP que accede a nuestro proxy, saber de que pais es y bloquear en caso de que no sea de uno de los paises escogidos 😉

Estan son en grandres rasgos las más importantes, las otras opciones podeis buscar para que sirven.

Una vez, que ya tenemos **GeoBlock** configurado, en principio, ya esta todo listo para funcionar. Pero os recomiendo que detengais el docker de **traefik** y lo volvais a iniciar para asegurar de que coge la nueva configuración.

{{< admonition tip >}}
Antes de nada, voy a hacer un inciso porque, para ver si todo el sistema funciona correctamente, tenemos que acceder a los logs de **traefik** para ver que hace. En este caso, tenemos 2 opciones:
- Acceder directamente al contenedor de traefik y monitorizar los archivos de configuración `access.log`, `traefik.log`.
- Usar un pequeño script que, de nuevo tengo que darle las gracias a **Lorenzo** nos permite visualizar los logs mediante una pequeña instrucción y de un contenedor
{{< /admonition >}}

El script es cuestión se llama `dless` que es una variante del `less` original.

#### ./local/bin/dless
Que contiene lo siguiente:
```bash
    command="$1"
    if [[ -n "$command" && "$command" == *":"* ]]; then
        container=${command%:*}
        filepath=${command##*:}

        docker exec -it "$container" tail -f "$filepath"
    fi
```
En mi caso, lo he configurado para que haga un **tail -f** del archivo en cuestión, tu puedes poner la instrucción que más te guste. Yo tengo **tail**, porque asi puedo hacer un seguimiento del archivo en cuestión.

Para poderlo usar, antes tenemos que modificar nuestro fichero `.bashrc` para añadir la ubicación del script de la siguiente manera:
```bash
# AFEGIM DLESS
export PATH=~/.local/bin:$PATH
```
Para usarlo hacemos lo siguiente:
```bash
usuari@debian:~dless traefik:/var/log/traefik/access.log
```
Donde:
- **traefik**: Es el contenedor al que queremos acceder
- `/var/log/traefik/access.log`: La ruta y el archivo que queremos controlar.

Yo, en mi caso, hice unas cuantas pruebas para ver si funcionaba correctamente. Como tengo una VPN (plugin) en el navegador, lo que hice fue activarla y indicar que a partir de ese momento, salia desde un pais no permitido para ver que pasaba. Y funcionaba correctamente, porque me denegaba el acceso, después, desconectaba la VPN o indicaba que salia de uno de los **paises permitidos** no tenia ningun problema y podia acceder a los servicios que tengo en este servidor.

Pues ya tenemos un nivel más de protección para nuestro servidor.

Ahora solo me falta poder **activar** el plugin de **crowdsec** para traefik, pero eso ya es otro cantar. Es para el niveles avanzados y yo ahora mismo estoy en nivel intermedio, pero buscando la información necesaria para llegar a ese nivel 😉
#### Referencia
- [532 - Exprimiendo tu proxy inverso Traefik](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik)

