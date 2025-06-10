# Script para actualizar tu GitHub

Buscando maneras de facilitarme el trabajo con [GitHub](https://www.github.com) que es donde tengo alojada mi web (más bien son mis projectos, apuntes y cosas por es estilo) porque para subir cualquier cosa a `GitHub` era una tocada de huevos en mi caso.

<!--more-->

Así que me puse a buscar algun script para ayudarme a realizar las actualizaciones de mis repositorios en Git, y después de mucho buscar, al final lo encontre.

Es el siguiente que pongo a continuación
```bash
#!/bin/bash

# Actualitzar rapidament el teu repositori de Git
# (CC) 2011 Alfonso Saavedra "Son Link"
# http://sonlinkblog.blogspot.com
# Bajo licencia GNU/GPL

# up2Git.sh <ficheros>

# Comprovem si el directori en el que estem, es un repositori de Git
if [ ! -d '.git' ]; then
 echo 'Aquest directori no conte un repositori de Git'
 exit -1
fi

# Ara validem i l'hi hem passat algun parametre
if [ $# == 0 ]; then
 echo "Up2Git: ¡Error! No l'hi has passat cap parametre"
 echo "up2Git fitxer_1 fitxer_2 ... fitxer_N"
 exit -1
else
 # Revisem els parametres per validar si son fitxers o directori
 for file in $*; do
   if [ ! -e $file ]; then
     echo "Up2Git: L'arxiu o directori $file no existeix"
     exit -1
   fi
 done
 
 # Si hem arribat fins aqui, informem a Git dels arxius a pujar
 git add $*
 
 # Aixo ens demana el missatge del commit
 echo "Informi del missatge del commit:"
 read TXT
 git commit -m "$TXT"

 # i finalitzem pujant els arxius
 git push origin master
fi
```

Para usarlo, en mi caso, lo hago de la siguiente manera :
```bash
usuari@debian:~$ bash up2Git.sh .
```

El script es de `Alfonso Saavedra` a el todo mi agradecimiento, por facilitarme el tener mis repositorios de GitHub actualizados.
#### Referencia
- [Son Link](https://sonlinkblog.blogspot.com)
- [Script](https://gist.github.com/son-link/890903)

