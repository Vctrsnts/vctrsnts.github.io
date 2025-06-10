# Equipo en la recamara

Como ya decia en el anterior [articulo](/2023-08-01-de-nuevo-cambiando-servidor), donde hablaba sobre el  nuevo cambio de servidor que habia hecho, el canal de [HomeLabs.Club](https://homelabs.club) es una mala influencia, teneis que hacerme caso y ahora lo entendereis mejor.

<!--more-->

Muchas de las personas, después de comprar el **m910x** le hacen un **mod**, que consiste en sobreescribir la BIOS del **Thinkcenter**. Con esta modificación de la BIOS, a parte de permitir más memoria RAM, tambien te permite añadir CPU's de otras generaciones, para obtener más información puedes visualizar este [video](https://www.youtube.com/watch?v=ZDUWrwq1PXE) creado por uno de los miembros del canal.

Una vez que has realizado la modificación, entre las diferentes opciones que tienes a tu disposición, después de modificar la BIOS, es poder usar un Xeon en el Thinkcenter. Si lo has leido bien, un **Xeon**. La unica pega es que lo compras a vendedores de China (Aliexpress), o tambien conocidos como los **Xeon chinos**, (muchos seguramente vendran de Datacenters que los han cambiado por nuevas versiones) pero aun así, es un ***Xeon***. Y es lo que hice, realize la modificación de la BIOS y compre este [Xeon](https://es.aliexpress.com/item/1005003228035285.html) que tiene **6 nucleos** y **12 hilos**. O sea una barbaridad.

Ya que estabamos puestos, tambien me compre una nueva tarjeta grafica:

![](/images/P1000.jpg "Nvidia P1000")

Si una tarjeta grafica **Nvidia Quadro P1000** y que junto a esta ~~[tapa](https://www.thingiverse.com/thing:6249227)~~, la versión que accepta un ventilador, tengo un Tiny que seguramente nunca me lo voy a acabar. Es resumen el Tiny que me espera en la recamara tiene las siguientes caracteristicas:
- Thinkcenter m910x
- Intel Xeon E-2176M
  - Tener presente que el Xeon se calienta más que una CPU normal y se aconseja poner metal liquido entre la CPU y el headpipe (necesariamente de cobre) porque el ventilador se pone en modo reactor cuando la CPU coge temperatura
- 32Gb de memoria RAM
- Tarjeta Grafica Quadro P1000
  - 4 salidas disponibles
  - Al poner este tipo de tarjetas, se anula la opción de poner un SSD y se tiene que ir por un nvme

![](/images/m910x.jpg "Thinkcenter M910x")

A y me olvido una cosa importante, es que para este tipo de modificaciones necesitas si o si un transformador de como minimo 90w, porque sino, puedes tener problemas.
#### Referencia
- [Mod Bios](https://www.youtube.com/watch?v=ZDUWrwq1PXE)
- [Intel Xeon E-2176M](https://es.aliexpress.com/item/1005003228035285.html)
- [Xeon y Kits Chinos](https://podcastlinux.com/posts/podcastlinux/178-Podcast-Linux)
- [Xeon Chinos](https://podcastlinux.com/posts/podcastlinux/179-Podcast-Linux)

