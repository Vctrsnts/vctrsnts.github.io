#!/bin/bash

# UpToGit 0.2
# Actualitzar facil i rapidament el teu repositori de Git
# (CC) 2011 Alfonso Saavedra "Son Link"
# http://sonlinkblog.blogspot.com
# Bajo licencia GNU/GPL

# Mode de fer servir: executal de la següent manera:
# bash up2Git.sh <fitxers>

# Actualitzem els permisos dels fitxers de _site
chown -R nobody:users /mnt/user/appdata/hugo/blog/public

# Actualitzem la clau publica de GitHub
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/github_web

ssh -T git@github.com

sleep 10

rm -rf .fuse*
# Actualitzem la baseURL de la web
docker exec -it hugoBlog hugo --baseURL="https://vctrsnts.github.io"

# Comprovem si el directori on ens trobem es un repositori de Git
if [ ! -d '.git' ]; then
	echo 'Aquesta carpeta no conte cap repositori de Git'
	exit -1
fi

# Actualitzacio del directori de treball
git config --global user.email "vctrsnts@gmail.com"
git config --global user.name "Vctrsnts"

git config --global --add safe.directory /mnt/user/appdata/hugo/blog/public

# Ara validem si hem rebut cap parametre
if [ $# == 0 ]; then
	echo "Up2Git: ¡Error! No hem rebut cap parametre"
	echo "up2Git fitxer_1 fitxer_2 ... fitxer_N"
	exit -1
else
	# Revisem tots els parametres per validar si son directoris o fitxers
	for file in $*; do
		if [ ! -e $file ]; then
			echo "Up2Git: l'arxiu o directori $file no existeix"
			exit -1
		fi
	done
	
	# Si em arribat fins aqui, informem a Git dels arxius a pujar
	git add $*
	
	# Aixo ens demanar el missatge de commit
	echo "Entri el missatge del commit:"
	read TXT
	git commit -m "$TXT"

	# I finalitzem pujant els arxius
	git push origin HEAD:master
fi
