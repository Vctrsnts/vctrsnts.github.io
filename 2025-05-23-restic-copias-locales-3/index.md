# Restic + Backrest + MiniO - 3

Este sera el tercer y utlimo articulo (en principio), donde explico la manera en que se estoy realizando mis copias de seguridad. Seguramente hay metodos mejores, pero este es el que mejor se adapta a mis necesidades. Tal como dije en el anterior [articulo](/2025-05-22-restic-copias-locales-2), unicamente me faltaba realizar la configuración de las copias de seguridad a mi servidor externo (VPS), pero antes de meternos de lleno con este tema.

<!--more-->

Quiero ampliar como se realizan la configuración de las copias de seguridad, esta explicación sirve tanto para las copias de seguridad en el servidor local como en uno externo. 

Esto ha venido al caso, porque a la hora de seguir mi propia guia para realizar la configuración de las copias externas he visto que habia puntos que no habia explicado y quedaba todo un poco ambiguo.

Lo primero y antes de nada, es la instalación de **MinIO** en el *VPS*, porque como no tengo **unRAID**, pues la instalación, se tiene que hacer a traves de nuestro querido `docker-compose` que pongo a continuación:
```yaml
  minio:
    image: minio/minio:latest
    container_name: minio
    command: server /data --console-address ":9001"
    ports:
      - "9000:9000"
      - "9001:9001"
    environment:
      MINIO_ROOT_USER: ROOTNAME
      MINIO_ROOT_PASSWORD: CHANGEME123
    volumes:
      - ${HOME}/backup:/data
```

{{< admonition note >}}
Tengo que decir que esta información no esta, o yo al menos no he sabido como encontrarla en la web de **MinIO**, en teoria hay un fichero [docker-compose](https://github.com/minio/minio/tree/master/docs/orchestration/docker-compose) que nos tendria que facilitar la vida a la hora de realizar la instalación, pero que en realidad nos la complica porque añade cosas, que para la gran mayoria, como es mi caso no es necesario. Asi que gracias a otra fuente, he podido encontrar un [docker-compose](https://thanhtunguet.info/posts/install-minio-using-docker-compose) que en mi caso me ha ido muy bien tengo y que gracias a ese fichero,  ya tengo mi contenedor de **MinIO** en marcha.
{{< /admonition >}}

Tambien te añado los **labels** necesarios en caso de que tengas **traefik** para su configuración:
```yaml
 labels:
   - traefik.enable=true
   # ACCESO A LA CONSOLA WEBGUI ( 9001 )
   - traefik.http.services.minio.loadbalancer.server.port=9001
   - traefik.http.routers.minio.entrypoints=websecure
   - traefik.http.routers.minio.rule=Host(`${MINIO_CONSOLE}`)
```

Con esto ya tendriamos nuestro contenedor **MinIO** para nuestras copias de seguridad.

Pero llegado el momento de utilizarlo, me he encontrado el primer problema que no me esperaba. Cuando he accedido a la web, para la creación de las claves de acceso, no sabia donde hacerlo. Habia cambiado todo el menu. Que comienzo 😵 Segun parece han modificado algo que deshabilita esas funciones y no se como activarlas, si es que se puede. 

En **unRAID** esas modificaciones tambien se habian implementado y no tenia acceso a eliminar un **buckett** que habia creado de prueba para ver si de esta manera tenia acceso a las claves de acceso a traves de la **API**.

Que se hace en estos casos, la mejor solución, es volver a una versión anterior donde si que se tiene acceso a esas mejoras y quedarte ahi. En mi caso, estoy utilizando la versión **RELEASE.2025-04-22T22-12-26Z**, lo que hace que mi `docker-compose.yml` para **MinIO** quede de la siguiente manera:
```yaml
  minio:
    image: minio/minio:RELEASE.2025-04-22T22-12-01Z
    container_name: minio
    command: server /data --console-address ":9001"
#    ports:
#      - "9000:9000"
#      - "9001:9001"
    environment:
      MINIO_ROOT_USER: ROOTNAME
      MINIO_ROOT_PASSWORD: CHANGEME123
    volumes:
      - ${HOME}/backup:/data
    labels:
      - traefik.enable=true
      # ACCESO A LA CONSOLA WEBGUI ( 9001 )
      - traefik.http.services.minio.loadbalancer.server.port=9001
      - traefik.http.routers.minio.entrypoints=websecure
      - traefik.http.routers.minio.rule=Host(`${MINIO_CONSOLE}`)
```

El segundo problema que me encontre es que **MinIO** utiliza 2 puertos para poder ser utilizado:
- **9000**: Es el puerto de la API que se utiliza para las copias de seguridad
- **9001**: Es el puerto de acceso para la GUI.
  - Con este puerto no tenia ningun problema, porque es el que ya habia configurado con *traefik*.

Pero claro, como se implementa esto en `docker` y mas exactamente en **traefik**, aqui de nuevo tuve que tirar de IA y esta me dio la respuesta correcta. Todo consiste en tener **2 services**, uno para cada puerto quedando de la siguiente manera:
```yaml
 minio:
   image: minio/minio:RELEASE.2025-04-22T22-12-01Z
   container_name: minio
   command: server --console-address :9001 /data
   restart: unless-stopped
   networks:
     - proxy
   volumes:
     - ${HOME}/backup:/data
   environment:
     MINIO_ROOT_USER: ${MINIO_USR}
     MINIO_ROOT_PASSWORD: ${MINIO_PWD}
   labels:
     - traefik.enable=true
     # ACCESO A LA CONSOLA WEBGUI ( 9001 )
     - traefik.http.services.minio_console.loadbalancer.server.port=9001
     - traefik.http.routers.minio_console.entrypoints=websecure
     - traefik.http.routers.minio_console.rule=Host(`${MINIO_CONSOLE}`)
     - traefik.http.routers.minio_console.service=minio_console
     # ACCESO A LA API ( 9000 )
     - traefik.http.services.minio_api.loadbalancer.server.port=9000
     - traefik.http.routers.minio_api.entrypoints=websecure
     - traefik.http.routers.minio_api.rule=Host(`${MINIO_API}`)
     - traefik.http.routers.minio_api.service=minio_api
```
Como veis, tengo el *servicio* **minio_console** para acceder a la web de **MinIO** y asi poder hacer las configuraciones necesarios y otro *servicio* que es **minio_api** que es el que se usa para acceder a la **API** de **MinIO**. Seguramente tiene que haber otra manera de hacer esto, o no, pero es la que me funciona a mi. Ahora si, ya estamos en marcha. Ya tenia mis claves de acceso y mi **buckett** creado.

Como ahora iba a tener 2 servidores de copias de seguridad (local y el VPS), tenia que hacer algunas modificaciones al [script](/2025-05-22-restic-copias-locales-2) de copias de seguridad para que contemplara esta nueva funcionalidad. Tambien tiene que tener en cuenta que para cada servidor, tiene sus claves de acceso propias, lo que hace que tenga que utilizar la de cada servidor a la hora de las copias de seguridad.

Esto es lo que me ha llevado un poco más de trabajo, pero gracias a **Copilot**, las modificaciones que se tienen que añadir son las siguientes:
```bash
  # Configuració de Restic Local
  export RESTIC_PASSWORD=${RESTIC_PASSWORD}
  # DECLARACIÓ DEL ARRAY REPOS
  # declare -A REPOS

  # Configuración de repositorios
  REPOS=(
    "s3:${SERVER_MINIO_URL}/backup|${SERVER_AWS_ACCESS_KEY_ID}|${SERVER_AWS_SECRET_ACCESS_KEY}"
    "s3:${VPS_MINIO_URL}/backup|${VPS_AWS_ACCESS_KEY_ID}|${VPS_AWS_SECRET_ACCESS_KEY}"
  )
```
{{< admonition note >}}
He tenido que hacer una correción al script, porque tenia `declare -A REPOS` y lo que hace es indicar que el primer elemento es la clave del array y el segundo element es el valor, por eso solamente me estaba haciendo las copias de seguridad externas (VPS) y no las hacia en mi servidor local.
{{< /admonition >}}

Aqui indicamos en el array `REPOS` las dos *URL* de los servidores con **MinIO** junto con las claves **AWS_ACCESS_KEY_ID** y **AWS_SECRET_ACCESS_KEY** separado por **|**, para que esta información, se cargue directamente cada vez que acceda a un servidor para enviar las copias de seguridad.

La otra modificación que se tiene que hacer es en los **for** donde realizara la tarea de *crear las copias*, *verificar*, *eliminar* las antiguas en cada servidor y esto se hace a traves de:
```bash
  for entry in "${REPOS[@]}"; do
      IFS='|' read -r REPO AWS_KEY AWS_SECRET <<< "$entry"
      export AWS_ACCESS_KEY_ID="$AWS_KEY"
      export AWS_SECRET_ACCESS_KEY="$AWS_SECRET"
```
Lo que hace, es *cargar* en las variables **AWS_ACCESS_KEY** y **AWS_SECRET_ACCESS_KEY** los parametros que le hemos enviado anteriormente y con esto tenemos acceso a los servidores, tanto local como externo.

Tambien hay que tener en cuenta, que el fichero `backup.env`, que es donde almacenamos toda la informacion necesaria para las copias de seguridad se tiene que modificar un poco, para añadir las nuevas claves, quedando de la siguiente manera:
```bash
# MinIO - VPS externo
VPS_AWS_ACCESS_KEY_ID="ACCESS_KEY_ID"
VPS_AWS_SECRET_ACCESS_KEY="SECRET_ACCESS_KEY"
VPS_MINIO_URL="https://servidor.minio.org"
```
Cuando ya estaba todo preparado y me disponia a realizar las pruebas de todo el sistema de copias, me empezo a dar errores con respecto a que el *password* de restic no era el correcto. No entendia que me estaba diciendo, hasta que me di cuenta, que a la hora de crear el repositorio en **backrest** habia utilizado otro password y por eso el error. Lo unico que tenia que hacer, era volver a crear un nuevo repositorio con el password correcto *perdon, fallo mio*. 

Una vez ya solucionado este problema, ahora si que todo funcionaba correctamente. Lo unico que me quedaba era la automatización del sistema de copias.

Aqui segui el consejo de [Atareao](https://atareao.es/podcast/no-pierdas-tus-datos-backups-infalibles) donde explica, que en su caso, igual que el mio, su equipo personal, no esta encendido las 24 horas y por ese motivo no se puede hacer una planificación de las copias, pero lo que si se puede hacer, y es lo que yo tambien he hecho, ha sido, que cada vez que se inicie el sistema y pasados 5 minutos, para asi dar tiempo a que la red este activa (es lo que pasa en un portatil si utilizas **network-manager**, que necesita unos minutos a conectarse). Entonces, pasados esos minutos, se ejecuta el script de copias de seguridad, pero activado por **systemd**.

La primera versión que hice, fue que el activador de **systemd** estuviera en el sistema, estilo general, en cambio, gracias a un [articulo](https://elblogdelazaro.org/restic-automatiza-tus-backups-con-restic-y-systemd) de **Carlos M.** vi que se podia tener lo mismo, pero a nivel de usuario (mucho más facil de implementar y de controlar), siguiendo estos simples pasos:

Lo primero, era crear la configuración del *backup* con *systemd* para usuarios, pero en **Debian GNULinux** y esto se consigue de la siguiente manera:

#### 1. Estructura de archivos
Ubicación de los archivos configurados:
```bash
    ~/.config/systemd/user/backup.timer → Timer para ejecutar el backup 5 min después del arranque.

    ~/.config/systemd/user/backup.service → Servicio que ejecuta el script de backup.

    ~/.local/bin/backupRestic.sh → Script de backup con Restic.

    ~/.local/bin/backup.env → Variables de entorno necesarias para el backup.
```
#### 2. Configuración del Timer (`~/.config/systemd/user/backup.timer`)
```ini
[Unit]
Description=Ejecuta backupRestic.sh después de cada arranque

[Timer]
OnBootSec=5m
Unit=backup.service

[Install]
WantedBy=timers.target
```

#### 3. Configuración del Servicio (`~/.config/systemd/user/backup.service`)
```ini
[Unit]
Description=Restic Backup
After=network.target

[Service]
Type=oneshot
EnvironmentFile=%h/.local/bin/backup.env
ExecStart=/bin/bash %h/.local/bin/backupRestic.sh
```

#### 4. Desactivación de posibles servicios y timers activos anteriormente
```console
systemctl --user stop backup.timer
systemctl --user disable backup.timer
systemctl --user disable backup.service
```

#### 5. Borrar antiguos archivos creados con anterioridad
```console
rm ~/.config/systemd/user/backup.service
rm ~/.config/systemd/user/backup.timer
```
#### 6. Activación timer
```console
systemctl --user daemon-reload
systemctl --user enable --now backup.timer
systemctl --user list-timers --all | grep backup
```

#### 7. Verificación de la ejecución
```console
systemctl --user status backup.timer
journalctl --user -u backup.timer --no-pager | tail -20
restic snapshots
```

#### 8. Solución de problemas
En caso de que a la hora de realizar las copias de seguridad, **systemd** este dando un error, lo podemos visualizar con la siguiente instrucción:
```console
systemctl --user restart backup.timer
journalctl --user -u backup.timer --no-pager | tail -20
systemctl --user daemon-reload
```

#### 9. Notas finales
- `backup.timer` ejecutará `backup.service` automáticamente 5 minutos después de cada inicio del sistema.
- `backup.service` se ejecuta como `oneshot`, por lo que solo corre una vez y luego se detiene (eso es lo que dice la teoria).
- Para verificar la ejecución, revisa los logs o consulta los snapshots de `backrest`.

Con esto ya tengo implementado mi sistema de copias de seguridad. Pero aun asi, quiero añadir una capa más de seguridad que es, aprovechando que tengo [Mega](https://mega.io), me gustaria enviarlas aqui, para tener una copia fuera, lo podemos llamar asi, de mi control, eso si, con la información encriptada, por si pasa algo tanto con el servidor local como con el VPS y que la pueda recuperar llegado el momento.

{{< admonition warning >}}
Con respecto a la modificación del menu por parte de **MinIO**, parece ser que ha sido una [decisión](https://www.reddit.com/r/minio/comments/1kuzugc/administrator_panel_missing_on_docker_desktop) de solamente dar soporte de seguridad a la versión *comunity*, por eso y gracias al canal de **atareao**, he descubierto esta [aplicación](https://kopia.io/docs/reference/command-line/common/repository-connect-s3), que tendre que investigar quien no dice que use esta para substituir a **MinIO**.
El tiempo lo dira.
{{< /admonition >}}
#### Referencia
- [El Blog de Lázaro - Restic](https://elblogdelazaro.org/tags/restic)
- [677 - No pierdas tus datos. Backups infalibles](https://atareao.es/podcast/no-pierdas-tus-datos-backups-infalibles)
- [680 - Backups en Android con Restic](https://atareao.es/podcast/backups-en-android-con-restic)
- [Como hacer copias de seguridad cifradas con Restic de forma automática](https://geekland.eu/copias-de-seguridad-con-restic-de-forma-automatica)
- [Setting Up MinIO with Docker Compose](https://thanhtunguet.info/posts/install-minio-using-docker-compose)
- [KOPIA](https://kopia.io/docs/reference/command-line/common/repository-connect-s3)
- [Administrator panel missing on docker desktop](https://www.reddit.com/r/minio/comments/1kuzugc/administrator_panel_missing_on_docker_desktop)

