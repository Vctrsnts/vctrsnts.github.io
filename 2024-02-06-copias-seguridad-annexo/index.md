# Copias de Seguridad. Annexo

Se que ha pasado 1 mes desde la ultima vez que publique algo, pero he estado un poco liado con todo, pero ahora vuelvo al ruedo y a ver, si me pongo las pilas con el **Blog**.

Tal como se puede ver en estos 2 articulos que ya habia escrito:
- [Raspberry Pi. Haciendo copias de seguridad](/2021-01-17-rpi-copias-seguridad)
- [Raspberry Pi. Externalizando copias de seguridad](/2021-01-18-rpi-externalizando-copias-seguridad)

<!--more-->

Donde explicaba, en el primer articulo, que mediante el docker de **rsnapshot** realizaba las copia de seguridad de los ficheros más importantes de  mi servidor y, en el segundo articulo, explicaba, que a traves, tambien al docker de **megacmd** pasaba estas copias de seguridad a [Mega](https://mega.nz) para tener una doble seguridad, una copia en el servidor y otra copia fuera de el. Todo funcionaba correctamente, pero la segunda parte no era de mi agrado, porque tenia un docker muy desactualizado y que no me daba mucha confianza.

Pero todo cambio cuando escuche este [podcast](https://www.ivoox.com/google-stadia-copias-seguridad-revision-del-audios-mp3_rf_96963743_1.html) de **Desahogo Geek** donde explicaba la manera que el hacia sus copias de seguridad de sus servidores. Y me intereso, asi que me puse a ver como se podia hacer.

La manera que lo hacia **AlexPro** se basaba en 2 funcionalidades, 3 en mi caso, que son las siguientes:
- Usar **rsnapshot** que ya lo estoy utilizando y me funciona correctamente.
- Usar **rclone** para **montar** como una unidad más del sistema en el servidor del espacio que tengo en **Mega** (50Gb) que hasta ese momento, no estaba dandole mucho uso.
- Automatizar mediante un script en **bash** las copias de seguridad, que en mi caso, serian las que hago mediante **rsnapshot**.

Con respecto a las 2 primeras, **rsnapshot** no lo voy a volver a explicar, porque podeis ir al [articulo](/2021-01-17-rpi-copias-seguridad) que tengo publicado donde lo explico detalladamente, con respecto a como se tiene que configurar **rclone**, en vez de explicarlo yo aqui, que seguramente no contemplaria todas las opciones posibles, recomiendo que mireis estos [articulos](https://alexpro.sytes.net/rclone) que a escrito **AlexPro** que explica todas las opciones posibles y en el que yo me he basado para configurar mi **rclone**.

Lo que si que voy a explicar, es el script en **bash** (modificando el que habian hecho anteriormente [Diego Cordoba](https://juncotic.com/megafuse-realizando-backups-mega-linux) y que a su vez, fue modificado por [Luis Urbina](https://github.com/luisurbinanet/megafuse-backup-script) y que modifique a mis necesidades para hacer las copias de seguridad a **Mega**. El script es el siguiente:
```bash
#!/bin/bash
# Victor Santos Garcia / https://vctrsnts.github.io
# Creado Diego Cordoba, modificat per Luis Urbina
#
#
# DADES DEL SERVIDOR I NECESSARIES
SERVER="nomEquip"
# PER VISUALITZAR ELS MISSATGES (TRUE ES VISUALIZEN, FALSE NO)
DEBUG="true"
# ON ESTA EL FITXER DE CONFIGURACIÓ DE RCLONE (JO LAGAFO DEL DOCKER DE RCLONE)
RCLONE_CONFIG="/config/rclone.conf"
#
# DIES QUE MANTENIM LES COPIES
#
TMP_DIR="/tmp"
# DIES PER OBTINDRE ELS BACKUPS, AMB EL VALOR 0, SAGAFA LULTIM BACKUP
DAYS_TO_BACKUP=0
# DIES QUE ES MANTENEN ELS BACKUPS A MEGA ABANS DESBORRAR
DAYS_TO_DELETE=7
#
# TEMPS DESPERA PER A QUE FINALITZI LA COPIA ENTRE EL SERVIDOR I MEGA
# SI EL SERVIDOR ESTA A INTERNET, AMB 120 SEGONS (2 MINUTS) ES MÉS QUE SUFICIENT
#
STANDBY_SECONDS=120
#
# ESPECIFIQUEM EL DIRECTORI ON ESTAN ELS BACKUPS DE RSNAPSHOT
# I EL DIRECTORI DE MEGA
#
ORIGEN_DIR="/mnt/backup"
MEGA_DIR="/mnt/mediaefs"
#
# OBTENIM LA DATA DEL SISTEMA
DATE="$(date +%Y%m%d)"
#
# ES COMENÇA A REALITZAR EL BACKUP
#
if [ "${DEBUG}" = "true" ] 
then
    echo ""
    echo "\_ Inici del Backup a Mega"
fi
#
# BACKUP DE LES COPIES DE SEGURETAT
# EN AQUESTA CAS, SEMPRE BUSQUEM EL DAILY.0 GENERAT PER RSNAPSHOT
#
for dir in $(find ${ORIGEN_DIR} -mindepth 1 -maxdepth 1 -type d -daystart -mtime ${DAYS_TO_BACKUP})
do

    cd $(dirname ${dir})

    if [ "${DEBUG}" = "true" ]
    then
      echo ""
      echo "  \__: Iniciem la creació del fitxer comprimit"
    fi

    if [ "${DEBUG}" = "true" ]
    then
      echo "  \___: ${dir}"
    fi
    # ES CREAR EL FITXER COMPRIMIT (TAR.GZ) DE LA COPIA DE RSNAPSHOT
    tar czf ${TMP_DIR}/$(basename ${dir})_${DATE}.tar.gz $(basename ${dir})

    if [ "${DEBUG}" = "true" ]
    then
      echo "  \__: Finalització de la creació del fitxer comprimit"
    fi

    cd - > /dev/null
done
#
# ESBORROR LES COPIES DE SEGURETAT QUE TENEN MÉS DE 7 DIES DANTIGUITAT A MEGA
#
rclone --config ${RCLONE_CONFIG} delete --min-age ${DAYS_TO_DELETE}d dmega_cifrado:

if [ "${DEBUG}" = "true" ]
then
  echo ""
  echo "\_ Busquem els arxius amb més de 7 dies dantiguitat per esborrar"
fi
#
# INICEM LA COPIA DELS FITXERS DE SEGURETAT COMPRIMITS A LA UNITAT XIFRADA DE MEGA
#
if [ "${DEBUG}" = "true" ]
then
  echo ""
  echo "\_ Iniciem la copia dels fitxers de seguretat (comprimits) a DMEGA_CIFRADO"
fi
rclone --config ${RCLONE_CONFIG} move ${TMP_DIR}/* dmega_cifrado:
#
# ESPEREM UN TEMPS PERQUE ES REALITZI CORRECTAMENT LA COPIA
#
if [ "${DEBUG}" = "true" ]
then
  echo "  \_: Temps despera de $STANDBY_SECONDS segons"
fi
sleep $STANDBY_SECONDS

if [ "${DEBUG}" = "true" ]
then
  echo "\_ Es realitza neteja de fitxers i ja finalitzem"
fi
# ESBORREM EL FITXER TAR.GZ CREAT PER PUJAR A MEGA
rm -rf ${TMP_DIR}/*
# ES NETEJA LA PAPERERA DE MEGA
if [ "${DEBUG}" = "true" ]
then
  echo "\_ Es neteja la paperera de Mega"
fi
rclone --config ${RCLONE_CONFIG} cleanup dmega_cifrado:
```

Con este script, que tengo que dar las gracias a **Diego Cordoba** y a **Luis Urbina**, porque me dieron la base, para luego, yo poder hacer este script, consigo, que:
- Se localize la copia más actual realizada por **rsnapshot**, que en este caso, siempre sera `daily.0`.
- Luego, se crea un fichero comprimir en `tar.gz` con la fecha de la copia.
- Se muevo este fichero a la unidad cifrada de **Mega** donde se pierde cualquier posibilidad de saber que contiene dicho fichero.
- Borramos de la papelera de **Mega** las copias más antiguas, porque solamente conservamos las ultimas 7.

Con esto, he explicado, como en mi caso, gracias a diferentes personas, realizo yo las copias de seguridad de mi servidor local. Faltaria implementarlo en el servidor de Oracle que tengo, pero como de momento, no tengo mucha cosa en el, pues no me merece la pena.

Aunque, como ahora, tiene mi sitio web, donde pongo los libros que he ido leyendo, no se si merece la pensa ya pensar en ello. Es una cosa que estoy estudiando.
#### Referencia
- [Google Stadia, copias de seguridad y revisión del coche](https://www.ivoox.com/google-stadia-copias-seguridad-revision-del-audios-mp3_rf_96963743_1.html)
- [MegaFuse: realizando backups en MEGA desde Linux](https://juncotic.com/megafuse-realizando-backups-mega-linux)
- [megafuse-backup-script](https://github.com/luisurbinanet/megafuse-backup-script)

