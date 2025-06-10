# Mi nuevo servidor

Se que llevo mucho tiempo si publicar nada, pero he estado liado haciendos cambios en el servidor (RPI4).

<!--more-->

Como sabeis, antes tenia una Raspberry Pi 4 de 4Gb, pero para algunas cosas, se me quedaba pillado y pense que podia usarla como mediacenter, y cambiar la RPI3 que tenia por esta.

Como estoy en el grupo de Telegram de Thinkpads (unos frikis de cuidado) pues a un compañero del canal, que tenia un Dell a la venta, se lo compre. Y como siempre, cuando me llego, me senti como un niño con zapatos nuevos.

Asi que me lie la manta a la cabeza y el cambio lo hice a lo bestia, ya que hago un cambio, porque no la lio, y ahora tengo un Dell Optiplex 3050 con 8Gb con un i5-7500. O sea un maquinon que no me lo  voy a acabar nunca.

![](/images/dell_3050.png "Dell Optiplex 3050")

Junto con el Dell y algunas cosas que tenia en casa pues me he montado lo siguiente:
- SDD crucial de 250Gb para el Sistema Operativo
- **Debian GNU/Linux STABLE** para no tener ningun problema (cuando es un servidor, prefiero la estabilidad a la novedad)
- El HDD externo de 8Tb (Western Digital) que tenia conectado a la RPI4 que se lo he contectado al servidor

Ahora solo queda hacer el cambio de la RPI4B que tenia haciendo las funciones de servidor y poner el Tiny y de paso, aprovechar (aqui no nada se tira), la RPI4 y ponerla en substitución de la RPI3B que tengo ahora.

Nos pusimos a ello junto mi inseparable **Debian GNU/Linux STABLE**, no quiero jugar a ser dios con **UNSTABLE** en un servidor, y previa actualización del HDD por un SSD Crucial de 250Gb nos pusimos con la instalación.

La instalación no cambia en **Debian GNU/Linux**, sin ningun problema, aunque tuve dudas de que manera particionar el SSD para sacarle el maximo rendimiento. Después de pensar lo deje de la siguiente manera (seguramente hay otra mejor, pero no se me ha ocurrido):
```bash
filesystem   mount point   size
----------   -----------   ----
/dev/sdb1    /             200Gb
/dev/sdb2    swap          4Gb
/dev/sdb5    /home         40Gb
```

Se que en un PC con 8Gb de RAM, poner swap no tiene ningun sentido, pero, nunca se sabe...

Llegados a este punto y sin ningun problema a la hora de la instalación, añadi todo lo que tenia en la RPI4B al Tiny (que no era poco):
- [Nginx Proxy Manager]()
- [Navidrome](https://hub.docker.com/r/deluan/navidrome)
- [Duckdns](https://hub.docker.com/r/linuxserver/duckdns)
- [Flexget](https://hub.docker.com/r/flexget/flexget)
- [Transmission](https://hub.docker.com/r/linuxserver/transmission)
- [aMule](https://hub.docker.com/r/ngosang/amule)
- [Jackett](https://hub.docker.com/r/linuxserver/jackett)
- [Samba](https://hub.docker.com/r/dperson/samba)

{{< admonition note >}}
[aqui](https://www.github.com/Vctrsnts/dot_files) podreis encontrar los ficheros de configuración que estoy usando.
{{< /admonition >}}

Más unos cosas nuevas que he ido aprendiendo por el camino (y todo a traves de Docker):
- `Pi-Hole`: Bloquear toda la publicidad cuando navegas por cualquier sitio.
- `Wireguard`: VPN para poder acceder a tu servidor desde cualquier sitio.
- `Jellyfin`: Queria una especie de biblioteca para saber que tengo (peliculas y series) pero sin necesidad de tener que conectar el HTC. Se que a lo mejor es excesivo, pero no he encontrado nada parecido a lo que quiero, aunque sigo investigando a ver si encuentro algo igual pero más liviano (no necesito todo lo que lleva consigo jellyfin).
- `Jekyll`: Servidor jekyll (GitHub) para crear tu propio blog en local y luego transformar los archivos `markdown` en paginas html y subir a GitHub.
	
Como no puede ser de otra manera, ya esta todo funcionando y sin ningun problema. No esperaba menos de **Debian GNU/Linux** y menos siendo **STABLE**. 

Por eso digo, que tengo servidor para rato y que nunca me lo acabare. A parte de que quiero probar nuevas cosas que voy viendo en los blogs que sigo:
- [Atareado](https://atareao.es)
- [uGeek](https://ugeek.github.io)
- [El Blog de Lázaro](https://elblogdelazaro.org/)

Que sorpresas nos esperan con este nuevo servidor??

Como ya he dicho antes, aprovechando que teniamos a la RPI4B libre, hemos substituido el antiguo mediacenter (RPI3B) por esta más nueva, porque como todo en la informatica, todo avanza, pero esto lo explicare en otro [articulo](/2022-11-08-cambiando-mediacenter) que estoy preparando (y ya os digo que no son buenas noticias).

{{< admonition note >}} 
Después de estos meses de uso, no me puedo quejar, porque el servidor es una maquinon en toda regla, pero ante el aumento de la luz y que a veces, pienso que lo estoy infrautilizando, que no le saco todo el partido y toda la potencia que el Dell me puede dar, me esta rondando por la cabeza, que no se si me he excedido utilizando este servidor. Que a lo mejor, con la RPI4 tendria más que suficiente, para todo lo que tiene que hacer, que aun es poco, pero es la duda que tengo, no se si el Dell esta desaprovechado y derrochando el dinero y en cambio, si pongo la RPI4, no se quedara colgada por todas las cosas que quiero hacer ante la limitación evidente de la Raspberry. Es una cosa que quiero estudiar a fondo, preguntar, ver mirar, etc... y sacar conclusiones.
{{< /admonition >}}
#### Referencia
- [Configurar y usar Pi-Hole - PeladoNerd](https://www.youtube.com/watch?v=qc8mkWtwY9c)
- [Configurar y usar Wireguard - PeladoNerd](https://www.youtube.com/watch?v=G_Pv9XEzfUY)

