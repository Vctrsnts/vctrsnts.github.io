# Volviendo a Caddy desde Nginx Proxy Manager

Como ya sabreis, [anteriormente](/2021-05-07-rpi-nginx-proxy-manager) usaba **Nginx Proxy Manager** porque habia tenido muchos problemas con **Caddy**, no se de donde venian estos problemas, si de **Caddy** o de **duckdns.org**, asi que hice el cambio a **npm** para los amigos. 

<!--more-->

Aqui vuelvo a estar de nuevo.

Hice el cambio, pero habia una cosa que no me acababa de gustar, el tener la URL de mis servicios, no se como llamarlos, no *bonitos*, *no oficiales*?

Cuando me refiero a *URL no bonitas*, me refiero al tipo `https://music-miservidor.duckdns,.org`, como que no quedan muy legales, porque me gustan más, las de toda la vida `https://music.miservidor.duckdns.org` que son las normalizadas.

Pero todo cambio, cuando vi un nuevo [articulo](https://ugeek.github.io/blog/post/2022-12-23-caddy-crear-usuario-y-contrasena.html) de uGeek, donde comentaba, que se podian crear usuarios y passwords en `Caddy` decidi volver a probar a ver si esta vez tenia más suerte.

Asi que me puse al lio, volvi a poner la configuración recomendada de **Caddy** en mi servidor de Docker y a ver si esta vez teniamos más suerte:

Parece que si que tenemos suerte, porque de momento todo esta funcionando correctamente y encima con el certificado de [Let's Encrypt](https://letsencrypt.org/es/).

Esperemos que esta vez dure más mi aventura con **Caddy**.
#### Referencia
- [Usando Caddy](https://ugeek.github.io/blog/post/2021-02-19-proxy-inverso-con-caddy.html)
- [Usuarios en Caddy](https://ugeek.github.io/blog/post/2022-12-23-caddy-crear-usuario-y-contrasena.html)
- [Let's Encrypt](https://letsencrypt.org/es/)

