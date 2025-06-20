# Opinión Personal sobre unRaid - 1

Tal como explique en este [articulo](/2024-06-05-opinion-unraid) comente que iba a dar mi opinión con respecto a **unRaid** y aqui va el primero de los 2 articulos que tenia planeado escribir dando mi opinión con respecto a las cosas positivas y negativas.  y aqui la el primero de los 2 articulos. Vamos a hablar de las cosas positivas que le he encontrado.

<!--more-->

### Puntos positivos

#### Gestión de los discos duros
Seguramente esto es el punto más positivo que tiene *unRaid* y seguramente es el motivo por el cual, yo creo, que el 99,99% de la gente que lo usa, es por este motivo. Y dentro de este grupo me incluyo yo. 

Porque no he visto ninguna gestió de HDD tan eficiente como hace *unRaid* con referencia a los HDD's. Y esta gestión es el lo que lo hace diferente del resto de SO de NAS.

Por lo que he leido la gestión la hace a traves de **mergeFS** que en palabras mundanas es la unión de más de un HDD *como si fuera uno solo* junto con toda la gestión de los archivos que conlleva este sistema. Asi mismo, tambien tiene la gestión del HDD de paridad.

Yo lo resumo en como tener un sistema de RAID's con los consiguientes discos espejo, pero sin ser un RAID.

Lo unico que hay que tener en cuenta es la parte de la *paridad* del HDD de respaldo que has de tener, pero eso implica que, si todos tus HDD suman 32Tb de información o es el maximo a lo que podrias llegar, necesitas un HDD de esa capacidad, *incorrecto*, o más para cubrir esa paridad. Que si quieres no es obligatorio tenerlo, yo en mi caso no lo tengo, porque para las 4 cosas que tengo no me merece la pena, pero nunca se sabe.

{{< admonition note >}}
Tengo que hacer un inciso en este apartado que me ha corregido [Carlos M.](https://elblogdelazaro.org) con respecto a esta afirmación por parte mia. El ejemplo que me dice, es que si tienes 10 HDD de 4Tb cada uno, en total 40Tb, solo necesitaras un unico HDD de 4Tb para hacer el de paridad. 

Pero claro, esto si lo tienes configurado de esta manera o de alguna manera similar, pero en el caso, como tengo yo, que tengo 2 HDD, uno de 18Tb y otro de 16Tb, entiendo que tendre que tener un HDD de como minimo 18Tb. Que es aqui donde yo he cometido el error, pensando que tendrias que tener un HDD con la capacidad maxima (en mi caso, 32Tb). Fallo mio. 😰
{{< /admonition >}}

Asi mismo, tambien hay que tener en cuenta, que lo primero que se tiene que hacer una vez has puesto un nuevo HDD en el servidor, es hacer un *PreClear* de este mismo para comprobar la *salud* de HDD, pero hay que tener en cuenta una cosa que dependiendo de la capacidad del HDD puedes estar con el HDD conectado y haciendo las validacions correspondientes del *PreClear* durante unas 96 hores, esto es lo que me paso a mi y lo explique en este [articulo](/2024-03-07-cambiando-unraid). Que sino estas preparado pues de puede sorprender y asustar, pero si luego entiendes que lo hace para validar el HDD, pues no esta mal, porque si se tira, como fue mi caso, 96 hores y no le pasa nada al HDD, esta en buenas condiciones. Aunque nunca puedes dar un 100%, pero bueno, un 90% si.

Para eso, prefiero tener un buen sistema de copias de seguridad para salvaguardar la información que a mi si que me interesa no perder.

Repito, esta gestión de los HDD's es lo que da tanto valor a *unRaid*. Seguramente tu mismo te podrias hacer esta misma gestión en tu propio servidor, pero tendrias que configurar lo que no esta escrito. O no, nunca me he puesto a investigar como se hace. Porque a lo mejor son 4 ficheros y tienes la misma funcionalidad de ahora mismo tiene unRaid.

#### Gestión de la configuración del servidor
Otro de los puntos positivos que le he encontrado, es la facilidad en la configuración de todo el sistema una vez se ha instalado, que de esto hablare en los puntos negativos, porque...

Como iba diciendo, la configuración es muy sencilla he intuitiva lo que facilita la puesta en marcha del sistema. Aunque si quieres, puedes decir mucho más tiempo para una configuración más refinada del sistema, modificando parametros, pero eso ya te llevaria más tiempo y tendrias que estar muy seguro y conocer el hardware de tu servidor para hacer eso.

#### Gestión de la información (graficas) que genera el servidor
El ultimo punto positivo para mi, es la informació (graficas, metricas) que te ofrece *unRaid* de tu sistema en la pantalla principal. Se que hay otras aplicaciones de las que podrias extraer más información (netdata, grafana, etc...), pero para empezar y al nivel que mi me interesa tengo más que suficiente. Ya digo que mi servidor no es como los servidores de la Nasa, sino que es mi servidor personal. Por eso mismo, digo, que con la información que por defecto me ofrece ya tengo más que suficiente.

Tambien tengo que decir, que al servidor, le tengo instalado el docker de [glances](https://nicolargo.github.io/glances) para asi desde mi pagina principal de mi dashboard ([homepage](/2024-06-03-usando-homepage-2)) visualizar la información sin tener que estar accediendo todo el rato al servidor. Y si veo algo extraño, entonces si que accedo al servidor, para visualizar lo que pasa.

### Conclusión
Y con esto, hemos acabado los puntos positivos para mi. Repito, para mi. Es mi opinión personal. Seguramente vosotros tengais muchos más o menos, pero estos son los mios 😎

Eso si, tengo que decir que el punto positivo más importante que tiene *unRaid* es toda la gestión que hacer de los HDD. Pero claro, no podemos decir que me gusta una cosa, por el solo hecho de que tenga una unica cosa positiva. Para mi modo de ver, lo positivo y lo negativo tiene que estar más o menos equilibrado o tirando más hacia el lado de lo positivo, pero en mi caso, esto no es asi, le encuentro más cosas negativas que positivas y esto lo podreis ver en el siguiente articulo.
#### Referencia
- [Glances](https://nicolargo.github.io/glances)

