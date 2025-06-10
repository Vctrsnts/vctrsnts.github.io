# Controlando la temperatura del servidor

Como ya comente en el anterior [articulo](/2024-10-19-modificando-servidor-2) donde explicaba que habia puesto un **Xeon** en mi servidor y todo lo referente a la temperatura.

Pero claro, eso me gustaria verlo reflejado en **unRAID**, porque hasta ahora, solamente habia podido visualizar la temperatura de la CPU, de la placa base era imposible cuando teoricamente los Tiny son equipos con componentes muy normales y comunes.

<!--more-->

Pues en este caso, de comunes lo tienen todo menos los sensores de control de la temperatura. Además **unRAID** no ayudaba mucho con ello. Seguramente muchos direis, y por que no instalas el plugin **Dynamix System Temperature** y problema solucionado.

Ya lo tengo instalado y aun así, lo unico que podia visualizar era la temperatura de la CPU:

![](/images/configure_temperature_01.jpg "Configurando Temperatura")

Eso que teoricamente *sensors* funcionaba correctamente. Eso creia yo.

Asi que después de instalar el **Xeon** me propuse visualizar todas las temperaturas posibles para asi controlar mejor el servidor, porque no es lo mismo tener un *i5-6500T* que un **Xeon** y lo primero de todo era saber que **sensor** se tenian que usar para poder visualizar la información de ellos. y resulto que me toco el peor de todos, el que es más complicado de hacer funcionar. Ni más ni menos que el **nct6683**.

En todos los sitios que encontraba información, porque me resulto muy dificil, decian que no era nada facil hacerlo funcionar en GNU/Linux, pero yo segui buscando hasta que encontre la siguiente [web](https://fun2ex.com/fixed-z370m-pro4-unraid-temperature-problem), donde explicaban que se tenia que hacer para hacer funcionar los sensores del **nct6683**.

Lo que habia que hacer es ejecutar lo siguiente:
```bash
root@unRaid: modprobe coretemp
root@unRaid: modprobe -r nct6683
root@unRaid: modprobe nct6683 force=1
```
Lo probe, y mira por donde que dio resultado. Podia ver todos los sensores disponibles en la placa, incluido la velocidad del ventilador.

![](/images/configure_temperature_02.jpg "Configurando Temperatura")

Asi que me dije, pues mira, no ha sido tan dificil como parecia.

Ingenuo de mi. **UnRAID** no hace nada para facilitar las cosas, sino todo lo contrario, las complica y cada vez, me estoy dando cuenta de ello.

Lo que pasa es que si reinicias **unRAID** todo se pierde y ya no detecta nada. Asi que tenia que buscar una manera de que esta configuración fuera permanente. Busque información sobre que hacer en estos casos en **unRAID** y un [hilo](https://forums.unraid.net/topic/18959-script-to-enable-sata-controllers-without-kernel-modification/) decia, que si pones un fichero ```bash``` en ```/boot/config``` el sistema lo ejecuta cuando se inicia. Pero no pasaba asi y si queria que los sensores volvieran a funcionar, tenia que volver a ejecutar las 3 instrucciones de nuevo.

En otro [hilo](https://forums.unraid.net/topic/143931-how-can-i-get-modules-to-load-on-reboot-automatically/), que si lo pones en ```/boot/custom/scripts``` tambien funcionaba, pero en mi caso, ninguno de los 2 casos era el correcto.

No veia la manera de como solucionar la cosa, hasta que recorde, que tengo un ```script``` que se ejecuta cada vez que se inician los arrays, que me instala las aplicaciones necesarias para hacer publicaciones en *Mastodon*, y pense, porque no, si ejecuto el ``bash`` cada vez que se inicia el array, tendria que funcionar sin ningun problema.

No tenia nada que perder, y lo probe. Y resulto perfecto. Ya podia visualizar correctamente la temperatura de la CPU, de la placa base y la velocidad del ventilador. Que más se podia pedir. Pero eso si, tener que recurrir a scripts para hacer esto, me parece un poco 😡

Asi se puede ver como queda actualmente:

![](/images/configure_temperature_03.jpg "Configurando Temperatura")

Un pasito más que he dado para tener mi servidor como a mi me gusta.

Ahora estoy pensando en conseguir que pueda enviar mis copias de seguridad de mi movil al servidor. He oido que hay un docker que se llama **Syncthing** que hace algo parecido, pero tengo que estudiarlo más.

Vosotros que servicios de docker teneis y que penseis que son indispensables de tener en un servidor???
#### Referencia
- [Resolve the issue of the ASRock Z370M-Pro4 motherboard not being able to obtain fan speed in Unraid](https://fun2ex.com/fixed-z370m-pro4-unraid-temperature-problem)
- [El complemento de detección de temperatura no puede detectar la velocidad del ventilador de la placa base, **web en chino**](https://forums.unraid.net/topic/115301-%E6%B8%A9%E5%BA%A6%E6%A3%80%E6%B5%8B%E6%8F%92%E4%BB%B6%E6%97%A0%E6%B3%95%E6%A3%80%E6%B5%8B%E5%88%B0%E4%B8%BB%E6%9D%BF%E9%A3%8E%E6%89%87%E7%9A%84%E8%BD%AC%E9%80%9F)
- [Script to enable SATA Controllers without kernel modification](https://forums.unraid.net/topic/18959-script-to-enable-sata-controllers-without-kernel-modification/)
- [How can I get modules to load on reboot automatically?](https://forums.unraid.net/topic/143931-how-can-i-get-modules-to-load-on-reboot-automatically/)

