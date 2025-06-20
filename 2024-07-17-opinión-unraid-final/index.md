# Opinión Personal sobre unRaid - Final

Como primer articulo de este nuevo año, os pongo el articulo final que me faltaba sobre **mi opinión personal - final** con respecto a **unRaid**, pero he estado un poco liado y por eso me he retrasado un poco, pero ahora vamos al articulo final con respecto a lo que **yo** pienso.

<!--more-->

Recordad, que veniamos de estos 2 articulos sobre **unRaid**:
- [Opinión Personal sobre unRaid - 1](/2024-06-13-opinion-unraid-1)
- [Opinión Personal sobre unRaid - 2](/2024-06-23-opinion-unraid-2)

Donde hablaba de lo bueno y de lo malo que yo le he encontrado y si no me han matado los *fanboys* de unRaid, voy a dar mi opinión final sobre él.

Lo unico bueno que yo le veo es toda la gestión de los HDD que hace el sistema operativo. En pocas palabras, **MergeFS** que creo que es la manera que usa *unRaid* para la gestión de los HDD es una maravilla. Tambien esta toda la gestión y toda la información que puedes extraer del sistema ( hardware, HDD, network, temperatura, etc... ) pero ya esta. Y claro, en mi caso, me gustaria obtener, no se más cosas de este sistema que te lo **venden** como *el màs mejor de todos* los Sistemas Operativos para tener tu propio NAS en casa.

{{< admonition info >}}
Pero os digo una cosa, si yo puediera replicar esta funcionalidad en cualquier servidor que yo pudiera tener, dejaria de lado *unRaid* y lo haria, pero entiendo que configurar correctamente **MergeFS**, no debe ser tan facil como parece. Repito, que es lo unico positivo que le veo a todo el sistema.
{{< /admonition >}}

A parte, de que en algunos momentos, todo el sistema me decepciona un poco, que puede ser porque me falte investigar más todas las funcionalidades / plugins que hay disponibles para instalar, pero eso tambien es un problema que yo le veo. Hay tantas cosas, tantos plugins, tanto de todo que puedes perderte en este mundo y salir de el sintiendo que has perdido el tiempo. 

Porque si, hay muchas cosas que te pueden facilitar la vida, pero que tienes que conocerlas y no hay ningun sitio donde explique todas las posibilidades. Muchos me direis que esta la pagina de plugins de *unRaid* pero de tantas cosas que hay, te pierdes. Es lo mismo que se dice de *Debian GNU/Linux*. Que es una de las distribuciones con mayor numero de paquetes. Que por un lado es beneficioso, pero por otro lado de tanto que hay te puedes perder en tantos paquetes y no puedes sacar todo el potencial que da. Pues opino lo mismo de *unRaid*, tiene tantas cosas que, de tantas que tienes no puedes aprovecharlas.

Otra cosa, que no me parece que sea correcto, es que usen el SO *Slackware* como base para *unRaid*. Habiendo de mejores, *es mi opinión personal*, no entiendo, porque usan este, me lo tendrian que explicar. Seguramente tendran algun motivo, pero no se me ocurre cual podria ser. Y aqui si que no voy a meterme de que si *Debian, Ubuntu, Gento, Arch, etc*, pero algun motivo tiene que haber para esta elección.

Para finalizar y que es lo que me parece la peor manera de trabajar que se puede usar, es que todo el **SO** este instalado en un *USB*.

Que alguien me explique el motivo de esto. Seguramente me diran de que el **SO** no esta instalado realmente en el USB, sino que cuando se inicia el sistema, se carga el SO del USB a la memoria ram del servidor para asi ganar en velocidad. Ni las Raspberrys funcionan ya de esta manera. 

Al principio, y eso que tengo todos los modelos a excepción de la RPI5, si que funcionaban de esta manera, pero habia un monton de problemas porque no estaban pensadas para ese funcionamiento y la gente se las ingenio para dejar unicamente en la SD el sistema de inicio (que no eran más que 3 ficheros) y el resto en el HDD y con eso se ganaba seguridad de que no estropeabas la SD a menos que estuvieras reiniciando el sistema cada 2 x 3. 

Ahora me vienen los de *unRaid* y me venden la moto de que este es el mejor sistema de funcionamiento. Como que los USB no se diferencian mucho de las tarjetas SD. Vale no rebentaran cuando hayas echo 1.000 escrituras, sino que rebentaran cuando hayas echo 10.000 y entonces todo a tomar viento. 

Tanto cuesta, y más ahora que una disco SSD o un nvme estan tirados de precio. Puedes tener 300 HDD conectados a *unRaid* haciendo de array, pero no puedes tener uno que haga de sistema operativo, con todo los beneficios que con ello comporta. Que alguien me lo explique, porque no lo entiendo.

Para acabarlo de rematar, pero esto es más cuestion a nivel de empresa, todo el follon que montaron con el tema de las licencias, *que si ahora son vitalicias, pues ahora ya no, hay perdon, que nos hemos equivocado, nos referiamos a las nuevas, las antiguas seguiran como estaban*. 

Esto se parecia al *camarote de los hermanos marx*. Pero claro, hay que entender que son una empresa y que el aire no paga a los empleados. Aqui se equivocaron tanto la empresa como los usuarios. Unos por decir algo que luego no iban a cumplir y los otros por creerse todo lo que les dicen. O los usuarios que se piensan que lo que digan las empresas van a misa y nunca mienten ni engañan? 

Porque si piensan de esta manera, ya puedes empezar a dejar de usar cualquier cosa, porque si te pones a pensar, en cualquier momento, algo que la empresa X dijo que seria para toda la vida, luego va y lo cambia porque le va mejor y da igual lo que dijera en su momento. A mi me interesa, pues lo cambio y si ha alguien no le gusta, ya sabe donde esta la puerta. Y ejemplos de este tipo hay a patadas. O no te ha pasado nunca? Porque yo conozco algunos que primero prometieron **el oro y el moro** y luego donde **dije digo, digo diego**.

{{< admonition note >}}
Hasta aqui mi opinión personal con respecto a *unRaid*. Como veis es un pequeño resumen de todo lo que ya habia comentado en los 2 anteriores articulos, las cosas buenas y las cosas malas. 

Vosotros, seguramente pensareis de una manera diferente a la mia o no, pero en eso consiste ser un a persona. Que cada uno piensa de una manera diferente. 

Nunca se sabe, a lo mejor mi manera de ver a *unRaid* cambia, porque voy descubriendo cosas nuevas que hacen que mi visión vaya cambiando. No consiste en eso el aprender?
{{< /admonition >}}

Eso si, tengo que dar las gracias a **Carlos M.** de [El blog de Lázaro](https://elblogdelazaro.org) porque gracias a el, cada dia voy descubriendo cosas nuevas sobre **unRaid** que van haciendo que poco a poco, mi opinión vaya cambiando, no todas, pero algunas si. **Gracias Lazaro 👏**
#### Referencia
- [Integrar métricas de Unraid en Homepage](https://elblogdelazaro.org/posts/2024-12-02-integrar-metricas-de-unraid-en-homepage)
- [Backrest, backups en nubes S3](https://elblogdelazaro.org/posts/2024-07-29-backrest-backups-en-nubes-s3)
- [Restic: Backups bien hechos](https://elblogdelazaro.org/posts/2019-11-28-restic-backups-bien-hechos)

