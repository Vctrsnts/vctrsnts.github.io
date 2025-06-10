# Crear imagenes en docker

Esto es una cosa que queria hacer desde que he empezado a utilizar `docker` porque siempre va bien tenerlos apuntado por si algun momento hace falta y si además te has hecho algun par de containers propios, pues nunca esta de más.

La parte más dificil de crear una imagen docker, es el `Dockerfile`, este fichero es todo lo que contendra y hara la imagen docker cuando se cree (sobre que base funciona, que puertos, volumenes, etc...).

<!--more-->

Un ejemplo de fichero `Dockerfile` puede ser este que utilice para crear la imagen de flexget:
```bash
FROM alpine:3.11
LABEL maintainer "wiserain"

RUN \
 echo "**** install frolvlad/alpine-python3 ****" && \
 apk add --no-cache python3 && \
 python3 -m ensurepip && \
 rm -r /usr/lib/python*/ensurepip && \
 pip3 install --no-cache --upgrade pip setuptools wheel && \
 if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip; fi && \
 echo "**** install dependencies for plugin: telegram ****" && \
 apk add --no-cache py3-cryptography && \
 pip install --upgrade PySocks && \
 pip install --upgrade python-telegram-bot && \
 echo "**** install dependencies for plugin: cfscraper ****" && \
 pip install --upgrade cloudscraper && \
 apk del --purge --no-cache build-deps && \
 echo "**** install dependencies for plugin: convert_magnet ****" && \
 apk add --no-cache boost-python3 libstdc++ && \
 echo "**** install dependencies for plugin: misc ****" && \
 pip install --upgrade \
   transmissionrpc \
   irc_bot && \
 echo "**** install dependencies for plugin: rar ****" && \
 apk add --no-cache unrar && \
 pip install --upgrade rarfile && \
 echo "**** install flexget ****" && \
 pip install --upgrade --force-reinstall flexget && \
 # add default volumes
 VOLUME /config /data
 WORKDIR /config

 # expose port for flexget webui
 EXPOSE 3539 3539/tcp

 # run init.sh to set uid, gid, permissions and to launch flexget
 RUN chmod +x /scripts/init.sh
 CMD ["/scripts/init.sh" ]
```

Como se puede ver, en este caso, la base de mi imagen es **alpine:3.11** y se basa en una imagen ya creada por wiserain. Lo que yo hice fue quitar un par de cosas que no necesitaba y añadir otras porque a la hora de funcionar me daban error.

Luego viene, todo el resto de programas que tiene que hacer para que la imagen docker funcione correctamente. En este caso, el `Dockerfile` que estoy usando, es el que se usa para crear la imagen de **flexget**.

Esta, en principio es la parte más dificil de crear una imagen docker, ahora solamente nos queda subirlo a algun almacen de imagenes docker. En este caso, yo estoy dado de alta en [docker hub](https://hub.docker.com/) es que donde muchas personas han colgado las imagenes que ellos han creado, para que el resto pueda utilizarla.

Para crear la imagen en si y luego subirla, lo primero es crear dicha imagen. Esto se hace a traves del siguiente comando (lo mejor es ejecutar esta imagen dentro del directorio donde tenemos el `Dockerfile`):
```bash
usuari@debian:~$ docker build -t usuario/nombre_imagen:version .
```

Con esto ya hemos creado la imagen, ahora tenemos que subir la imagen, pero antes tenemos que hacer login en nuestra cuenta de `dockerhub`:
```bash
usuari@debian:~$ docker login
```

Una vez ya tenemos acceso procedemos a subir la imagen :
```bash
usuari@debian:~$ docker push usuario/nombre_imagen:latest
```

Ya tenemos  nuestra imagen de docker creada y subida en dockerhub.
#### Referencia
- [Crear imagen Docker](https://www.atareao.es/tutorial/docker/crear-una-imagen-docker-desde-cero-y-paso-a-paso/)

