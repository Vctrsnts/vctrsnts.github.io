# Mi nuevo mediacenter - Thinkcenter m710q

Como ya mencione en al articulo que hablaba sobre el cambio de servidor [Mi nuevo servidor](/2022-05-26-nuevo-servidor), me di cuenta que me quedaba con la RPI4 de 4Gb sin utilizar. 

<!--more-->

Asi que decidi cambiar la antigua RPI3 donde empezaba ya a tener problemas con los nuevos codecs con que venian las peliculas (HEVC 10b-AC3) y cambiarla por la RPI4 con soporte para estos nuevos codecs y que no usaba por haberla sustituido por el Dell.

Me puse manos a la obra con ello, pero ya os digo que me decepciono un monton la RPI4.

Lo primero fue bajarme la imagen compatible de Libreelec para mi RPI4 y su posterior instalación. Todo esto conectado a un monitor que tengo en casa para estas pruebas / instalaciones.

No tuve ningun problema la la hora de la instalación y de la configuración (Wifi, pluguins, conexión a SAMBA, etc...) todo perfecto. Luego lo conecto al TV que tengo en el salon con un conversor de HDMI a micro-HDMI y no funcionaba. No se veia nada, todo en negro. Aqui es donde pienso que no he hecho bien la instalación / configuración, que no lee correctamente la resolución, o sea las cosas más normales que te puedas imaginar. 

Busque información por inet, pregunte a uno de los canales de Telegram donde estoy que tratan sobre las RPI4 como mediacenter, etc... y todos me decian, que tenia que forzar la resolución a traves del fichero `config.txt`. Todo sin obtener ningun resultado.

Al final me canse de trastear con la RPI4, y eso que habia hecho miles de instalaciones pensado que hay es donde residia el problema. Al final ya me quedo claro, que el problema no era la instalación, sino el conversor de HDMI a micro-HDMI que no funcionaba correctamente. Asi que el siguiente paso, fue comprar un cable de HDMI a micro-HDMI. 

Una vez que me llego el cable correcto, vuelta a hacer una nueva instalación conectando la RPI4 al monitor de pruebas. Todo funcionaba a las mil maravillas, la WIFI excelente, la imagen perfecta, hay es donde me dije, pues ya esta todo en marcha y listo para volver a funcionar. Hay infeliz de mi!!!

Me llevo la RPI4 al TV del comedor y la conecto y no me lo podria creer, todo funcionaba perfectamente. Pues ya esta, lo vuelvo a tener todo en perfecto estado y en marcha hasta que puse a usar la RPI4 con la WIFI y aqui es donde se me cayo el mundo encima.

No me lo podia creer, la WIFI no funcionaba ni a patadas, la pelicula se quedaba congelada y no se veia nada!!! yo tirandome de los pelos porque no entendia nada, si hasta hace 5 minutos todo funcionaba correctamente y ahora de golpe y porrazo no funciona nada. Volvemos a estar como en el principio.

A partir de aqui todo fueron problemas. Pero vamos a explicar todo lo sucedido paso a paso.

Lo primero fue copiar la imagen de Libreelec en el SSD e iniciamos la instalación / configuración de Libreelec. Todo funciona perfectamente hasta llegar a la configuración de la `WIFI` (y esto si que es para mear y no echar gota).

Despues de buscar información como un loco, veo que hay un error (validado y reportado) en el diseño de la Raspberry que es, cuando usas la WIFI esta se `acopla` a la señal del cable HDMI y hace que se anule la señal WIFI. Para solucionar este problema se puede hacer de 3 maneras:
- **Solución dificil**, cambiar de canal en el que emite tu router por otro diferente para que no se acople a la señal del cable HDMI.
- **Solución facil**, desactivar la WIFI de la Raspberry y usar un conector USB-WIFI
- **Solución ideal**, esperar a que Raspberry saque un nuevo firmware que solucione este problema. Se comenta que hasta finales de año no estara disponible.

En mi caso, lo que hice fue escoger la solución facil, me compre un usb-wifi y volvi de nuevo a configurar la RPI4B, esperando, por fin, poder usarla como HTC.

Volvemos a reiniciar la configuración de la WIFI sin ningun problema, esta vez, ya tenemos la RPI4B conectada a la WIFI, pero parece ser que entre el SSD conectado a traves de USB, el mando a distancia conectado a traves de USB y el USB de la WIFI, la Raspberry no podia manejar correctamente toda la `información` que recibia.

Para que os hagais una idea, la RPI3B funcionaba mejor que la RPI4B y eso que esta ultima (siempre lo añado a todos mis Libreelec) habia creado el fichero `advancedsettings.xml` donde le añado lo siguiente:
```bash
<advancedsettings version="1.0">
 <cache>
   <buffermode>4</buffermode>
   <memorysize>0</memorysize>
 </cache>
</advancedsettings>
```

Donde:
- `buffermode`: le indica a Kodi que tipo de buffer que se va a usar (en mi caso, selecciono el valor `4` para el tratamiento de ficheros a traves de samba, nfs).
- `memorysize`: le indica a Kodi que de que manera va a usar la RAM (en mi caso, selecciono el valor `0` para que de preferencia al SSD/HDD en vez de a la RAM).

De esta manera se consigue que mientras se visualiza la pelicula / serie, se descargue el fichero y no tener problemas a la hora de visualización.

Pero en mi caso, esto no pasa, para que os hagais una idea de como funciona, que habia veces (da igual que versión de mkv fuera, 264, 265) que Kodi se quedaba colgado, incluso usando un SSD.

Al final, cansado de ver que era imposible usar la RPI4B, empeza a investigar y a preguntar en un canal de Telegram sobre usar la Raspberry como HTC y se llego a la conclusión de que era el USB que se colapsaba y en cambio esto mismo (en la RPI3B) no pasa, porque como por defecto, uso la WIFI que ya lleva incorpada, pues...

Asi estamos, usando la RPI4B como HTC, desilusionado ante el mal funcionamiento de lo que tendria que ser la mejor Raspeberry hasta el momento.

Por eso digo, que maldita el dia que se me ocurrio cambiar mi RPI3 (se que era un cambio necesario, la tecnologia siempre esta en constante evolución y más los codecs para ver las peliculas son los que mandan) a la RPI4, y ahora la tengo tirada en casa sin usar, por culpa de este problema, aunque 😉 podria haberla vendido y sacarme una pasta, porque tal como estan las RPI4, ganaria pasta seguro, pero me da pena venderla, porque nunca se sabe cuando te va hacer falta una.

Asi que despues (de nuevo, pregunte en otro canal de Telegram) me aconsejaron que lo mejor y que para ahorrarme futuros problemas, que lo mejor es tener un PC conectado a la TV del comedor y me ahorro todos los problemas derivados con los codecs y el soporte de estos, porque en un PC normal y corriente tiene más recorrido que la RPI4. 

Fue lo que hice, volvi a mi canal favorito de Thinkpads de Telegram y pregunte si alguno le sobrava algun Tiny. Y ten por seguro que siempre hay alguien que le sobra un Tiny.

Como todo en este mundo, es mutable y ante la posibilidad de conseguir a buen precio un [Lenovo Thinkcenter M710q](https://icecat.biz/es/p/lenovo/10mr0047us/thinkcentre-pcs-workstations-m710q-36768136.html), asi que me lance de cabeza por el.

![](/images/lenovo-m710q.jpg "Lenovo Thinkcenter M710q")

Ya me veis, de tener 2 RPI (RPI4 con 4Gb como servidor y una RPI3 como mediacenter) a tener un Tiny Lenovo m710q con 8Gb y un i5-6500 como mediacenter y un Dell Optiplex 3050 con 8Gb y un i5-7500 como servidor.

Por eso digo, que a veces no hay mal que por bien no venga.
#### Referencia
- [Libreelec](https://libreelec.tv)
- [RPI4B pierde cobertura Wifi](https://www.adslzone.net/2019/11/28/problemas-wifi-raspberry-pi-4/])
- [Raspberry Pi 4 WiFi stops working at 2560x1440 screen resolution](https://www.enricozini.org/blog/2019/himblick/raspberry-pi-4-loses-wifi-at-2560x1440-screen-resolution/)
- [Cambiar el funcionamiento de la cache en Kodi](https://kodi.wiki/view/Advancedsettings.xml)

