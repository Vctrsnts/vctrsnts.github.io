---
layout: post
title: "Raspberry Pi. Externalizando copias de seguridad"
author: Victor
date: 2021-01-18
category: [docker,raspberry]
---

Este articulo es una continuación al que hice hace un par de dias con respecto a realizar copias de seguridad en mi RPI4 con **RSNAPSHOT**.

Esta bien hacer copias de seguridad de los ficheros más importantes del sistema, pero hay un problema, que si estas copias estan en el mismo HDD que el resto del sistema, en caso de que el HDD falle, pierdes todas las copias de seguridad que habias hecho.

Pero para esto, tenemos a **Docker** que viene en nuestra ayuda. En este caso, si tienes una cuenta de **MEGA**, la puedes utilizar, para una vez que has hecho las copias de seguridad de tu sistema con **rsnapshot**, las guardas en tu cuenta, para en caso de fallo, poder recuperar toda la información sin ningun problema.

Esto se puede hacer a traves de la imagen [MegaCmd](https://hub.docker.com/r/melsonlai/docker-megacmd) que nos provee de un sistema automatico, para que al copiar ficheros que nosotros pongamos en dicho directorio, los copia automaticamente en nuestra cuenta de **Mega**.

Lo que necesitamos primero es hacer nuestro **docker-compose** de la siguiente manera:
```
megacmd:
  image: melsonlai/docker-megacmd:arm
  container_name: megacmd
  restart: unless-stopped
  environment:
   - PUID=1000
   - PGID=1000
  volumes:
   # DIRECTORIO DONDE ESTA LA CONFIGURACIÓN DE MEGA
   - ${STORAGE}/config/megacmd:/home/d_user
   # DIRECTORIO DONDE ESTA LAS COPIAS DE SEGURIDAD DE RSNAPSHOT Y QUE QUEREMOS
   # COPIAR EN MEGA
   - ${STORAGE}/seguretat:/mnt/sync
```

Una vez tenemos nuestro fichero **docker-compose**, solamente nos queda usar nuestro comando favorito ```docker-compose up -d megacmd```

Cuando se ha finalizació la descarga de la imagen, tenemos que ejecutar el siguinete comando para entrar en el container y finalizar la configuración del sistema:
```
usuari@maquina:~$ docker exec -it megacmd su - d_user

~$ mega-login <account-email> <password>
~$ mega-sync <localpath> <dstremotepath>

# EN MI CASO, ESTA INSTRUCCIÓN SERIA LA SIGUIENTE
~$ mega-sync /mnt/sync /backup
```

Y con esta se da por finalizada la configuración de **MegaCmd** que automaticamente sincronizara el contenido del directorio ```/mnt/seguretat``` con el directorio que hayais seleccionado en vuestra cuenta de **Mega**.

**Referencia:**

* [MEGA - cmd](https://hub.docker.com/r/melsonlai/docker-megacmd)
