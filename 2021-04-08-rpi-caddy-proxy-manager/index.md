# Cambiando Traefik por Caddy

Anteriomente venia usando Traefik, pero como ya he comentado, era muy dificil de mantener y de configurar, a parte de las multiples opciones que tiene. Ante esto, me resultaba muy tedioso su uso, asi que decidir buscar otra alternativa más facil.

Después de buscar y leer a mis blogueros preferidos:
- [uGeek](https://ugeek.github.io)
- [El Blog de Lazaro](https://elblogdelazaro.org)

<!--more-->

Vi que los dos recomendaban:
- [Caddy](https://caddyserver.com)
- [Nginx Proxy Manager](https://nginxproxymanager.com)

Cada uso con sus ventajas e inconvenientes, aunque me tiraba más npm (para abreviar) por el gui que tenia, me decidi por caddy, porque una de sus virtudes es que podias tener url del siguiente estilo:
- `music.tudominio.duckdns.org`.

Además el poder tener todos tus servicios activos y con su correspondiente certificado solamente con un fichero de texto.

Eso es una ventaja, porque se parece más a una `URL` de verdad. Y por eso me decidi por `Caddy`, aunque al final tuve que tirar por npm, ya lo comentare en otro [articulo](/2021-05-07-rpi-nginx-proxy-manager).

## Qué es Caddy
Caddy es un potente servidor web de código abierto desarrollado en *go*. Simplifica su infraestructura y se encarga de las renovaciones de certificados.

Funciona muy bien en contenedores porque no tiene dependencias.

Aunque la mayoría de la gente lo usa como servidor web o proxy, es una excelente opción tambien para:
- Servidor web
- proxy inverso
- proxy de sidecar
- equilibrador de carga
- Puerta de enlace API
- controlador de ingreso
- administrador de sistemas
- supervisor de proceso
- programador de tareas (cualquier proceso de larga duración)

## Creando el docker
Caddy requiere acceso de escritura a dos ubicaciones: un directorio de datos y un directorio de configuración.

Recuerda que para generar los certificados de Let's Encrypt, Caddy necesita tener abiertos los puertos 80 y 443.
```yaml
version: "3.7"
services:
 caddy:
   image: caddy
   ports:
     - "80:80"
     - "443:443"
   volumes:
     - ./Caddyfile:/etc/caddy/Caddyfile:ro
     - ./data/caddy/data:/data
     - ./data/caddy/config:/config
   restart: unless-stopped
   container_name: caddy  
```
 
Creamos el archivo `Caddyfile`, donde irá la configuración de nuestro proxy inverso.

Voy a exponer mi docker de **Spotify** personal al mundo para asi a traves del movil poder escuchar la musica que tengo en el servidor, en concreto, **Navidrome** (ya explicare en otro [articulo](/2021-04-01-rpi-spotify) como tener tu propio **Spotify** en funcionamiento).

Caddy se encargará de exponer este servicio a la red generando el certificado con Let's Encrypt, que en mi caso, como ya he dicho, es mi Spotify privado y asi no tener que depender de nadie.
```yaml
music.midominio.duckdns.org {
  reverse_proxy http://192.168.1.100:4533
}
```

Asi de rapido y de sencillo tengo mi proxy inverso en funcionamiento junto con mi certificado SSL. Y lo más interesante, es que cuando llegue el momento de que el certificado vaya a caducar, el mismo caddy se encargara de actualizarlo.
#### Referencia:
- [Proxy Inverso con Caddy](https://ugeek.github.io/blog/post/2021-02-19-proxy-inverso-con-caddy.html)

