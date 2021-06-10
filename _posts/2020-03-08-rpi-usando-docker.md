---
layout: post
title: "Raspberry Pi. Pasos para instalar Docker en Raspbian"
author: Victor
date: 2020-03-08
category: [docker]
---

Siempre me pasa lo mismo, me hago mis chuletas y apuntes, pero nunca me pongo como se realiza la instalación sobre la cual funcionan las chuletas.

Por eso, ahora voy a explicar como se realiza la instalación de **Docker** en **Raspbian** ( en mi caso sobre una **Raspberry pi 3b** )

#### Nota: Actualmente tengo una RPI4B de 4Gb, pero el proceso es el mismo

A continuación explicamos el proceso de instalación de Docker:

- Instalar paquetes necesarios

```
usuari@maquina:~$ sudo apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
```

- Instalar firmas GPG del repo de Docker

```
usuari@maquina:~$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
usuari@maquina:~$ sudo apt-key fingerprint 0EBFCD88
```

- Agregar repo de Docker

```
echo "deb [arch=armhf] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list
```

- Instalar Docker

```
usuari@maquina:~$ sudo apt-get update && sudo apt-get install -y docker-ce docker-compose
```

- Agregar usuario al grupo docker y desloguearse y volverse a loguear

```
usuari@maquina:~$ sudo sudo usermod -a -G docker tuUsuario
#(logout and login)
```

**Referencia:**

* [Pasos para instalar Docker](https://gist.github.com/pablokbs/263ed38d0206de2aca7b3f106ba7a5dc)
