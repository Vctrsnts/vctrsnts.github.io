# Cambiando watchtower por diun y vuelta a watchtower

Tal como habia indicado en este [post](/2023-01-25-usando-watchtower), explica como empece usar **watchtower** pero con resultados muy extraños.

<!--more-->

En principio, parecia que funciona la primera después de indicarle que trabajara en el **modo bridge** con respecto a la red, o lo que es lo mismo, que se conecte a la red donde estan el resto de contenedores.

Pero después de esa primera vez, no habia vuelto a funcionar de ninguna manera.

Me puse a investigar a ver que era lo que estaba pasando, porque si revisaba el `log` de watchtower veia todo el rato que *escaneados=0; actualizados=0; fallos=0* o sea, que no encontraba ningún contenedor y eso que estaba en la misma red.

Pregunte en el canal de **atareao.es** a ver si me podian dar alguna pista, pero no sabian de donde podia venir el problema.

Al final, cansado, desisti de usarlo porque no conseguia mi proposito y estaba gastando recursos del servidor inutilmente.

Asi mismo, vi, que en [docker-hub](https://hub.docker.com) te aconsejaban que mejor que **watchtower** era usar **diun**. Y me puse con ello.

Después de la configuración y lanzamiento parecia que me encontraba los contenedores y que buscaba (hay que matizar, que **diun** solamente te informa de los contenedores que tendrias que actualizar, no actualiza).

Todo parecia que iba bien, y lo unico que me faltaba era la parte de la notificación. Lo configure a traves de **telegram**, pero sin ningun resultado. Y eso que habia encontrado sitios donde te indicaban como hacerlo.

En todos los sitios, te aconsejaban que lo mejor, era tener un fichero dentro del directorio de configuración de **diun** con todas las opciones importates incluido el *token* y el *chat_id* de tu canal de telegram. Pero en mi caso, sin ningún resultado.

Ya no sabia que hacer, **watchtower** que no me funciona y ahora **diun** tampoco. O soy yo que tengo un problema o mi servidor tiene el problema. Y vuelta a empezar.

Hasta que he encontrado una pagina [web](https://www.marcodaleo.com/posts/watchtower-telegram) con una configuración de **watchtower** que tenia buena pinta y la probe. Que podia salir mal:
```yaml
watchtower:
  image: containrrr/watchtower
  hostname: SERVER_NAME
  container_name: watchtower
  restart: unless-stopped
  volumes:
    - '/var/run/docker.sock:/var/run/docker.sock'
  environment:
    - TZ=Europe/Andorra
    - WATCHTOWER_LIFECYCLE_HOOKS=True
    - WATCHTOWER_NOTIFICATIONS=shoutrrr
    - WATCHTOWER_NOTIFICATION_URL=telegram://BOT_TOKEN@telegram/?channels=CHAT_ID
    - WATCHTOWER_DEBUG=true
    - WATCHTOWER_CLEANUP=true
    - WATCHTOWER_SCHEDULE=@daily
```

Entonces me he llevado una sorpresa, porque todo empezo a funcionar correctamente. Me actualizo todos los contenedores que tenian el *label* de **watchtower** activado.

Volvemos a estar como en el principio, parece que todo funciona correctamente, pero esta vez, tiene mejor pinta.

Como siempre, seguiremos investigando a ver si esta vez es la definitiva.
#### Referencia
- [Watchtower and Telegram notifications](https://www.marcodaleo.com/posts/watchtower-telegram)
- [Get Docker Images and Containers Updates Notifications](https://razinj.dev/docker-images-and-containers-update-notifications)

