# Descargar Podcast a traves de Flexgetx - Annexo

Como habia explicado en este [articulo](/2020-12-14-crear-imagen-docker) o en este otro [articulo](/2021-05-30-flexget-podcast), explicaba como crear una imagen de `docker` o como usar dicha imagen, **flexget**, para descargar podcast a traves de los `RSS` que puedes conseguir.

<!--more-->

Pero me di cuenta, que usar tus propias imagenes de docker, o estan muy bien echas y con cada nueva versión de la original, actualizas la tuya, o puedes acabar teniendo problemas, que era lo que me pasaba, decidi que era mejor usar la versión base del creador, en este caso de `flexget`, para asi evitarme futuros problemas y tener siempre, que me interese, la ultima versión de container.

Además, como desde las ultimas versiones, se le puede añadir un directorio `custom-cont-init.d` donde, en el caso que tu quieres, creas un fichero bash con el nombre `entrypoint.sh` con, en mi caso, las siguientes instrucciones:
```bash
#!/usr/bin/with-contenv bash
apk add -q --no-cache eye3d mediainfo ffmpeg wget
```
Para que una vez se cree y se ejecute por primera vez, se hara uso de este script para instalar, cada vez que lo crees de nuevo, las aplicaciones que tu quieras. En mi caso, son para el tratamiento de los podcasts que descargo. Y asi, me ahorro el tener que acordame de si esta instalado o no, cada nueva vez que creo dicho container, porque se hace automaticamente.

Es una gran mejora, que uso en varios de los containers, donde tengo aplicaciones que uso, pero que no estan dentro del propio container de origen.

Se que podria hacer una imagen especial para mi, pero entonces volveria a tener los mismo problemas que os estaba explicando al principio.

Para mi, no merece la pena todo el trabajo y stress que me supondria.
#### Referencia

