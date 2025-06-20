# Matrix - 3. De Matrix a Gotify

Como bien sabeis, porque lo explique en este [articulo](/2025-03-25-instal-config-matrix) y en este [otro](/2025-03-27-pushbits), estaba usando **Matrix** como servidor de comunicación entre mis servidores y un servidor. Pero mientras más lo usaba, más desesperación me producia, porque, puede parecer una tonteria, pero en el movil, no recibia las notificaciones de los mensajes que me llegaban al cliente de **Matrix**, que en este caso era **FluffyChat**.

<!--more-->

Lo habia instalado tanto de **F-Droid** como de la **PlayStore** y en los 2 casos, con el mismo resultado, no me llegaban las notificaciones. Tambien habia probado **Element** con el mismo resultado. Instale **Synapse** también en el VPS para ver si el problema estaba en **Conduit**, pero ni asi lograba que me llegaran las notificaciones.

Investigue por todos sitios, *gitHub* de *Conduit*, matrix de *Conduit* y siempre con los mismos resultados, o no me respondian, o no entendian el motivo del porque no funcionaba.

Al final ya no sabia que hacer, hasta que [Carlos M.](https://elblogdelazaro.org/gu%C3%ADa-paso-a-paso-c%C3%B3mo-instalar-gotify-en-unraid) publico un nuevo articulo de como instalar **Gotify** en **unRaid**, en mi caso no seria en **unRaid**, porque sino, tengo que abrir el servidor al mundo entero y es una cosa que quiero evitar, pero como tengo el VPS, pues decidi instalarlo ahi. 

Tengo que decir que yo ya jugaba con un poco de ventaja con respecto a **Gotify**, porque hace un par de años, antes de usar **Telegram** como servidor de notificaciones de mis servicios y de **unRaid**, lo habia utilizado, pero no me acabada de convencer, porque eso de tener 2 aplicaciones abiertas en el movil, *telegram* y a la vez *gotify* para recibir las notificaciones, pues me parecia un derroche de bateria, asi que al final lo acabe poniendo todo el *telegram* porque era la que más usaba.

Asi que de vuelta al ruedo, a realizar la instalación de **Gotify**, a traves de su correspondiente `docker-compose`:

```yaml
 gotify:
   image: gotify/server:latest
   container_name: gotify
   env_file:
     - gotify.env
   volumes:
     - ${HOME}/config/gotify:/app/data
   networks:
     - proxy
   labels:
     - traefik.enable=true
     - traefik.http.services.gotify.loadbalancer.server.port=80
     - traefik.http.routers.gotify.entrypoints=websecure
     - traefik.http.routers.gotify.rule=Host(`${GOTIFY_SERVER}`)
```
Lo unico que hay que tener en cuenta es el fichero `gotify.env`:
```bash
TZ=Europe/Andorra
```
Que es donde se configura la zona horaria, pero el resto, es como cualquier otro *docker-compose*, ahora solamente queda hacer un `docker commpose up -d gotify` y listo, y como además lo tengo configurado para que use *traefik* siguiendo los magnificos articulos que pone a disposición del publico **atareo**, pues es todo mucho más facil.

Lo que si que tengo que agradecer a **Lazaro**, es que en su [articulo](https://elblogdelazaro.org/gu%C3%ADa-paso-a-paso-c%C3%B3mo-instalar-gotify-en-unraid), explica muy bien todo el tema de las aplicaciones, que seguramente fue una de las razones del porque me echo para atras **Gotify** cuando lo use la primera vez, junto con que puedes poner los iconos de cada aplicación, pues ya lo tenia todo en marcha. Solo me faltaba instalar la aplicación en el movil y tenia todas las notificaciones de mis serviciones a mi disposición y encima diferenciadas por aplicaciones (salas) para que todo estuviera más claro y facil de entender:
- Backups
  - En mi caso, las copias de seguridad las hago a traves de **restic**, otro articulo que tengo que hacer (y tambien gracias a **atareao** por dar a conocer el sistema de copias que el usa), y que junto a un *script* de **Gotify** podia estar informado de cuando y como se habian echo las copias de seguridad.
- flexGet
- unRaid
- Gestión de Podcast
- Y más cosas que quiera añadir gracias a los plugins que tiene
  - Aqui tengo que hacer un inciso, los que yo encontre son un poco 🙁 y no se les puede sacar mucho provecho.
  
El script en cuestión es el siguiente:
```bash
# SCRIPT PER ENVIAR LES NOTIFICACIONS
curl -s -S --data \ 
  '{"message": "'"${DIR_NAME}.xml"'", "title": "'"${TITLE_RSS}"'", \
  "priority":'"${GOTIFY_PRIORITY}"', "extras": {"client::display": \
  {"contentType": "text/markdown"}}}' \
  -H 'Content-Type: application/json' "$GOTIFY_SERVER"
```
Con esto, ya tengo de nuevo en marcha mi sistema de notificaciones para substituir **telegram** por algo más **libre** y asi tener **mas libertad digital** tal como dice **Lorenzo**.

Los que tengais el dashboard de **HomePage**, saber que si usar **Gotify** tienes un widget, que puedes usar y tener a la vista las *aplicaciones*, los *clientes* y los *mensajes* recibidos. En este [articulo](/2024-06-03-usando-homepage-2) teneis una imagen de como queda.

Aqui tengo que hacer un inciso, no os penseis que me he olvidado de **Matrix**, aun lo tengo en la cabeza metido molestando y riendose de mi, porque no lo he hecho funcionar correctamente, algo parecido a esto:

![](/images/cerebro.jpg "Pensando")

Pero tiene que saber, que a mi me cuesta mucho darme por vencido y que al final conseguire hacer funcionar correctamente a **Matrix**, pero ya explicare en otro articulo, como me va mi lucha contra él.
#### Referencia
- [Guía Paso a Paso: Cómo Instalar Gotify en Unraid](https://elblogdelazaro.org/gu%C3%ADa-paso-a-paso-c%C3%B3mo-instalar-gotify-en-unraid)

