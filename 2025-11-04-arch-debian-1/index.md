# Hola Arch Linux. Adios Debian GNU/Linux - 1

Todas las despedidas son amargas, pero no pueden ser asi. Siento decirlo, pero 😭 Debian GNU/Linux me has fallado. Nuestra relación de más de 25 años no tendria que haber acabado de esta manera. Tan abruta y repentinamente.

Pero asi ha sido, un desencuentro con respecto a **hyprland**, que entiendo que **stable** esten anticuados, pero no puede ser que en **unstable** este la versión **0.41.1** y en cambio la oficial sera la **0.51.1**. Esto no esta bien...

<!--more-->

Todo ha llegado, porque al hacer el cambio de mi antiguo portatil, el tiempo le ha pasado factura, al que tenia en reserva, más información [aqui](/2023-09-11-substitutos-portatil) ya que tenia que empezar desde *cero*, queria empezar con lo nuevo:
- Wayland
- Sway

Además, si tienes un *Xeon* y la *Nvida Quadro P1000*, porque no le voy a sacar provecho a este hardware. Pero una cosa es la teoria y otra cosa muy distinta es la realidad. Ya lo entendereis.

En la instalación de *Wayland* y *sway* no tuve ningun problema, todo perfecto y como además, ya venia usando *I3wm*, el cambio no fue nada traumatico, además le hice unas mejoras que me permitia *sway* para la mejora de todo el ecosistema y que me gustaba mucho, pero eso si, los problemas vinieron después. 🤯

Cuando empeze a usar *sway* notaba que la CPU se calentaba un poquito, pero nada fuera de lo normal, el problema vino cuando usaba firefox, que la cosa ya se ponia un poco caliente 🔥, por no decir otra cosa. No le encontraba ningun sentido a ese comportamiento, porque antes los mismos programas y en I3wm, eso si en XOrg ( y con requerimientos más limitados ) no tenia estos problemas, porque ahora si. Me puse a investigar y a preguntar si alguien podia saber el motivo de este comportamiento. Al final descubri que el problema era firefox y una configuración de *uBlock Origin* más agresiva de lo normal y eso hacia que firefox necesitara más recursos, pero una asi seguia sin entender el porque de este comportamiento.

El siguiente paso y aprovechando que tenia la *Nvidia Quadro P1000*, era instalar los drivers propietarios de la grafica para que firefox tuviera aceleración por hardware y descargar la CPU de todo el trabajo que hacia ( recordar que seguimos en Debian GNU/Linu ). Todo tendria que haber sido facil y rapido, pero cuan equivocado estaba.

Los primeros intentos fueron infructuosos por no decir penosos. O no me iniciaba *sway* o todo seguia igual, sin aceleración por hardware. Asi que me fui a la raiz del problema, leer la documentación oficial de sway y de *Debian* para ver si habia soporte para Nvidia y la manera de su configuración. Al final encontre la solución, si se le puede llamar asi; *sway* no tiene de momento planes de utilizar los drivers de Nvidia.

Pero bueno, si *sway* no los hacia servir, o mejor dicho, la compilación de *sway* en Debian no los usabada, podria buscar otro *tiling* que si los hiciera servir, asi que buscando, me encontre con [hyprland](https://hypr.land) que si que los utilizaba y con buenas opiniones por parte de la gente que lo usaba. Además, [atareao](https://www.youtube.com/watch?v=i2iSIvwy2U8) hablo de el en un video y le dio su bendición.

Pues a ello que me puse, la instalación igual de sencilla que cuando la habia hecho con *sway* y la configuración lo mismo. Muy facil y si además, estas acostumbrado a la configuración de *I3wm* y *sway*, pues no tienes ningun problema. Lo unico que me faltaba era la instalación de los drivers, que es donde seguia teniendo los mismos problemas que con *sway*. Seguia sin saber como poder solucionar este dichoso problema 🤬. Cuando parecida que todo estaba correcto, *hyprland* no iniciaba indicandome que no encontraba ninguna GPU configurada 🥺 y cosas por estilo.

Aprovechando que tenia otro HDD, me propuse hacer una instalación limpia de Debian *GNU/Linux* junto con *Wayland* más los drivers de *Nvidia* y *Hyprland*. Entendiendo que no tendria que haber ningun problema, porque todo era limpio y sin interferencias de ningun paquete. *Pero mi gozo en un pozo*. No habia manera, seguia con los mismos problemas. *Wayland + Drivers Nvidia + Hyprland*.

Al final depués de mucho buscar, llegue a la conclusión de que era culpa de Debian y la versión que tenia de hyprland ( 0.41.1 ). Una versión muy antigua si la comparamos con la versión que hay actualmente ( 0.51.1 ). El consejo que me dieron era probrar otra distribución, donde todo fuera más actual. Y que mejor que *Arch Linux* para estas pruebas.

Aqui fue donde me llegue una grata sorpresa. Porque habia oido que *Arch Linux* es complicada de instalar ( al estilo de FreeBSD o Debian GNU/Linux en sus inicios ), pero nada más lejos de la realidad. A parte de las pocas diferencias que hay entre *Arch Linux* y *Debian GNU/Linux* y si lo juntamos con el script *archinstall* que facilita mucho la instalación, no tuve ningun problema. Alguna pequeña incidencia con respecto a la configuración de *GRUB* con otro S.O., pero a parte de esto y algunas cosas raras que me sucedieron, puedo decir que la instalación fue muy facil para ser la primera vez. 

Ahora, es donde creia que iba a tener los verdaderos problemas en *Arch*. Y esto no era otra cosa, que la instalación de los drivers de *Nvidia* y luego su configuración para con *hyprland* y *firefox* y conseguir hacer funcionar y exprimir al 100% la potencia de la GPU, que hasta ahora no habia sido asi.

De nuevo una grata sorpresa a la hora de la instalación de los drivers, hyprland. Después de la instalación, hice unas cuantas verificaciones, para validar que los drivers estaban activos y en funcionamiento y que todo era correcto.

Estas pruebas eran de 2 tipos, ver los modulos cargados ( `lsmod` ) donde podia ver lo siguiente:
```bash
usuari@archlinux:~/ lsmod | grep nvidia

nvidia_drm            143360  33
nvidia_uvm           3870720  0
nvidia_modeset       1929216  12 nvidia_drm
nvidia              111505408  308 nvidia_uvm,nvidia_modeset
drm_ttm_helper         16384  2 nvidia_drm
video                  81920  2 i915,nvidia_modeset
```
Luego otra que para mi era tambien muy importante y es ver si `modeset` de **nvidia_drm** esta activo:
```bash
usuari@archlinux:~/ sudo cat /sys/module/nvidia_drm/parameters/modeset
Y
```
Aunque la prueba más importante de todas es la que me iba a encontrar al utilizar firefox y visualizar que es lo que estaba utilizando, si el driver de Nvidia o no. Mi sorpresa fue, que si que estaba usando el driver de Nvidia para la aceleracion por hardware. 😲 

Os puedo decir que lo note nada más iniciar firefox y acceder a cualquier video de youtube donde antes la CPU se volvia loca, ahora ni se despeinaba. Ya tenia la prueba definitiva de que este era el camino, si queria sacar todo el provecho a mi nuevo equipo.

Segui haciendo pruebas. Unas cuantas instalaciones para depurar los fallos, entender el funcionamiento de *Arch Linux*, eso si, tengo que decir que todos los fallos que encontre eran por culpa mia, por no configurar correctamente la *post-instalación*.

Ahora unicamente me queda realizar pruebas con todas las aplicaciones que uso normalmente y ver como se desarroya todo, pero me parece que he encontrado la distribución con la que me voy a quedar.

Por eso el titulo a este articulo!!

**Hola Arch Linux. Adios GNU/Linux**

Tengo intención de hacer un articulo más con la instalación definitiva junto con la configuración que uso o alias que estoy usando tanto en *Arch* como en *Hyprland*. Pero eso para otro articulo.
---
- [sway](https://swaywm.org)
- [hyprland](https://hypr.land)
- [Atareao - Hyprland un espectacular tiling con espectaculares efectos](https://www.youtube.com/watch?v=i2iSIvwy2U8)

