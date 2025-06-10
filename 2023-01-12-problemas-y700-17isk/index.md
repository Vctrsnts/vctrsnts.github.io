# Funcionamiento extraño con mi portatil (Ideapad Y700 - 17ISK)

Desde hace un par de dias, no se si desde que actualize la BIOS al portatil (Lenovo Ideapad Y700 17ISK, versión **CDCN54WW**), y me ha pasado una cosa muy extraña. El teclado en el momento de iniciarse el sistema ha dejado de funcionar.

<!--more-->

Así de repente, el teclado ha dejado de funcionar, sin razón aparente, pero también con un funcionamiento raro, porque las teclas de función (F1, etc...) si que funcionaban o hacer un `ctrl+alt+sup` también funcionaba. 

También podía acceder a la BIOS (en mi caso con `F2`), pero luego no podía desplazarme por las diferentes secciones de la BIOS ni tampoco seleccionar en `GRUB` el otro sistema operativo que uso (Windows 10). Pero lo más extraño (si es que puede haber algo extraño en todo esto) es que una vez que se cargaba el sistema operativo (tanto GNU/Linux como Windows) el teclado funcionaba correctamente y sin ningún problema.

Buscando por internet, lo único que encontraba, eran mensajes que hacían referencia a que una de las ultimas actualizaciones de la BIOS había producido este fallo, aunque también habían otros mensajes que decían, que el problema venia motivado por la [batería](https://forums.lenovo.com/t5/Serie-Z/Fallos-en-el-teclado-y-touchpad-Ideapad-700-15ISK/m-p/3656873), pero no tenia sentido, porque nunca había tenido anteriormente este problema hasta la actualización de la BIOS a la ultima versión. Así que lo único que, en mi caso, podía motivar este funcionamiento incorrecto del teclado, era la actualización de la BIOS.

Después de buscar versiones anteriores de la BIOS de mi portatil, Lenovo no lo pone nada fácil para encontrar los archivos, encontré una versión anterior a la que tenia instalada (CDCN53WW).

Lo único que me faltaba era poder acceder a Windows, pero también era extraño, con un teclado USB podía desplazarme por la BIOS y seleccionar el otro SO que tengo instalado. Inicie el `downgrade` de mi versión de BIOS a una anterior.

Parece que el problema se ha solucionado, porque de momento, no he vuelto a tener ningun problema con el teclado, puedo seleccionar correctamente el Sistema Operativo al que quiero acceder, así como puedo moverme por los diferentes apartados de la BIOS.

No se, una cosa muy extraña que me ha pasado, y no se si es un mensaje subliminal del portatil de que esta llegando a las ultimas.

Espero que no sea así, porque lo he tenido durante muchos años con un resultado excelente, pero no me gustaría perderlo, aunque si llega el día que tenga que deshacerme de el, tengo un par de substitutos en la recamara (que de eso tengo que hacer otro articulo).
#### Referencia
- [Foro Lenovo](https://forums.lenovo.com/t5/Serie-Z/Fallos-en-el-teclado-y-touchpad-Ideapad-700-15ISK/m-p/3656873)

