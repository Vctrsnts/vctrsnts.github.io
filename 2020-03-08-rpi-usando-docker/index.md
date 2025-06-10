# Raspberry Pi. Pasos para instalar Docker en Raspbian

Siempre me pasa lo mismo, me hago mis chuletas y apuntes, pero nunca me pongo como se realiza la instalación sobre la cual funcionan las chuletas.

<!--more-->

Por eso, ahora voy a explicar como se realiza la instalación de **Docker** en **Raspbian** (en mi caso sobre una **Raspberry pi 3b**)

{{< admonition note >}}
Actualmente tengo una RPI4B de 4Gb, pero el proceso es el mismo.
{{< /admonition >}}

A continuación explicamos el proceso de instalación de Docker:

## 1. Instalar paquetes necesarios
```bash
usuari@raspberry:~$ sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
```

## 2. Instalar firmas GPG del repo de Docker
```bash
usuari@raspberry:~$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
usuari@raspberry:~$ sudo apt-key fingerprint 0EBFCD88
```

## 3. Agregar repo de Docker
```bash
echo "deb [arch=armhf] https://download.docker.com/linux/debian \
 $(lsb_release -cs) stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list
```

## 4. Instalar Docker
```bash
usuari@raspberry:~$ sudo apt-get update && sudo apt-get install -y docker-ce docker-compose
```

## 5. Agregar usuario al grupo docker y desloguearse y volverse a loguear
```bash
usuari@raspberry:~$ sudo usermod -a -G docker tuUsuario
#(logout and login)
```
#### Referencia
- [Pasos para instalar Docker](https://gist.github.com/pablokbs/263ed38d0206de2aca7b3f106ba7a5dc)

