---
layout: post
title: "Usando Caddy como Proxy Inverso"
author: Victor
date: 2021-05-08
category: [docker],[raspberry]
---

Cómo cuarta opción, he estado probando Caddy tras la recomendación de Germán .

Ya había visto a diferentes artículos de cómo construir tu proxy inverso con Caddy, incluso algunos docker-compose, pero no me había llamado la atención del todo hasta el comentario de Germán.

La verdad es que este servicio es alucinante. Es una fusión entre traefik, poder levantar todos tus servicios con su certificado desde un archivo de texto plano y sencillez como Nginx Proxy Manager.
Qué es Caddy

Caddy 2 es un potente servidor web de código abierto desarrollado en go.

Simplifica su infraestructura y se encarga de las renovaciones de certificados.

Funciona muy bien en contenedores porque no tiene dependencias.

Aunque la mayoría de la gente lo usa como servidor web o proxy, es una excelente opción tambien para:

    Servidor web
    proxy inverso
    proxy de sidecar
    equilibrador de carga
    Puerta de enlace API
    controlador de ingreso
    administrador de sistemas
    supervisor de proceso
    programador de tareas
    (cualquier proceso de larga duración)

Creando el docker

Caddy requiere acceso de escritura a dos ubicaciones: un directorio de datos y un directorio de configuración .

Recuerda que para generar los certificados de Let's Encrypt, Caddy necesita tener abiertos los puertos 80 y 443.

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

Cómo es multiarquitectura, podremos utilizarlo en ARM, amd64,…
Caddyfile

Creamos el archivo Caddyfile, donde irá la configuración de nuestro proxy inverso.

Voy a exponer estos 3 servicios. En el puerto 8080, tengo un servidor nginx con una web estática, 8096 para jellyfin y 4533 para navidrome.

Caddy se encargará de exponer estos servicios a la red generando el certificado con Let's Encrypt.

midominio.duckdns.org {
                        reverse_proxy http://192.168.1.100:8080
                      }


jellyfin.midominio.duckdns.org {
                                 reverse_proxy http://192.168.1.100:8096
                               }


navidrome.midominio.duckdns.org {
                                  reverse_proxy http://192.168.1.100:4533
                                }

Todo de una vez

Voy a crear de ejemplo un docker-compose con shaarli y caddy, para que me genere el certirficado de shaarli.

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

    shaarli:
      image: shaarli/shaarli
      container_name: shaarli
      restart: unless-stopped

Como veis, no he tenido que exponer los puertos de shaarli, ya que shaarli va ha  estar dentro de la misma red de Caddy y este mediante el archivo de configuración Caddyfile, Caddy se encargará de enlazar el servicio y crear el certificado.
Caddyfile

Mediante reverse_proxy  shaarli:, indicaremos a Caddy que este es el servicio que quiero utilizar como proxy inverso y que la url que quiero utilizar para acceder a este servicio, generandome también el certificado Let's Encrypt de esta dirección, sea shaarli.midominio.duckdns.org.

shaarli.midominio.duckdns.org {
                                reverse_proxy  shaarli:
                              }

Fuentes

    https://hub.docker.com/_/caddy
    https://caddyserver.com/
    https://crapts.org/2020/05/28/use-caddy-as-a-reverse-proxy-with-local-ca/
    https://github.com/Johni0702/mumble-web


Publicado por Angel el viernes 19 febrero del 2021


También te puede interesar:



**Referencia:**

* [Proxy Inverso con Caddy](https://ugeek.github.io/blog/post/2021-02-19-proxy-inverso-con-caddy.html)
