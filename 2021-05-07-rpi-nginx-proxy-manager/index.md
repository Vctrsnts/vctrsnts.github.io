# Usando Nginx-Proxy-Manager en la Raspberry

Aqui tenemos otra entrada más que hace referencia a mi RPI y a ese inmenso oceano que se ha abierto al descubrir Docker.

<!--more-->

Una vez que tienes tu propio **Spotify**, el siguiente paso que quieres hacer, es acceder a el desde exterior y para hacer esto tienes 2 maneras de hacerlo:

- Abrir directamente el puerto de tu *Spotify* con el riesgo que conlleva.
- Utilizar un *Proxy* para que a traves de *https*, junto a un certificado SSL para darle más seguridad, acceder a este servicio sintiendote un poco más seguro.

Entonces, para hacer esto (segunda opción), no vayamos a ponerle las cosas faciles a los **crackers**, tenemos varias opciones (voy a poner las que he usado) y todas disponibles con Docker:
* **Traefik**: Muy buena opción, pero de dificil configuración, a mi modo de ver.
* **Nginx-Proxy-Manager**: El más vistoso (incluye GUI) desde la que puedes hacerlo todo.
* **Caddy**: El más facil de usar.

Al principio use **Traefik**, es muy poderoso y tiene muchas opciones de configuración, pero por ese mismo motivo, porque tiene muchas opciones, lo hace más dificil de usar.

Después me decante por [Caddy](/2021-04-08-rpi-caddy-proxy-manager) porque todo lo tenia al alcance de la mano, con un simple fichero de texto y era una maravilla su simpleza, pero todo cambio, cuando sacaron una nueva versión de Caddy que me arruino el chiringuito o fue **duckdns** no lo tengo aun del todo claro (tendre que seguir haciendo pruebas).

A lo que me vengo a referir es que en caddy (versiones antiguas) tenia una `url` parecida a esta `https://music.midominio.duckdns.org` pero algo cambio en caddy o en duckdns que que ya no acceptaba este tipo de url, y tuve que cambiar a una de este estilo `http://music-midominio.duckdns.org` a parte que tampoco me creaba los certificados (por eso digo, que no se si era culpa de Caddy o de duckdns).

Pero no podia estar si acceso a mi **Spotify** privado y después de investigar (aunque ya habia hecho un par de pruebas para ver como funcionaba) me decante por **Nginx-Proxy-Manager**, no iba a volver a **traefik** si me fui de el por su complejidad, asi que **npm** fue mi salvación, por la ayuda que te da a la hora de toda la configuración con sus diferentes pantallas que tienes a tu disposición (tanto para crear los dominios, como para crear los certificados).

Para usarlo en Docker utilice la siguiente configuración:
```bash
npm:
 image: jc21/nginx-proxy-manager:latest
 container_name: npm
 restart: unless-stopped
 ports:
   - '80:80'
   - '81:81'
   - '443:443'
 volumes:
   - ${STORAGE}/config/npm/data:/data
   - ${STORAGE}/config/npm/letsencrypt:/etc/letsencrypt
```

Hay que tener en cuenta una cosa, en algunos sitios, te indican que tienes que tener, a parte de **npm**, tienes que tener un *gestor de BBDD*, pero yo he podido comprobar, y es como lo tengo actualmente, que no hace falta tener ningun gestor de BBDD (a lo mejor las nuevas versiones de npm ya lo tengan incorporado).

Una vez, instalado, accedemos a traves (en mi caso) del puerto 81 y con las siguintes credenciales:
```bash
Username: admin@example.com
Password: changeme
```

Cuando accedemos al sistema, lo primero que hacemos es cambiar el usuario y el password de acceso y ya lo tenemos preparado para poderlo usar.

Con los videos que hay en la **Referencia** podras configurarlo sin ningun problema.
#### Referencia
- [Certificados AUTOMÁTICOS y GRATIS para CUALQUIER SERVIDOR - Nginx Proxy Manager](https://www.youtube.com/watch?v=0n9DLj2ndo4)
- ~~[Instalar NGINX PROXY MANAGER en una RASPBERRY Pi 4](https://www.youtube.com/watch?v=J7gpQYJ8bjU)~~

