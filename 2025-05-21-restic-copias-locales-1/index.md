# Restic + Backrest + MiniO - 1

Lo primero y antes de nada, tengo que dar las gracias a **Lázaro** de [El Blog de Lázaro](https://elblogdelazaro.org) y a **Lorenzo** de [Atareao](https://atareao.es), por todo el conocimiento que me han aportando, porque si eso, yo no podria haber hecho lo que voy a explicar en este articulo. Muchas gracias 👏.

<!--more-->

Ahora vamos a explicar como gracias a estas 2 increibles personas, he creado mi perfecto (para mi), sistema de copias de seguridad.

{{< admonition note >}}
Tengo que decir que me falta la parte de externalizar las copias, pero es muy parecido a lo que tengo ahora, asi que no debe de haber muchos problemas.
{{< /admonition >}}

Lo primero y más basico, es explicar lo que quiero hacer:
- Mediante **restic**, hacer las copias de seguridad de mi equipo personal y llevarlas al servidor local con **unRaid**.
- **Atareao** explica que lo correcto es hacer una copia de seguridad en local, otra al servidor local y una al VPS externo.
  - Yo entiendo que las copias en local, si te falla el HDD / SDD del equipo no sirven de nada, que mejor hacer solo copia de seguridad en servidor local (que ya tengo implementado) y otra en VPS externo (que me falta por implementar).
- Mantener la regla de *7 copias diarias*, *4 semanales*, *6 mensuales*. Me parece un poco excesivo, pero nunca se sabe, más vale prevenir que curar.

Asi que me puse a ello. Pero lo primero era tener un HDD para guardar las copias de seguridad, y eso, ahora mismo, con mi nuevo [servidor](/2025-04-20-modificaciones-servidor-3) es muy sencillo realizar esta ampliación, solamente he aprovechado un HDD de 1Tb que tenia por aqui tirado, lo he conectado a *unRaid* y a funcionar. De nuevo, tengo que dar las gracias a **@Mr. H**, por el increible diseño que ha hecho.

Una vez que ya tenia mi disco para las copias de seguridad, venia el momento de instalar **restic** en mi equipo personal y en Debian GNU/Linux, con un simple **APT** lo tienes instalado:
```
usuari@debian:~$ sudo apt install restic
```
Ya esta instalado.

Ahora pasamos a las cosas más complicadas, la instalación de **backrest** y de **MiniO**. 

Pero complicado si no estas en **unRaid**, sino es tan facil como ir a la sección **Apps**, buscar **backrest** e instalar. No voy a explicar como se hace la instalación en **unRaid**, primero, porque es muy sencilla y porque solamente tienes que configurar que te aparece, y si no hay suficiente con esto, tienes esta otra, porque **Lázaro**, ha hecho un [articulo](https://elblogdelazaro.org/backrest-una-interfaz-web-para-restic-backup) donde lo explica mucho mejor, asi que, porque inventar la rueda si ya esta inventada.

![](/images/backrest_01.jpg "Backrest")

![](/images/minio.png "MiniO")

Una vez, tenemos **backrest**, solamente nos falta la instalación de **MiniO** y como antes, mejor leer el [articulo](https://atareao.es/podcast/no-pierdas-tus-datos-backups-infalibles) de **Lorenzo** que tambien lo explica muy bien.

{{< admonition note >}}
Lo que hay que tener en cuenta a la hora de instalar **MiniO** es la nota que añade el creador de este docker, para cuando se usa en **unRaid**
{{< /admonition >}}

{{< admonition warning >}}
Attention: Unfortunately due to changes in Minio, the unRAID file system is no longer supported. The only way to get Minio to work on unRAID now is by mapping a single disk directly or setting up a V-Disk. 
{{< /admonition >}}

En mi caso, no he tenido ningun problema, porque solamente tengo un HDD para las copias de seguridad, pero siempre hay que tenerlo en cuenta.

### A tener en cuenta en la configuración de nuestro repositorio en backrest
A la hora de realizar la instalación de **backrest**, tenemos que tener en cuenta, que la **Ip local** tiene que ser la de nuestro servidor, es el que recibe las copias de seguridad de **restic** de nuestro equipo local.

Asi mismo, en mi caso, no tengo configurado ningun plan de gestión de copias, porque eso se encarga el script de `bash` que tengo en mi equipo local haciendo las copias de seguridad.

Después de este pequeño apunte, voy a explicar algunas cosas sobre el uso y funcionamiento de **restic** que nos pueden venir bien para más adelante.

### 1. Saber el estado de las copias:
```
usuari@debian:~$ restic -r /path/to/backup snapshots
```
#### 2. Para crear copias de seguridad de varios directorios
```
usuari@debian:~$ restic -r /path/to/backup backup /dir_1 /dir_2 etc....
```
#### 3. para restaurar copia de seguridad
```
usuari@debian:~$ restic -r /path/to/backup restore latest --target /dir_recuperar
```
#### 4. Borrar repositorios para solo mantener X repositorios
{{< admonition tip >}}
En este caso, como ejemplo, hemos puesto 6 (en este caso hemos puesto 6)
{{< /admonition >}}

```
usuari@debian:~$ restic -r /path/to/backup forget --keep-last 6 prune
```
### 5. Borrar backups de más de 30 dias
```
usuari@debian:~$ restic -r /path/to/backup forget --keep-within 30d
```
Ahora vendria la parte más interesante, el como hacer uso de estas 3 aplicaciones para manejar nuestras copias de seguridad, pero esto lo explicare en el siguiente [articulo](/2025-05-22-restic-copias-locales-2), porque sino, este puede salir muy largo y volverme muy pesado.
#### Referencia
- [El Blog de Lázaro - Restic](https://elblogdelazaro.org/tags/restic)
- [677 - No pierdas tus datos. Backups infalibles](https://atareao.es/podcast/no-pierdas-tus-datos-backups-infalibles)
- [680 - Backups en Android con Restic](https://atareao.es/podcast/backups-en-android-con-restic)
- [Como hacer copias de seguridad cifradas con Restic de forma automática](https://geekland.eu/copias-de-seguridad-con-restic-de-forma-automatica)

