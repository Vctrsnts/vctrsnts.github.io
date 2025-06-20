# Restic + Backrest + MiniO - 2

Continuamos con esta segunda parte donde explicaremos como sacar provecho de estas 3 aplicaciones, en este caso, explicare el script que estoy usando para realizar las copia, que es una variación de uno que tiene **Lorenzo** en su [gitHub](https://github.com/atareao/dotfiles/blob/main/.local/bin/backup.sh.jinja), pero que en mi caso, en vez de ser un fichero **jinja**, es un fichero en bash a pelo.

<!--more-->

{{< admonition question >}}
No entiendo el sentido que tiene de utilizar los ficheros **jinja**. Se que es una plantilla para la creación de un fichero al vuelo, pero como utilizarlos, es lo que se me escapa. Ya le preguntaremos a **Lorenzo** su función o a ver si tiene algun *podcast* donde lo explique.
{{< /admonition >}}

Aqui teneis el *script* que estoy usando ahora mismo (versionado del original de **atareao**) pero para mis necesidades.

{{< admonition note >}}
Esta primera parte, es la función del `script` el cual se encarga de enviar las notificaciones, ahora si, a mi servidor de **Matrix**.
{{< /admonition >}}

```bash
# Funció per a notificar les accions del script
enviarNotificacions(){
    local repository="$1"
    local action="$2"
    local data="$3"

    local result=""
    local formatted_message="<strong>📢 Resumen de respaldo:</strong><br>"
    formatted_message+="<strong>🗂 Repositorio:</strong> ${repository}<br>"
    formatted_message+="<strong>⚡ Acción:</strong> ${action}<br>"
    formatted_message+="<strong>📦 Archivos procesados:</strong><br><pre>"

    while read -r line; do
        [[ -n "$line" ]] && result+="${line}<br />"
    done < <(echo "$data")

    formatted_message+="${result}</pre>"

    # Tria el final de cada missatge segons l'acció que s'ha dut a terme
    case "$action" in
        create) formatted_message+="<strong>💾 End backup at ${repository}</strong>" ;;
        check) formatted_message+="<strong>🔍 End check at ${repository}</strong>" ;;
        prune) formatted_message+="<strong>🗑️ End prune at ${repository}</strong>" ;;
        snapshots) formatted_message+="<strong>📸 End snapshots at ${repository}</strong>" ;;
    esac

    # Escapar caracters especials adequadament
    formatted_message=$(echo "$formatted_message" | sed -E 's/"/\\"/g')

    # Construcció manual del JSON verificant que tot estigui en una sola linia
    json_payload=$(printf '{"msgtype":"m.text","format":"org.matrix.custom.html","formatted_body":"%s"}' "$formatted_message")

    # Enviem la notificació fent servir CURL
    curl -X PUT \
        -H "Authorization: Bearer ${MATRIX_TOKEN}" \
        -H "Content-Type: application/json" \
        -d "$json_payload" \
        "${MATRIX_SERVER}/_matrix/client/v3/rooms/${MATRIX_ROOM}/send/m.room.message/$(date '+%s%3N')"
}
```
{{< admonition tip >}}
Esta segunda parte del `script`, es la que si se encarga de llevar a cabo las copias de seguridad en mi equipo local.
{{< /admonition >}}

```bash
#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Carrega les variables d'entorn que estan en el fitxer backup.env
# En cas d'error donar un missatge
ENV_FILE="$HOME/.local/bin/backup.env"

if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
else
    echo "Error: No se encuentra el archivo $ENV_FILE"
    exit 1
fi

# Amb els valors del fitxer backup.env, les pasem a variables per fer-les servir més endavant
# Configuración de Restic
export RESTIC_PASSWORD=${RESTIC_PASSWORD}
export AWS_ACCESS_KEY_ID=${SERVER_AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${SERVER_AWS_SECRET_ACCESS_KEY}

# Aqui tenim les ubicacions dels repositoris
# Com veus tinc la del servidor local
# I més endavant anira la del VPS
# Configuración de repositorios
REPOS=(
     "s3:${SERVER_MINIO_URL}/minio_repositori"
)

# Directoris dels que volem copies de seguretat
DIRECTORIOS=(
    "/home/user/.config"
    "/home/user/.fonts"
    "/home/user/.icons"
    "/home/user/.local/bin"
    "/home/user/.ssh"
    "/home/user/.themes"
    "/home/user/.signature"
    "/home/user/.bashrc"
    "/home/user/Mail"
    "/home/user/Projects"
    "/home/user/Varios/Novela"
)

# Aqui informem de els fitxers amb les extensions excloses
EXCLUSIONES=(
    "--exclude=*.tmp"
    "--exclude=*.mkv"
    "--exclude=*.mp4"
    "--exclude=*.mp3"
    "--exclude=*.avi"
    "--exclude=*.log"
    "--exclude=*.AppImage"
)
#
# Ara si que ve la festa
#

# Es realitzar les copies de seguretat a cada repositori
# Una vegada finalitzat, s'enviar notificació
for REPO in "${REPOS[@]}"; do
    create_output=$(restic -r "$REPO" backup \
                    --tag ${TAG_1} \
                    --tag ${TAG_2} \
                    --host ${HOST} \
                    --verbose \
                    --skip-if-unchanged \
                    "${DIRECTORIOS[@]}" \
                    "${EXCLUSIONES[@]}")
    ok=$?
    enviarNotificacions "$REPO" "create" "$create_output" "$ok"
done

# Es realitzar una verifició de la copia de seguretat
# També, una vegada finalitzat el procediment, s'envia una notificació
for REPO in "${REPOS[@]}"; do
    check_output=$(restic -r "$REPO" check)
    ok=$?
    enviarNotificacions "$REPO" "check" "$check_output" "$ok"
done

# S'esborren les copies de seguretat que sobrepassen el limit que em informt
# En aquest cas es el següent:
#  7 diaries
#  4 setmanals
#  6 mensuals
# També s'envia una notificació a la finalització del procediment
for REPO in "${REPOS[@]}"; do
    prune_output=$(restic -r "$REPO" forget \
                    --prune \
                    --keep-daily 7 \
                    --keep-weekly 4 \
                    --keep-monthly 6)
    ok=$?
    enviarNotificacions "$REPO" "prune" "$prune_output" "$ok"
done

# S'obte un llistat de les copies que tenim en cada repositori
# També s'envia una notificació a la finalització del procediment
for REPO in "${REPOS[@]}"; do
    snapshots_output=$(restic -r "$REPO" snapshots -c)
    ok=$?
    enviarNotificacions "$REPO" "snapshots" "$snapshots_output" "$ok"
done
```

Una de las partes más importantes del proceso para hacer las copias de seguridad ya lo tenemos en marcha, el `script` que realiza las copias de seguridad y las envia a nuestro servidor (**S3**) de copias de seguridad. Recordad que en nuestro caso, el servidor que tenemos instalado en **MiniO**.

Con esto ya podrias dar por finalizado el procedimiento de copias de seguridad. Pero recordando un docker, que habia conocido gracias a **Lazaro** que no es otro que **backrest**, era el encargado de realizar las copias de seguridad de mi servidor local y subirlas a **Mega**, pero todo se fue 💩, en el momento que empezaron a fallar los HDD por culpa de la [alimentación](/2025-04-20-modificaciones-servidor-3), asi que lo deje de lado. 

Para hacer un breve resumen de lo que es **backrest** es un *cliente grafico* de **restic**, y si eso era asi, podia utilizarlo, como cliente de mis copias de seguridad situadas en el servidor local. Lo unico que tenia que hacer, era informar donde estaban estas copias y que tipo de servicio estaba usando (**S3**).

{{< admonition warning >}}
Con respecto a **backrest**, os recomiendo que vayais a leer el [articulo](https://elblogdelazaro.org/backrest-backups-en-nubes-s3) de **Carlos M.** que tiene en su pagina web.
{{< /admonition >}}

Asi mismo, si os fijais, en el script, concretamente en la parte que se encarga de hacer las copias de seguridad, tenemos estas 2 variables u opciones **TAG_1** y **TAG_2** que:
- **TAG_1** identifica la copia de seguridad
- **TAG_2** identifica el creador de la copia de seguridad

Esto por si solo no hace nada, pero a la hora de ir a **backrest**, en vez de ver que tal copia pertenece a *_unsigned_* que puede hacer un poco de daño a los ojos 😎 lo tenemos identificado por el **TAG_1** y cuando visualizamos la información de las copias vemos el creador de las mismas, que es el **TAG_2**, quedando de la siguiente manera:

![](/images/backrest_02.jpg "BackRest")

Una vez que tenia esto, todo lo demás es bien sencillo.

Ahora si que tengo la unión perfecta de los 3 mundos:
- **Restic** se encarga de realizar las copias de seguridad de mi equipo local a mi servidor **S3**
- **MiniO** es mi servidor de copias de seguridad (**S3**)
- **Backrest** mi cliente grafico, para visualizar las copias de seguridad que voy haciendo y asi tenerlas controladas

Aqui podria añadir un mundo más que seria **Matrix** que es el encargado de notificarme las acciones que se van haciendo mientras se realiza la copia de seguridad.

Lo unico que hay que tener en cuenta con **Backrest**, es lo siguiente:
- Trabajando de esta manera, cuando nos conectamos a el, no refresca, o yo no he sabido como hacerlo, los snapshost, asi que solamente tenemos que ir a nuestra sección de repositorios y refrescar el indice de estos y ya nos aparecen las copias de seguridad
- En el momento que queramos recuperar algun archivo, no lo hace contra mi equipo local, no te aparece el fichero y tu lo descargas y listo, sino que lo recupera en el servidor local, asi que una vez que se ha recuperado, tienes que ir al directorio donde lo ha dejado y moverlo a tu equipo local. Como alternativa, es recuperar desde tu equipo local el archivo que necesitas y entonces si que funcionara.

Hasta aqui hemos llegado la segunda parte de este articulo, nos queda la ultima y no por ello la menos importante.
#### Referencia
- [El Blog de Lázaro - Restic](https://elblogdelazaro.org/tags/restic)
- [677 - No pierdas tus datos. Backups infalibles](https://atareao.es/podcast/no-pierdas-tus-datos-backups-infalibles)
- [680 - Backups en Android con Restic](https://atareao.es/podcast/backups-en-android-con-restic)
- [Como hacer copias de seguridad cifradas con Restic de forma automática](https://geekland.eu/copias-de-seguridad-con-restic-de-forma-automatica)

