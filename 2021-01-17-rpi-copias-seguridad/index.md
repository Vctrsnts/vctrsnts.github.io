# Raspberry Pi. Haciendo copias de seguridad

Otro capitulo más con respecto a la configuración de de mi RPI4, en este caso son las copias de seguridad de la información más importante.

<!--more-->

Tal como he dicho en otros articulos, desde que conoci Docker, se abrio un nuevo mundo y para esto, no iba a ser menos.

Para realizar las copias de seguridad queria usar esta imagen [rsnapshot](https://hub.docker.com/r/pablokbs/rsnapshot-cron/tags?page=1&ordering=last_updated), hecha por PeladoNerd, pero no funciona. No esta compilada para ARM, le di un toque por octubre, pero supongo que por trabajo, no ha podido solucionar el problema, asi que tuve que buscarme otras opciones. Y como no, salio al rescate [linuxserver](https://hub.docker.com/r/linuxserver/rsnapshot).

Lo bueno que tiene **rsnapshot** es que solamente te copia los ficheros que se modifican. Al principio, si que hace una copia de todo, porque no tiene nada con que comprarar, pero a partir de ese momento, solo hace las copias de los ficheros que se modifican.

Asi, que nos pusimos a ello. Lo primero fue decidir que información es la importante, luego como la vamos a estructurar (donde estara el directorio). En mi caso, la cosa quedo de la siguiente manera:
```bash
### DIRECTORIO DONDE SE ALMACENAN LAS COPIAS DE SEGURIDAD
/mnt/seguretat

### DIRECTORIOS DE LOS QUE QUIERO COPIAS DE SEGURIDAD
# el directorio de mi usuario (junto con el docker-compose de docker)
/home
# el directorio donde estan las configuraciones del servidor que son importantes
/etc
# el directorio donde tengo las configuraciones de las imagenes de docker
/mnt/config
```

Una vez ya tenemos decido la información a salvaguardar, pasamos a la creación del **docker-compose**:
```bash
rsnapshot:
  image: ghcr.io/linuxserver/rsnapshot
   container_name: rsnapshot
   restart: unless-stopped
   volumes:
    - /mnt/config/rsnapshot:/config
    - /mnt/seguretat:/snapshots
    - /etc:/data/etc
    - /home/pi:/data/home/pi
    - /mnt/config:/data/config
   environment:
    - PUID=1000
    - PGID=1000
    - TZ=Europe/Madrid
```
  
Después de crear el docker, solamente nos quedar ejecutar la magica instruccion que nos lo pondra en marcha todo:
```bash
usuari@raspberry:~$ docker-compose up -d rsnapshot
```

Ahora nos queda la ultima parte, que es configurar los ficheros de configuración de rsnapshot. En mi caso lo hago dentro del mismo docker. Es posible que se pudiera hacer a traves de los ficheros de configuración que estan en el host del docker, pero prefiero acceder para hacer la configuración. Que en mi caso estan en `/mnt/config/rsnapshot` y a configuración la tengo de la siguiente manera:
```bash
usuari@raspberry:~$ cd dockerCompose
usuari@raspberry:~/dockerCompose $ docker-compose exec rsnapshot sh

### EDITO LOS FICHEROS RSNAPSHOT.CONF DE LA SIGUIENTE MANERA
# DIRECTORIO QUE CONTIENE LAS COPIAS (QUE LO HABRAS CONFIGURADO EN EL
# DOCKER-COMPOSE)
rsnapshpot_root   /snapshots

### SON LOS INTERVALOS QUE SE SALVAN
# SE MANTIENEN 7 COPIAS DIARIAS
retain    daily   7
# SE MANTIENEN 4 COPIAS SEMANALES
retain    weekly  4
# SE MANTIENEN 3 COPIAS MENSUALES
retain    monthly 3

# FICHERO DE LOGS  
logfile   /config/rsnapshot.log
# DIRECTORIO A COPIAR - EN MI CASO, DENTRO DE DATA, TENGO LOS DIRECTORIOS
# A SALVAGUARDAR
backup    /data/    localhost/
```

El siguiente fichero que hay que configurar, es el de cron (propio de rsnapshot), que se encarga de ejecutar las copias:
```bash
# AUN SIGO DENTRO DEL CONTAINER
cd crontabs
vi root
```

Ahora modificamos el archivo:
```bash
# AHORA PASAMOS A LA EDICIÓN DEL FICHERO
# min   hour    day   month   weekday   command
# SE EJECUTA CADA DIA A LAS 2 DE LA MAÑANA
0       2       *     *       *         rsnapshot daily
# SE EJECUTA CADA LUNES (WEEKDAY - 1) A LAS 4 DE LA MAÑANA
0       4       *     *       1         rsnapshot weekly
# SE EJECUTA CADA DIA 1 DE CADA MES A LAS 6 DE LA MAÑANA
0       6       1     *       *         rsnapshot monthly
```

Con esto, ya tenemos configurado **rsnapshot**, ahora solamente hay que dejarlo que funcione y listo.
#### Referencia
- [Backups faciles con Docker! - V2M / Rsnapshot](https://www.youtube.com/watch?v=gxJqpBsPseM)
- [PabloKbs - Rsnapshot](https://hub.docker.com/r/pablokbs/rsnapshot-cron/tags?page=1&ordering=last_updated)
- [LinuxServer - Rsnapshot](https://hub.docker.com/r/linuxserver/rsnapshot)

