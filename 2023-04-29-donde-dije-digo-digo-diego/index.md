# Donde digo dije, digo Diego

Mucha gente pensara que me he vuelto loco al poner este titulo a este articulo y más siendo un blog de tecnologia, pero cuando llegueis al final lo entendereis.

<!--more-->

Todo empieza, si leeis este [articulo](/2023-02-19-actualizacion-watchtower) donde comentaba que habia estaba hacienddo pruebas de funcionalidad con **watchtower** para mantener actualizado mis docker sin mi supervisión y que solo me avisara cuando se hubiera actualizado uno.

También comentaba como que resultada un poco lioso su configuración (fichero docker) y que volvia a **diun** para luego volver a **watchtower** para quedarme en el.

Pues ahora resulta, por eso el titulo de este articulo, donde dije **watchtower** ahora digo **diun**. Y el motivo es muy simple.

Tan simple que fue, porque después una actualización, algunos de los `dockers/containers` que uso dejaron de funcionar. Los contenedores tenian errores, que como se actualizaron sin mi supervisión, dejaron de funcionar. Y menos mal que lo descubri pronto, porque sino, no se lo que hubiera pasado. Se que estoy exagerando un poco, mi servidor no es la NASA, pero bueno, es mi servidor.

Eso que ya estaba prevenido con ello, porque todos los articulos que lei sobre **watchtower** te avisan que hay que tener un control sobre las actualizaciones, porque pueden ocasionar un desastre y sino estas atento no te daras cuenta hasta que sea muy tarde.

Descubri que la ultima actualización no habia ido correctamente, porque normalmente recibo mensajes de las acciones que hace el docker y ese dia no recibi ninguna alerta a traves de Telegram, y aqui es donde me puse a investigar, para descubrir porque no estaba recibiendo las alertas y todo era culpa de que el container no estaba funcionando correctamente, este tenia un error que hacia que se reiniciase todo el rato con todo lo que ello provoca. Y ya me veis anulando la actualización y volviendo a la versión anterior.

Después de esta mala experiencia, aunque ya la sabia, porque el podcaster **Atareao** la habia comentado en su articulo donde el explicaba que estaba usando **watchtower**, pero yo pensaba, iluso de mi, que para los dockers tan simples que uso, no tendria que pasar nada. Pues no veas si no paso. 

Me puse a buscar a ver que decia la gente cual era la mejor opción para substituir a **watchtower**. Muchos decian que el mejor era **diun** y si además, los creadores de muchas de las imagenes de docker que uso son **linuxservers** te aconsejan no usar **watchtower** sino que usar **diun**, pues me fui a por ello.

La instalación es muy simple, como siempre en docker:
```yaml
diun:
  image: crazymax/diun:latest
  container_name: diun
  restart: unless-stopped
  hostname: nomDelTeuServidor
  volumes:
    - ${STORAGE}/config/diun:/data
    # FITXER ON ESTA LA CONFIGURACIÓ AMB TELEGRAM
    # I ELS MISSATGES D'ALERTA QUE ENVIA QUANT TE DOCKER PER ACTUALIZAR
    - ${STORAGE}/config/diun/diun.yml:/diun.yml:ro
    - /var/run/docker.sock:/var/run/docker.sock:ro
  environment:
    - "TZ=Europe/Madrid"
    - "LOG_LEVEL=info"
    - "LOG_JSON=false"
```

El problema viene luego en la configuración de las alertas, que en mi caso las recibo a traves de **Telegram** aunque tienes más opciones donde recibirlas, no es complicado si sigues el manual que tienen para ello, tienes que configurar las alertas que vas a recibir (que esta todo en un fichero **yaml**):
```yaml
# LA BBDD DE DIUN
db:
  path: diun.db
# EL CRON DE DIUN
watch:
  workers: 20
#    schedule: "*/1 * * * *"
  schedule: "@weekly"
  firstCheckNotif: true
# QUE QUIN SERVIDOR (ES POT DIR AIXI) OBTING ELS DOCKERS
providers:
  docker:
    watchByDefault: false
    watchStopped: true
# CONFIGURACIO DE TELEGRAM
# I DEL MISSATGE QUE S'ENVIA
notif:
  telegram:
    token: TOKEN_TELEGRAM
    chatIDs:
      - ID_DEL_CHAT_DE_TELEGRAM
    templateBody: |
      # AQUI TEORICAMENT HAURIA D'ENVIAR EL LOGO DE DIUN, PERO NO HO FA
      [Image]({{ _Meta_Logo }})
      # AQUI ES ON TINC EL PROBLEMA I DE MOMENT NO HO POSSO PERQUE NO PORTI A PROBLEMES
```
Con esto, solamente te falta hacer un:
```bash
usuari@debian:~# docker-compose up -d diun
```

Ya lo tenemos todo funcionando. 

Esto no es del todo cierto, porque aun falta por indicar/señalar que contenedores quieres que **diun** controle/vigile por si ha habido actualización y esto se hace añadiendo el siguiente codigo en tu `docker-compose.yml`.
```yaml
labels:
  - diun.enable=true
```

Aunque en mi caso, no es asi. Ahora mismo lo tengo a un 80% de funcionamiento, porque segun el manual, por lo que yo he podido entender, puedes enviar imagenes, para que las alertas sean más amigables y te indiquen de que container es.

Pero parece ser que esto no funciona del todo correctamente, aunque se que es posible enviar imagenes a Telegram, porque en las notificaciones que tengo en [flexget](/2021-05-30-flexget-podcast) lo tengo puesto y las recibo sin ningun problema, pero en cambio con **diun** no funciona. Tendre que seguir investigando el motivo por el que no funciona.
#### Referencia
- [Como actualizar imagenes docker automaticamente](https://atareao.es/podcast/como-actualizar-imagenes-docker-automaticamente)

