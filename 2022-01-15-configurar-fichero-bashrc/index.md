# Configurar el fichero .bashrc para descomprimir ficheros

A continuación, explicare como tengo configurado mi `.bashrc` para que a la hora de descomprimir archivos todo me sea más facil y rapido.

Esto se consigue añadiendo un **alias** con las opciones / programas más comunes para la compresión y descompresión de archivos.

<!--more-->

Lo primero es editar nuestro fichero `.basrch` y hacerle las siguientes modificacions:
```bash
#### EXTRACCIÓ DE FITXERS
# usage: ex <file>
ex ()
{
 if [ -f $1 ] ; then
   case $1 in
     *.tar.bz2)   tar xjf $1   ;;
     *.tar.gz)    tar xzf $1   ;;
     *.bz2)       bunzip2 $1   ;;
     *.rar)       unrar x $1   ;;
     *.gz)        gunzip $1    ;;
     *.tar)       tar xf $1    ;;
     *.tbz2)      tar xjf $1   ;;
     *.tgz)       tar xzf $1   ;;
     *.zip)       unzip $1     ;;
     *.Z)         uncompress $1;;
     *.7z)        7z x $1      ;;
     *.deb)       ar x $1      ;;
     *.tar.xz)    tar xf $1    ;;
     *.tar.zst)   unzstd $1    ;;
     *)           echo "'$1' no es pot extreure via ex()" ;;
   esac
 else
   echo "'$1' no es un fitxer valid"
 fi
}
```

Con esto lo que conseguimos es que para descomprimir cualquier fichero lo podemos hacer de la siguiente manera:
```bash
usuari@debian:~$ ex nombre_fichero_comprimido
```
#### Referencia

