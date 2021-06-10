---
layout: post
title: "TIP Sobre Docker"
author: Victor
date: 2020-02-16
category: [docker]
---

Últimamente me he metido en el mundo de **Docker** para mi **Raspberry** y se me ha abierto un mundo nuevo de posibilidades infinitas.

A continuación pongo un TIP sobre Docker y el mantenimiento ( eliminación ) de volúmenes / imágenes que ya no se utilizan.

# ELIMINAR TODO LO NO USADO

En el caso de que lleguemos al punto de tener nuestro sistema hecho un desastre, hay un comando en **Docker** que sirve para limpiar imágenes, contenedores, volúmenes y dispositivos de red, que no estén asociadas a ningún contenedor.

```
usuari@maquina:~>docker system prune
```

Si le añadimos el `flag -a` al final, borraremos también:

- Todos los contenedores parados
- Todas las imágenes que no se estén usando en ese momento.

```
usuari@maquina:~>docker system prune -a
```

## BORRAR IMÁGENES DE DOCKER

# Borrar Imágenes

Para ver las imágenes que tenemos en el sistema, podemos usar el comando: `docker images -a`

Gracias al `flag -a` veremos todas las imágenes de Docker ( incluidas las imágenes intermedias ).

Una vez localizada la imagen que queremos borrar, utilizaremos su `ID` para borrarla:

```
usuari@maquina:~>docker rmi
```

# Borrar imágenes "colgadas" ( dangling images )

Las imágenes colgadas son las capas de imágenes que no se están utilizando en ningún contenedor, tanto que estén en funcionamiento como que estén parados. Estas imágenes pueden ser borradas en la gran mayoría de las veces. Podemos ver estas imágenes con el comando:

```
usuari@maquina:~>docker images -f dangling=true
```

Y para borrarlas:

```
usuari@maquina:~>docker images purge
```

# Borrar todas las imágenes

Si queremos borrar todas las imágenes, podemos ejecutar:

```
usuari@maquina:~>docker rmi $(docker images -a -q)
```

## BORRAR CONTENEDORES DOCKER

# Borrar Contenedores
Primero debemos localizar los contenedores que queremos borrar, para ello ejecutaremos el comando:

```
usuari@maquina:~>docker ps -a
```

Y para borrarlos:

```
usuari@maquina:~>docker rm
```

Si no quieres que un contenedor se quede ahí una vez parado, puedes lanzar el proceso con el `flag -rm`:

```
usuari@maquina:~>docker run -rm
```

# Borrar contenedores mediante filtros

Podemos usar filtros para seleccionar contenedores, por ejemplo:

```
usuari@maquina:~>docker ps -a -s status=exited -f status=created
```

Y combinándolos con los comandos anteriores, sirve para borrarlos:

```
usuari@maquina:~>docker rm $(docker ps -a -f status=exited -f status=created -q)
```

# Parar y borrar todos los contenedores Docker

También podemos parar y borrar todos los contenedores con un solo comando:

```
usuari@maquina:~>docker rm $(docker ps -a -q)
```

## BORRANDO VOLÚMENES DE DOCKER

# Borrar volúmenes

Para ver los volúmenes que tenemos en el sistema, podemos usar el comando:

```
usuari@maquina:~>docker volume ls
```

Cuando localizamos el volumen, lo podemos borrar con:

```
usuari@maquina:~>docker volume rm
```

# Borrar volúmenes colgados ( dangling volume )

Los volumenes colgados son aquellos que no estan conectados a ningun contenedor. Ten en cuenta que es posible que haya volumenes en ese estado que no tengas que ser borrados. Para verlos utilizaremos:

```
usuari@maquina:~>docker volume ls -f dangling=true
```

Localizaremos los que queremos borrar y lo haremos con el mismo comando del punto anterior:

```
usuari@maquina:~>docker volume rm
```

Si queremos borrar todos los dangling volumes, ejecutaremos:

```
usuari@maquina:~>docker volume prune
```

**Referencia:**

* [Como borrar containers, imagenes, etc...](https://www.vidaxp.com/tecnologia/como-borrar-imagenes-contenedores-y-volumenes-docker)
