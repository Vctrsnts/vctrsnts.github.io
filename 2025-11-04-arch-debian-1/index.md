# Hola Arch Linux. Adios Debian GNU/Linux - 1

Todas las despedidas son amargas. Siento decirlo, pero 😭 asi no, Debian GNU/Linux me has fallado. Nuestra relación de más de 25 años no tendria que haber acabado de esta manera. Tan abrupta y repentinamente.

<!--more-->

Pero asi ha sido, un desencuentro con respecto a [hyprland](https://hypr.land/), que entiendo que en **stable** esten los paquetes estables y a prueba de fallos (con lo que conlleva, versiones un poco antiguas), pero no puede ser que en **unstable** esta aun la versión **0.41.1** y, en cambio, la oficial (cuando estoy escribiendo este articulo) sea la **0.51.1**. Esto no esta bien...

Esto ha llegado como consecuencia de hacer el cambio de mi antiguo portatil (el tiempo le ha pasado factura), al que tenia en reserva, más información [aqui](/2023-09-11-substitutos-portatil) porque como tenia que empezar desde **cero**, queria empezar con lo nuevo:
- *Wayland*
- *Sway*

Además, si tienes un *Xeon* y la *Nvida Quadro P1000*, porque no le voy a sacar provecho a este hardware. Pero una cosa es la teoria y otra cosa muy distinta es la realidad. Ya lo entendereis.

En la [instalación](/2025-09-15-i3wm-sway-1) de *Wayland* y *sway* no tuve ningun problema, todo perfecto y como además ya venia usando *I3wm*, el [cambio](/2025-10-05-i3wm-sway-2) no fue nada traumatico. Hice unas mejoras que me permitia mejorar todo el ecosistema y que me gustaba resultaban muy positivas para todo el funcionamiento en si. Pero los problemas vinieron después. 🤯

Cuando [empece](/2025-10-15-i3wm-sway-3) a usar *sway* notaba que la CPU se calentaba un poquito, pero nada fuera de lo normal, el problema vino cuando usaba firefox, que la cosa ya se ponia un poco caliente 🔥, por no decir otra cosa. 

No le encontraba ningun sentido a ese comportamiento, antes con los mismos programas y con *I3wm*, eso si en *XOrg* y con un hardware más limitado, no tenia estos problemas, porque ahora si. Me puse a investigar y a preguntar si alguien podia saber el motivo de este comportamiento. Al final descubri que el problema era firefox y una configuración de *uBlock Origin* mucho más agresiva de lo normal y eso hacia que firefox necesitara más recursos, pero una asi seguia sin entender el porque de este comportamiento.

El siguiente paso y aprovechando que tenia la *Nvidia Quadro P1000*, era instalar los drivers propietarios de la grafica para que firefox tuviera aceleración por hardware y descargar la CPU de todo el trabajo que hacia (recordar que seguimos en Debian GNU/Linux). Todo tendria que haber sido facil y rapido, pero cuan equivocado estaba.

Los primeros intentos fueron infructuosos por no decir penosos. O no me iniciaba *sway* o todo seguia igual, sin aceleración por hardware. Asi que me fui a la raiz del problema, leer la documentación oficial de *sway* y de *Debian*, cosa que tendria que haber echo desde el primer momento, pero digamoslo claro, quien se lee la documentación o los manuales 😅 para ver si habia soporte para *Nvidia* y la manera de su configuración. Al final encontre la solución, si se le puede llamar asi; *sway* no tiene de momento planes de utilizar los drivers de *Nvidia*.

Pero bueno, si *sway* no los hacia servir, o mejor dicho, la compilación de *sway* en Debian no los usaba, podria buscar otro *tiling* que si los hiciera servir, asi que buscando, me encontre con [hyprland](https://hypr.land) que si que los utilizaba y con buenas opiniones por parte de la gente que lo usaba. Además, [atareao](https://www.youtube.com/watch?v=i2iSIvwy2U8) hablo de el en un video y le daba su bendición 😇.

Pues a ello que me puse, la instalación igual de sencilla que cuando la habia hecho con *sway* y la configuración lo mismo. Muy facil y si además, estas acostumbrado a la configuración de *I3wm* y *sway*, pues no tienes ningun problema. Lo unico que me faltaba era la instalación de los drivers, que es donde seguia teniendo los mismos problemas que con *sway*. Seguia sin saber como solucionar este dichoso problema 🤬. Cuando parecida que todo estaba correcto, *hyprland* no iniciaba indicandome que no encontraba ninguna GPU configurada 🥺 y cosas por estilo.

Aprovechando que tenia otro HDD, me propuse hacer una instalación limpia de Debian *GNU/Linux* junto con *Wayland* más los drivers de *Nvidia* y *Hyprland*. Entendiendo que no tendria que haber ningun problema, porque todo era limpio y sin interferencias de ningun paquete. *Pero mi gozo en un pozo*. No habia manera, seguia con los mismos problemas. *Wayland + Drivers Nvidia + Hyprland*.

Al final depués de mucho buscar, llegue a la conclusión de que era culpa de Debian y la versión que tenia de hyprland ( 0.41.1 ). Una versión muy antigua si la comparamos con la versión que hay actualmente ( 0.51.1 ). El consejo que me dieron era probar otra distribución, donde todo fuera más actual. Y que mejor que *Arch Linux* para estas pruebas.

Aqui fue donde me llegue una grata sorpresa. Porque habia oido que *Arch Linux* es complicada de instalar (al estilo de FreeBSD o Debian GNU/Linux en sus inicios), pero nada más lejos de la realidad. Aparte de algunas pequeñas diferencias, normales si cambias de distribución (*Arch Linux* y *Debian GNU/Linux*), y que además, son faciles de solucionar, juntalo con el script *archinstall* que facilita mucho la instalación. 

El resultado de todo ello, es que no tuve ningun problema en hacer la instalación. Eso si, tengo que reconocer que tuve alguna pequeña incidencia con respecto a la configuración de *GRUB* con otro S.O., pero aparte de esto y algunas cosas raras que me sucedieron, puedo decir que la instalación fue muy facil para ser la primera vez. 

Ahora, es donde si, iba a tener los verdaderos problemas con *Arch* y no era sino todo lo que rodeaba la instalación y configuración de los drivers de *Nvidia* para que *hyprland* y *firefox* puedan exprimir al 100% la potencia de la GPU.

De nuevo una grata sorpresa a la hora de la instalación y configuración de los drivers. Después de la instalación, hice unas cuantas verificaciones, para comprobar, si con lo facil que habia sido todo a la hora de la instalación de los drivers, estos, estaban activos y en funcionamiento y ver que todo era correcto.

Estas pruebas eran de 2 tipos, ver si los modulos estaban cargados:
```bash
usuari@archlinux:~/ lsmod | grep nvidia

nvidia_drm            143360  33
nvidia_uvm           3870720  0
nvidia_modeset       1929216  12 nvidia_drm
nvidia              111505408  308 nvidia_uvm,nvidia_modeset
drm_ttm_helper         16384  2 nvidia_drm
video                  81920  2 i915,nvidia_modeset
```
Y luego la otra prueba, que tambien era muy importante y era ver si el `modeset` de **nvidia_drm** estaba activo:
```bash
usuari@archlinux:~/ sudo cat /sys/module/nvidia_drm/parameters/modeset
Y
```
Aunque la prueba más importante de todas es la que me iba a encontrar al utilizar firefox y visualizar que es lo que estaba utilizando, si el driver de *Nvidia* o no. Mi sorpresa fue, que si que estaba usando el driver de *Nvidia* para la aceleracion por hardware. 😲 

Os puedo decir que lo note nada más iniciar firefox y acceder a cualquier video de youtube donde antes el ventilador de la CPU parecia el reactor de un avión, ahora ni se despeinaba. Ya tenia la prueba definitiva de que este era el camino, si queria sacarle todo a mi nuevo equipo.

Segui haciendo pruebas. Unas cuantas instalaciones para depurar los fallos, entender el funcionamiento de *Arch Linux*, eso si, tengo que decir que todos los fallos que encontre eran por culpa mia, por no configurar correctamente la *post-instalación*.

Ahora unicamente me queda realizar pruebas con todas las aplicaciones que uso normalmente y ver como se desarrolla todo, pero me parece que he encontrado la distribución que puede substituir a *<i class="fa-brands fa-debian"></i> Debian GNU/Linux</i>* y no es otra que *<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="14" height="16" style="vertical-align: text-bottom;"><path fill="currentColor" d="M11.39.605c-.998 2.47-1.77 4.57-3.14 6.89 1.48 1.57 3.3 3.4 6.27 5.46-3.19-1.31-5.36-2.63-7.05-4.01 -1.25 2.09-3.21 5.09-7.37 11.47 3.21-1.86 5.72-3.01 8.12-3.45 .2-.05.41-.09.61-.12.52.36 1.12.77 1.79 1.22-.6-.49-1.12-.94-1.6-1.36 2.09-.32 4.57-.26 7.53.77-2.95-1.82-5.02-3.49-6.55-5.07 2.13-.89 4.53-2.25 7.31-4.64-2.87 1.48-5.11 2.34-7.05 2.77 1.47-2.31 2.25-4.31 2.89-6.24z"/></svg> Arch Linux*.

Por eso el titulo a este articulo!! **Hola Arch Linux. Adios GNU/Linux**

Tengo intención de hacer un articulo más con la configuración que uso o y los *alias* que estoy usando tanto en *Arch* como en *Hyprland*. Pero eso para otro articulo.

{{< admonition note >}}
Eso si, mi corazon, seguira estando con *Debian GNU/Linux*
{{< /admonition >}}

#### Referencia
- [sway](https://swaywm.org)
- [hyprland](https://hypr.land)
- [Atareao - Hyprland un espectacular tiling con espectaculares efectos](https://www.youtube.com/watch?v=i2iSIvwy2U8)

