# Descargar Podcast a traves de Flexget

Gracias que tengo docker puedo usar la imagen que he creado de [Flexget](https://flexget.com), una aplicación que a traves de un fichero **yaml**, permite descargar lo que quieras incluidos podcast.

En principio me gustan los que tengas que ver con la tecnologia y sobre todo lo que tenga que ver con GNU/Linux. Pero a parte de estos tambien tengo un podcast de historia que me encanta mucho y cuando me acuerdo lo escucho. Este podcast se llama [En Guàrdia](https://www.ccma.cat/catradio/en-guardia).

Y buscando información al final consegui averiguar que a traves de **Flexget** se pueden descargar Podcast asi que me puse a ello y gracias a un script para dicho proposito ya puedo descargar los podcast de este programa sin preocuparme.

<!--more-->

Este script esta compuesto por 2 secciones. Estas secciones son el **template**, que consiste en una plantilla con los filtros que se tiene que tener en cuenta a la hora de descargar los podcast.

Una vez definido el **template**, pasamos a definir la tarea **task** donde en base al **template** se encargara de descargar los podcast.

La primera parte del script **template** esta compuesto por los siguientes filtros (en mi caso):
```yaml
templates:
 podcast:
   accept_all: yes
   # PER A QUE SOLAMENT DESCARREGUI ELS 5 ULTIMS PODCAST
   limit_new: 5
   # COM VOLEN QUE ES DIGUI EL FITXER DESCARREGAT
   # ABANS I DESPRÉS DE LA CONFIGURACIÓ DEL NOM PORTA DOBLES COMETES
   set:
     filename: # NOM AMB QUE ES DESCARREGARA EL FITXER MP3
```

Ahora vamos a poner el script que se encarga de descargar (en base al **template**) los podcast:
```yaml
#
# DESCARREGA DE PODCAST
#
tasks:
 # PODCAST EN GUARDIA
 podCastEnGuardia:
   template: podcast
   # RSS (XML) del programa
   rss: https://dinamics.ccma.cat/public/podcast/catradio/xml/4/4/podprograma944.xml
   # DIRECTORI DE DESCARREGA
   download: /media/podcast
```

Por ultimo podriamos poner el **calendario** de ejecución de este script, en mi caso, le indico que todas las tareas **tasks** que empiezen por **podCast** se ejecuten una vez al dia:
```yaml
#
# CALENDARI EXECUCIÓ DE LES TASQUES
#
schedules:
 # DESCARREGA PODCAST
 - tasks: ['podCast*']
   interval:
     days: 1
```
 
Este script tiene que estar en el fichero `config.yml` de flexget. Lo que se puede hacer antes, es probar que todo funciona correctamente a traves de la instrucción (dentro de docker):
```bash
usuari@debian:~$ flexget --test execute --task podCastEnGuardia --dump
```

Ahora solamente nos queda disfrutar.
#### Referencia
- [Flexget](https://flexget.com)
- [Script para descargar podcast con flexget](https://forums.unraid.net/topic/46910-simple-podcast-downloader-script/)

