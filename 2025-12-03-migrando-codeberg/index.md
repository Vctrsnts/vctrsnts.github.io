# Migrando a Codeberg

Después de leer el [mensaje](https://www.genbeta.com/inteligencia-artificial/ceo-github-proclamo-abraza-ia-estas-fuera-respuesta-muchos-proyectos-software-esta-siendo-irse-fuera-github) que ha lanzado el CEO de [gitHub](https://github.com) que en pocas palabras ha hecho una [ayusada](https://www.lavanguardia.com/nacional/20251009/11141043/psoe-califica-salvajada-grave-ayuso-diga-mujeres-vayan-sitio-abortar-agenciaslv20251009.html), me he propuesto hacerle caso y voy a ir migrando, dentro de lo que cabe, todo a [Codeberg](https://codeberg.org).

<!--more-->

No tenia pensado hacer el cambio, pero después de leer este articulo, a uno le dan ganas de salir corriendo, pero claro, no lo puedes hacer a las bravas si es hay donde tienes alojada tu pequeña pagina web.

Asi que lo que he decidido es ir migrando poco a poco todo lo que tenia alojado hay. He archivado casi todos los proyectos que tenia y los he llevado a **Codeberg**. El unico proyecto que aun queda en pie es la pagina web.

Os preguntareis como conoci **CodeBerg**, ahora que lo pienso, no se si leyendo por internet o en alguno de los canales de telegram a los que estoy subscrito:
- **atareao**
- **HomeLabs**

Realmente no me acuerdo, pero cuando lo descubri, me cree mi cuenta, para asi poder tener reservado mi nombre de usuario, porque contra más tardes, más dificil se hace luego tener el nombre de usuario que quieres, y segundo, porque nunca se sabe si algun dia lo vas a utilizar.

Mi idea principal, era utilizarlo para la web [alternativa](https://vsantos.envs.net) que tengo donde voy poniendo los libros que voy leyendo, pero esta al final, la tengo alojada en [envs.net](https://envs.net).

{{< admonition note >}}
**envs.net** es un servidor libre para pequeñas pruebas o paginas web, alojadas sin ningun animo de lucro y como para la web alternativa, no necesitaba mucho y el trafico iba a ser infimo, pues era el sitio correcto.
{{< /admonition >}}

Tambien pense en que podia poner mi blog aqui, pero no lo vi claro, porque si ya tengo pocas visitas en *gitHub*, si lo hubiera llevado a *codeBerg*, las visitas ya os podeis imaginar como irian...

Aunque si estas leyendo esto, seguramente has accedido al blog que esta alojado en [codeberg](https://vctrsnts.codeberg.page). Eso no quita que a la hora de subir los nuevos articulos lo haga en los 2 sitios, porque nunca se sabe donde puede acabar todo esto.

Partiendo de esta idea y con ayuda de la IA, me he creado un script en bash, desde el cual hago la actualización de los 2 repositorios al mismo tiempo, **gitHub** y **codeBerg**. 

El script es el siguiente:
```bash
#!/bin/bash
# ================================================================
# Script: gitHubCodeBerg.sh
# Descripción: Automatiza la generación y despliegue de un sitio Hugo
#              en dos repositorios distintos (GitHub Pages y Codeberg Pages),
#              usando un único directorio `public/` pero con builds separados
#              para cada `baseURL`. Realiza dos commits consecutivos:
#              uno para GitHub y otro para Codeberg.
#
# Autor:  Vctrsnts
# Fecha:  25-11-2025
# Web: https://vctrsnts.codeberg.page
# Licencia: GNU/GPL
# Repositorios destino:
#   - GitHub:   https://github.com/vctrsnts/vctrsnts.github.io
#   - Codeberg: https://codeberg.org/vctrsnts/pages
#
# Uso:
#   ./gitHubCodeBerg.sh fichero1 fichero2 ... ficheroN
#
# Notas:
#   - Requiere Docker con contenedor `hugoBlog`.
#   - Requiere claves SSH configuradas en:
#       ~/.ssh/github_web
#       ~/.ssh/idCodeBerg
#   - El script pregunta un mensaje de commit y lo aplica a ambos repos.
# ================================================================

set -e  # Detener el script si ocurre un error

# Arrancar agente SSH de forma segura en /tmp
unset XDG_RUNTIME_DIR
ssh-agent -a /tmp/ssh-agent.sock > /tmp/ssh-agent.env
source /tmp/ssh-agent.env

# Añadir claves
ssh-add ~/.ssh/github_web
ssh-add ~/.ssh/idCodeBerg

# Validación de parámetros
if [ $# -eq 0 ]; then
  echo "Error: no se han recibido archivos"
  echo "Uso: ./gitHubCodeBerg.sh fichero1 fichero2 ... ficheroN"
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
  docker exec -it hugoBlog hugo --baseURL="$baseurl"
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
[[ "$RESP" == "s" ]] && python3.11 ~/bot/botSocialMediaUltim.py

echo "==== Cerramos el agente de SSH ===="
trap "kill $SSH_AGENT_PID" EXIT && rm -rf /tmp/ssh-agent*

echo "==== Actualització completada! ===="
```
Como podeis ver, se actualiza todo en el mismo instante.

Pues bueno, este es el ultimo y primer articulo de una nueva era en mi camino para la publicación de mis pensamientos, ideas y descubrimientos que voy haciendo en este nuestro complicado mundo de la *informatica*, *programación* y *selfhosted*.

Lo unico que me queda por conseguir, seria obtener un nombre de dominio para esta web, pero lo primero y más importante, no quiero que con ello se me vaya una nomina entera, a parte, que entiendo que para ser 100% libre, tambien tendria que tener alojada la web en un VPS (del que ya dispongo), pero mejor configurado y apuntando al dominio y eso es un tema que desconozco totalmente y por el que caminaria a ciegas.
#### Referencia
- [Abandonado gitHub](https://www.genbeta.com/inteligencia-artificial/ceo-github-proclamo-abraza-ia-estas-fuera-respuesta-muchos-proyectos-software-esta-siendo-irse-fuera-github)
- [Ayusada](https://www.lavanguardia.com/nacional/20251009/11141043/psoe-califica-salvajada-grave-ayuso-diga-mujeres-vayan-sitio-abortar-agenciaslv20251009.html)

