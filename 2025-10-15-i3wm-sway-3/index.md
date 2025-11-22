# De i3WM ( X11 ) a Sway ( Wayland ) - 3

Pues llegamos al tercer y ultimo articulo donde explico la transición de **I3wm** a **Sway** y las sensaciones que estoy teniendo mientras lo uso y por ultimo mi conclusión final.

<!--more-->

## Compatibilidad con aplicaciones
Con respecto a la integración y compatibilitat de las aplicaciones que uso normalmente no he tenido ningun problema. Todo esta funcionando correctamente y sin problemas remarcables.

Las aplicaciones *diferentes* que por necesidad estoy usando, son las siguientes:
- *Waybar* para la barra de estado. Aqui si que tengo que reconocer que te puedes perder entre las diferentes posibilidades que tiene.
- *Wofi* como lanzador de aplicaciones o menu. Aqui tambien puedes perderte entre las diferentes posibilidades.
- *Mako* como gestor de notificaciones. Habia hecho pruebas con *sway-notification-center*, pero demasiadas cosas para solo mostrar notificaciones.
- *Swaybg* como gestor de fondos de pantalla. Simple y facil, sin muchas complicaciones.

Estas son las aplicaciones más destacadas, luego estan el resto de aplicaciones de uso diario, como por ejemplo *Firefox*, *Thunar*, *Claws-Mail*, *VirtualBox*, etc...

{{< admonition note >}}
Cuando digo que por necesidad, es porque las que usaba en *I3wm*, no estan para *Sway*.
{{< /admonition >}}

## Primeras impresiones tras el cambio
Las primeras impresiones han sido muy positivas, no hay nada que haya que remarcar, lo unico seria el gestor de sesiones, en mi caso, escogi **greetd**, que eso si, hay que tratarlo con cariño (ya explique en este [articulo](/2025-10-05-i3wm-sway-2) mi opinión al respecto), a parte de esto y como iba a usar las mismas aplicaciones que habia estado usando hasta ahora y que puedes encontrar en cualquier distribución de GNU/Linux, no he tenido ningun problema. 

Es más, es todo continuista, porque los ficheros de configuración que estaba usando hasta ahora sirven para *sway*. No tuve que hacer ningun cambio para que todo siguiera funcionando igual. A excepción del gestor de fondos de pantalla que como he dicho lo he cambiado, pero a parte de eso nada más.

A parte de algunas mejoras a la configuración y algunos cambios que hice para la mejor funcionalidad del mismo, todo seguia igual.

Estaba muy contento, porque todo seguia funcionando perfectamente y sobre todo y lo más importante, estaba usando *Wayland*, que se dice que es el futuro en el mundo de GNU/Linux.

## Rendimiento y consumo de recursos
Con respecto al rendimiento, hay alguna cosa que me escama y no para bien. Porque teniendo el equipo que tenia. más información [aqui](/2023-09-11-substitutos-portatil), no entiendo, porque el ventilador de la CPU esta siempre a pleno rendimiento y con temperaturas, en algunos casos sostenidos a 80º - 90º 🔥. Tengo que estudiar a ver cual es el problema, porque no es normal que con un equipo más potente que el portatil este más tiempo el ventilador en marcha que antes.  Ya os ire informando.

A excepción de esta pequeña eventualidad que tengo que investigar, el resto de opciones (ligereza del sistema, eficiencia, fluidez, etc) todo lo veia igual que anteriormente en el portatil. No es algo que se pudiera visualizar a simple vista. Seguramente que si hiciera mediciones más afinadas, descubriria cosas positivas, o a lo mejor, negativas, pero de momento, las sensaciones que tengo y que puede medir a simple vista 👁 son todas positivas. Nada que destaque sobradamente con respecto a *XOrg* y *I3wm*.

## Conclusión
De momento estoy muy contento con el cambio que he efectuado y creo que necesario, porque *XOrg* se habia quedado estancado, aunque por lo que he podido leer, estan intentado hacer mejoras, pero creo que sera muy dificil, porque, en mi opinión, se tendria que reescribir todo *XOrg* y asi aprovechar los nuevos conocimientos y el hardware nuevo que hay actualmente y para eso, ya esta *wayland*. En mi opinión, lo mejor seria dedicar todos los esfuerzos en mejorar *Wayland* y hacerlo anazar lo más rapidamente posible. 

Pero esto es lo que tiene que bueno el mundo del *Open Source*, que nunca puedes decir que algo esta acabado hasta que esta frio y no respira 😂

{{< admonition note >}}
Con esto acabamos la serie de articulos, sobre mi migración a *Wayland* y *Sway*. Pero os tengo que decir que se preparan sorpresas para un futuro y no muy agradables. Ya lo vereis.
{{< /admonition >}}

#### Referencia
- [Sway](https://swaywm.org)
- [Sway Installation - New Script](https://www.youtube.com/watch?v=sKOWqAm70jc)
- [Build a Minimalist Linux Desktop with SwayWM – Part 1](https://www.youtube.com/watch?v=XUdu3xx6iWs)
- [Build a Minimalist Linux Desktop with SwayWM – Part 2](https://www.youtube.com/watch?v=egh43A8Tlh8)
- [Build a Minimalist Linux Desktop with SwayWM – Part 3](https://www.youtube.com/watch?v=zzPJCMl11k4)
- [Linux & Theming - The Ultimate Guide](https://www.youtube.com/watch?v=jFz5gLqv-FM)
- [How I Set Up My Sway Window Manager on Debian 12](https://www.youtube.com/watch?v=e7bezUA6G4g)

