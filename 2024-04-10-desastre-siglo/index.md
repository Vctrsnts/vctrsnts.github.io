# El desastre del siglo

Si recordais este articulo [Por fin VPS para hacer pruebas](/2023-09-24-VPS-pruebas) y luego leeis lo que me ha pasado, entedereis porque titulo este articulo como lo titulo.

**Porque no es para menos**.

<!--more-->

Como dije en el articulo que os he comentado, desde hace un tiempo, consegui, al fin, una instancia gratuita de *Oracle Cloud* que me servia para hacer pruebas y tener algun docker activado (proxy, searxng, umani, etc...) y que siempre va bien que este en otro sitio, porque nunca se sabe y más si a alguien se le ocurre la idea de **bloquear Telegram en Espanya**.

Esta instancia aunque era de **ARM** pero estaba muy bien equipada:
- 24Gb de RAM
- 50Gb de HDD
- SO. Ubuntu

Lo tenia todo, pero un buen dia, se me ocurrio la brillante idea, que tal como lo tenia montado en ese momento, todo en una sola maquina, era tirar los recursos en 4 contenedores que nunca iban a saturar al equipo. Entonces dije, **porque no hacer 2 maquinas** y tenemos más posibilidades. Y fue lo que hice, pero antes de todo ello, apague la maquina que tenia activa y la borre, para asi poder crear otra nueva a mi gusto. Que estupidez hice en ese momento, si lo llego a saber...

Y cuando ya lo tenia todo preparado para crear una nueva instancia pero más reducida, aqui vino el desastre, era imposible crear una nueva. No habia manera, ni dejando que pasara unas horas ni unos dias. Siempre obtenia el mismo mensaje, **No hay recursos**, lo que si que podia hacer, era crear una instancia en AMD64, pero claro con la limitación de **1Gb de RAM**.

En ese momento, fue cuando saltaron todas mis alarmas. Con otra email que tengo, intente crear una nueva cuenta, pero esta vez en otro sitio, porque no hay posibilidad de cambiar de sitio las instancias gratuitas, pero me encontre en el mismo problema, **no hay recursos**. Asi que ahora mismo, me encuentro sin poder usar ninguna instancia de Oracle. 

Por ese motivo me he dado de baja (con lo que me costo conseguirlo), para ver si cuando haya pasado unos meses, puedo volver a intentar darme de alta de nuevo.

Pero de momento, ahora estoy usando una instancia de **Google Cloud**, se que no es lo mismo, porque solo tengo a mi disposición:
- 1Gb de RAM
- 30Gb de HDD

Pero bueno, menos es nada.

Lo que si que estoy pensando, es en un futuro, alquilar un VPS un poco decente, y no tener que preocuparme de cualquier problema. Pero claro, lo que me gustaria seria un VPS que no fuera muy caro, porque no quiero nada por el estilo de Oracle (RAM, CPU, HDD), pero tampoco quiero tan limitado como tengo ahora mismo con Google. Pero a ver donde encuentro algo asi y que esa economico.

Si alguien de los que me lee, puede aconsejarme algun VPS, le estare muy agradecido.
#### Referencia

