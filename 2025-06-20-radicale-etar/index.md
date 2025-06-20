# Adios GCalendar. Hola Radicale

A partir de este [articulo](https://elblogdelazaro.org/sincronizar-gnome-calendar-con-un-servidor-caldav) de **Carlos M.** del que sigo tanto su [blog](https://elblogdelazaro.org/) como su canal de mastodon, me pico la curiosidad de si yo tambien podria tener un calendario ajeno al control de Google y si le sacaria todo el partido para ello.

Pues que quereis que os diga, si con el *calendario de Google* que lo uso para apuntar 3 notas, porque no voy a sacarle partido a mi propio calendario, pero controlado por mi. A parte, de que tambien permite tener tu propia agenda de contactos y que esta no este al alcance de *Google*.

<!--more-->

Entonces me empape con el articulo de **Carlos M.** y busque toda la información posible sobre la aplicación que el estaba usando, [Radicale](https://radicale.org/v3.html).

En principio, cuesta un poco de entender el funcionamiento que tiene, pero la explicare en lengua vernacula para que todos nos podamos entender. **Radicale** es un servidor de calendarios, donde tu los creas y luego con diferentes aplicaciones usas esos calendarios que has creado.

{{< admonition note >}}
Como ya he informado, **Radicale** tambien permite tener una agenda de contactos que tambien hare uso de ello y asi no tenerlo vinculado por la cuenta de **Google**, pero eso no quita, que los contactos que tengo en mi cuenta de **GMail** los vaya a borrar. Me serviran como copia de respaldo por si algun dia pasa alguna cosa.
{{< /admonition >}}

Cuando ya tenemos claro lo que queremos hacer, ahora vista la parte más **facil** o **dificil** segun se mire, la instalación del mismo. Pero que gracias a **docker** y la busqueda de información de como se hace, se vuelve muy facil.

Lo primero es el `docker-compose.yml` que en mi caso es el siguiente:
```yaml
radicale:
 image: grepular/radicale:3
 container_name: calendarRadicale
 restart: unless-stopped
 networks:
   - proxy
 user: root
 volumes:
   - ${HOME}/config/radicale/config:/etc/radicale/config:ro
   - ${HOME}/config/radicale/users:/etc/radicale/users:ro
   - ${HOME}/config/radicale/data:/var/lib/radicale
 labels:
   - traefik.enable=true
   - traefik.http.services.radicale.loadbalancer.server.port=5232
   - traefik.http.routers.radicale.entrypoints=websecure
   - traefik.http.routers.radicale.rule=Host(`${RADICALE_SERVER}`)
   - traefik.http.routers.radicale.middlewares=cors-headers@docker
   - traefik.http.middlewares.cors-headers.headers.accessControlAllowOriginList=*
   - traefik.http.middlewares.cors-headers.headers.accessControlAllowHeaders=Origin, X-Requested-With, Content-Type, Accept, Authorization
   - traefik.http.middlewares.cors-headers.headers.accessControlAllowMethods=GET, POST, PUT, DELETE, OPTIONS
```
Como os podeis dar cuenta, tambien he añadido las etiquetas de **traefik** para que asi, me de un plus más de seguridad a parte de toda la que ya tiene (que nunca es poca).

Aunque si vais a esta [dirección](https://github.com/Kozea/Radicale/wiki/Installing-on-Docker), podeis encontrar el docker que os facilita la propia aplicación de **Radicale**.

{{< admonition tip >}}
Lo que si que teneis que tener en cuenta, es que antes de iniciar el servicio de docker de **Radicale**, teneis que hacer creado los siguientes ficheros:
- `config.yml` donde estara la configuración del servicio.
- `user` donde estaran los usuarios que tienen acceso al servicio.
{{< /admonition >}}

En el caso de la configuración, en la pagina web de **Radicale**, más concretamente en su [github](https://github.com/Kozea/Radicale/blob/master/config) podeis encontrar el fichero de configuración por defecto, el cual luego puedes modificar a tu gusto.

Luego pasamos a añadir los usuarios que tendran acceso, esto se hace mediante `htpasswd -B -c /path/to/users usuari`, luego te pide la contraseña para ese usuario. Una vez, has ejecutado esta instrucción, te aparece el fichero `users` con el siguiente formato:
```bash
usuari:password_encriptat
```
Cuando ya tenemos el fichero de configuración y el fichero de usuarios, ahora si que podemos **instalar** el contenedor de **Radicale** mediante la famosa invocación a nuestro dios **docker compose** 😂

Despues de esto, ya tenemos instalado nuestro propio calendario, ahora solo hace falta acceder a el y empezar a crear los calendarios que necesitemos.

{{< admonition note >}}
En mi caso, lo que he hecho, ha sido descargar el calendario tanto de aniversarios como de tareas que ya tenia en **Google Calendar** y los he importado a **Radicale**. 
{{< /admonition >}}

Para importar los calendarios, una vez, los has descargado de Google, accedes a tu servidor de calendarios y accedes a la opción de la flecha azul:

![](/images/radicale_01.png "Importar Calendari")

Te pide el fichero, lo seleccionar y listo. Lo unico que te queda es cambiar el nombre del calendario y listo.

{{< admonition note >}}
Lo que si que he visto, es que hay unos plugins para modificar las funcionalidades del calendario, como cambiar la visualización de la web y que se pueda ver el calendario, pero no he descubierto como hacerlo, además, como lo voy a usar, de momento, solo en el movil, pues...
{{< /admonition >}}

Una vez ya tenemos todo preparado y configurado en el servidor, en mi caso, me falta la configuración de mi movil, que es donde más lo voy a utilizar, lo primero es instalar la aplicación [DAVx5](https://www.davx5.com) para tener acceso a los calendarios.

{{< admonition note >}}
No voy a explicar como se hace la configuración de esta apk que se puede descargar en [F-Droid](https://f-droid.org/ca) porque podeis encontrar mucha información al respecto. Lo que si que voy a comentar es lo que hice después de tener configurado el acceso y la sincronización de mis calendarios.
{{< /admonition >}}

Una vez que tenia esta parte echa, me puse a buscar la mejor aplicación de calendario que al menos no compartiera mis datos con todo el mundo y encontre 3 candidatos:
- [Etar](https://f-droid.org/packages/ws.xsoh.etar/)
- [ICSx](https://f-droid.org/en/packages/at.bitfire.icsdroid/)
  - De los mismos creadores que **DAVx**
- [ACalendar](https://play.google.com/store/apps/details?id=org.withouthat.acalendar&hl=es_ES)
  - Que me la recomendo, como no puede ser otro **Carlos M.**

Pero queria algo lo más *libre* posible, porque si habia salido de la sarten de **Google**, no queria caer en las brasas de otro, y quien mejor que la IA para aclarar estas dudas. 

Le puse las 3 aplicaciones y que tenian que cumplir con estos 3 requisitos, sino todos, al menos el primero y segundo, estos requisitos son:
- Funcionar con el servidor **Radicale**
- Ser *Open Source*.
- No compartir mis datos con otras empresas

El unico que cumplia con estos 3 requisitos era **Etar** asi lo he instalado y de momento no estoy teniendo ningun problema y no tiene nada que enviar al resto.

Pero aun no ha llegado ningun dia con alguna tarea pendiente, asi que a ver como funciona y como se comporta llegado ese dia.
#### Referencia
- [Sincronizar GNOME Calendar con un servidor CalDAV](https://elblogdelazaro.org/sincronizar-gnome-calendar-con-un-servidor-caldav)
- [Radicale Config](https://github.com/Kozea/Radicale/blob/master/config)
- [Radicale Docker](https://github.com/Kozea/Radicale/wiki/Installing-on-Docker)
- [Etar](https://f-droid.org/packages/ws.xsoh.etar/)
- [ICSx](https://f-droid.org/en/packages/at.bitfire.icsdroid)
- [ACalendar](https://play.google.com/store/apps/details?id=org.withouthat.acalendar&hl=es_ES)

