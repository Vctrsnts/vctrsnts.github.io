#!/bin/bash
# ================================================================
# Script: up2git.sh
# Descripción: Automatiza la generación y despliegue de un sitio Hugo
#              en dos repositorios distintos (GitHub Pages y Codeberg Pages),
#              usando un único directorio `public/` pero con builds separados
#              para cada `baseURL`. Realiza dos commits consecutivos:
#              uno para GitHub y otro para Codeberg.
#
# Autor:  Vctrsnts
# Fecha:  25-11-2025
# Licencia: GNU/GPL
# Repositorios destino:
#   - GitHub:   https://github.com/usuario/vctrsnts.github.io
#   - Codeberg: https://codeberg.org/usuario/pages
#
# Uso:
#   ./up2git.sh fichero1 fichero2 ... ficheroN
#
# Notas:
#   - Requiere Docker con contenedor `hugoBlog`.
#   - Requiere claves SSH configuradas en:
#       /root/.ssh/github_web
#       /root/.ssh/idCodeBerg
#   - El script pregunta un mensaje de commit y lo aplica a ambos repos.
# ================================================================

set -e  # Detener el script si ocurre un error

# Arrancar agente SSH de forma segura en /tmp
unset XDG_RUNTIME_DIR
ssh-agent -a /tmp/ssh-agent.sock > /tmp/ssh-agent.env
source /tmp/ssh-agent.env

# Añadir claves
ssh-add /root/.ssh/github_web
ssh-add /root/.ssh/idCodeBerg

# Añadir git config por si no esta disponible
git config --global --add safe.directory /mnt/user/appdata/hugo/blog/public
git config --global user.email "vctrsnts@gmail.com"
git config --global user.name "Vctrsnts"

# Validación de parámetros
if [ $# -eq 0 ]; then
  echo "Error: no se han recibido archivos"
  echo "Uso: ./up2git.sh fichero1 fichero2 ... ficheroN"
  exit 1
fi
for file in "$@"; do
  [ -e "$file" ] || { echo "Error: $file no existe"; exit 1; }
done

# Mensaje de commit
read -p "Entri el missatge del commit: " TXT

# Función para build
build_site() {
  local baseurl=$1
  echo "Generant web per $baseurl..."
  docker exec -it hugoBlog npm install -g pagefind && docker exec -it hugoBlog hugo --baseURL="$baseurl" && docker exec -it hugoBlog pagefind --site public
  # --destination="public"
}

# Build y push a GitHub
echo "==== Build GitHub ===="
build_site "https://vctrsnts.github.io"
git add "$@"
git commit -m "$TXT (GitHub)"
git push github master

# Build y push a Codeberg
echo "==== Build Codeberg ===="
build_site "https://vctrsnts.codeberg.page"
git add "$@"
git commit -m "$TXT (Codeberg)"
git push codeberg master

# Redes sociales
read -p "¿Enviar el missatge a xarxes socials? (s/n): " RESP
[[ "$RESP" == "s" ]] && python3.11 /mnt/user/personal/bot/botSocialMediaUltim.py

echo "==== Cerramos el agente de SSH ===="
trap "kill $SSH_AGENT_PID" EXIT && rm -rf /tmp/ssh-agent*

echo "==== Actualització completada! ===="
