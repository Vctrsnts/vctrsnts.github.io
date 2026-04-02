# Tengo hard-hopping

Os preguntareis a que viene este articulo, porque que es eso de **hard hopping**. 

Seguramente solo conoceis el **distro hopping** que se conoce como el impulso de cambiar frecuentemente entre distintas distribuciones de GNU/Linux. Pero eso de **hard hopping** que es?

<!--more-->

Como tal, esta palabra, seguramente no existe, me la acabo de inventar, pero yo lo describro como el *impulso de cambiar frecuentemente de hardware o equipo informatico sin llegar a estar contento con lo que se tiene*, y eso es lo que me ha sucedido ultimamente, hasta conseguir lo que tengo actualmente y que cumplimenta todas mis espectativas, aun se podria mejorar un poco, pero el ansia ya no es tan grande.

Si leeis alguno de mis articulos, recordareis que habia estado durante mucho tiempo con un [portatil Lenovo](/2023-01-12-problemas-y700-17isk), pero que fallecio honorablemente después de un servicio impecable. Después pase a un [ThinkCenter m910x](/2023-09-11-substitutos-portatil) al que le habia puesto una grafica *Nvidia P1000* junto con un *Xeon* y *Arch Linux*. 

Este cambio pensaba que seria el definitivo, pero el sonido del ventilador siempre en funcionamiento del *Xeon*, me molestaba un poco, por no decir nada fuera un monton 🤯. Ya sabia a lo que me enfrentaba al poner esta CPU, pero no pensaba que seria tanto, incluso habiendole hecho *undervolt* y cambiarle la tapa por una para mejorar el flujo de aire en todo lo posible, pero ni aun asi, y si además añadimos que estaba usando **sway**, **wayland** y **Firefox**, el cual, la gestión de la GPU con *Nvidia* no es muy buena. A eso, le añades, que te cae en las manos, una oferta muy tentadora por un **m920x** con GPU AMD ya incorporada, pues dime tu que hubieras hecho 😉.

Pero sabes esa sensación que se te queda en el cuerpo, que aun te falta algo, pues asi me sentia. Asi que sin quererlo, no se si fue la suerte, o que estaba predestinado, me volvio a caer entre manos una oferta que no podia rechazar, esta vez era un **ThinkCenter m90q Gen3** con las siguientes especificaciones:
- CPU → Intel i5-12500
- RAM → 16 GB
- NVME → 256Gb

Siento decirlo que me tire de cabeza a por el. Sin pensarlo. Directo como una polilla a la llama.

Ya me podeis ver, aun sin haber desembalado el **m920x** y ya tenia entre manos nuevo equipo, pero esta vez, queria hacer las cosas bien. Queria ponerle una GPU que no me diera ningun problema y que fuera 100% compatible con GNU/Linux y que me permitiera jugar a un par de juegos (a los que estoy viciado y que no requieren mucho hardware). 

Esas premisas que me habia *auto - impuesto*, solo se podian conseguir con una GPU AMD que se llevan espectacularmente bien con GNU/Linux, o eso es lo que comentan y que tengo que dar fe de que es cierto.
{{< admonition tip >}}
Estar en el canal de **HomeLabs** es malo para el bolsillo, y si además lo unes a que un compañero te da consejos de compra para wallapop, pues tienes el coctel explosivo perfecto.

Este compañero, no es ni más ni menos que **@JuanFra**, que me aconsejo de que para los requisitos que yo necesitaba, me podia ir bien una Grafica **AMD Radeon PRO WX4100** que estaban a buen precio (ahora ya no). 
{{< /admonition >}}
Buscando, buscando, encontre en **eBay** una que estaba bien, y a ella que me fui, pero ya os aviso que no es oro todo lo que reluce. Bueno, si que es oro, pero tienes que pulirlo mucho 🫣

Os preguntareis a que viene esto, pero si seguiis leyendo, lo entendereis.

![](/images/WX4100.jpg "AMD Radeon PRO WX4100")

Al final, me llego la GPU en perfectas condiciones y que funciona correctamente en las pruebas que habia hecho en el *m920x*, pero el disguto vino cuando la puse en el *m90q*, que no se veia nada al iniciar el equipo, hasta que no se iniciaba el SO (Arch o Windows). Después todo funcionaba perfectamente, pero al iniciar el equipo, solamente se veia una pantalla en negro y sin posibilidad de acceder a la BIOS ni nada. Como se dice, todo fundido en negro.

Después de mucho investigar, acabe descubriendo que el problema era que la versión  **UEFI** que tenia la grafica era muy antigua y no era aceptada por el *m90q* y eso la hacia incompatible hasta que no tomaba el control el SO. Ahora me encontrada con un equipo que se ajustaba a todas mis necesidades, pero con el problema de versión de **UEFI**.

Llegados a este punto, tenia 2 opciones:
- Comerme la GPU y comprar una nueva.
- Hacer una operación a corazon abierto a la grafica y actualizar la versión de **UEFI** con 2 posibles resultados:
  - Obtener un pisapapeles.
  - Actualizar sin problema la versión de *UEFI*.

Los pasos que hice fueron los siguientes (junto con las aplicaciones que use):
- **AMDVBFlash** → leer/escribir BIOS
- **GOPupd** → actualizar GOP
- **UEFITool** → comprobar si todo ha ido correctamente.
```
### 1. Backup (OBLIGATORIO)
amdvbflash -s 0 backup.rom

### 2. Actualizar GOP
GOPupd.bat backup.rom

Genera: `backup_new.rom`

### 3. Verificar

* Abrir `backup_new.rom` en UEFITool
* Confirmar que el GOP está y es más nuevo

### 4. Flashear

amdvbflash -p 0 backup_new.rom

(Si falla → usar `-f` con cuidado)

### 5. Recuperación (si algo va mal)

(usando iGPU u otra GPU)
amdvbflash -p 0 backup.rom
```

Si lo tuviera que resumir en una sola frase, seria la siguiente:
{{< admonition note >}}
 **Extraes BIOS → actualizas GOP → verificas → reflasheas → pruebas (sin garantía de éxito).**
{{< /admonition >}}
Al final el resultado fue positivo, porque logre actualizar la **UEFI** de la grafica sin ningun problema, pero eso si, con muchos sudores, pero todo salio muy bien.

Ahora el equio que tengo es:
- ThinkCenter m90q
- CPU i5-12500
- GPU AMD Radeon PRO WX4100
- 32GB de RAM
- 2 NVME:
  - 1 para el Arch Linux
  - 1 para Windows y los 3 juegos que uso.
  
Tambien os tengo que decir, que como no, he cambiado el anterior teclado *logitech K310* que tenia, por uno de la marca **KEYCRHON**, en especial el *Keychron K13 PRO*. El cambio fue brutal, el tacto a la hora de escribir, su uso diario, etc... Todo era diferente a lo que estaba acostumbrado.

![](/images/K13-PRO.jpg "KeyChron K13 PRO")

Pero tenia una pega, que no lo note, y que puede parecer una tonteria, pero echaba en falta las teclas de *home, end, page up y page down*. 

Llamarme loco, pero no podia estar sin ellas. Al **K13 PRO** se le podia añadir una nueva capa (se pueden programar todas las teclas, para que en base a una combinación hagan una funcion diferente), pero ni aun asi, me sentia comodo. Asi que al cabo de 2 semanas de tener el *k13 PRO* di el salto a un simple y basico **Keychron K3 V2**, y ahora si, que estoy en mi salsa. 

Es más pequeño, menos configurable por no decir nada configurable que el *K13 PRO*, pero este si que incorpora las 4 teclas que me traian amargado. Tampoco tiene el *numpad*, pero si os digo la verdad, llevo 1 mes con este ultimo y no las hecho de menos. 

A lo mejor mucha gente piensa que he salido perdiendo, pero yo creo que no. Estoy a gusto usando el *K3 V2*. Que podria ir por el *K3 PRO o MAX*, podria ser, pero ahora mismo, estoy en mi salsa (tengo que pensar que hacer con el K13 PRO).

![](/images/K3-V2.jpg "KeyChron K3 V2")

Después del cambio de GPU, el cambio de teclado, se podria decir que estoy servido y que no hace falta ningun cambio más, pero el **hard-hopping** es un problema muy grave, que no se si tiene cura.

Ahora estoy en busca y captura de una GPU nueva, la *AMD Radeon W6400* para substituir la *AMD Radeon PRO WX4100*, siempre que encuentra una a buen precio, pero como dice **@JuanFra**, eso es cuestion de tiempo.

#### Referencia

