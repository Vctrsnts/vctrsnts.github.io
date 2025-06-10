# Deshabilitar tarjeta NVIDIA Optimus en Debian GNU/Linux

Después de mucho buscar al final, pude encontrar un sitio ~~[aqui](https://pedrobonilla.blogspot.com.es/2011/11/deshabilitar-tarjeta-nvidia-en-sistema.html)~~ donde te explicaba como desactivar la tarjeta grafica Nvidia de mi portatil Dell XPS 15. Estaba ya cansado de escuchar el ventilador funcionando todo el rato por culpa de una tarjeta grafica que no utilizaba. Así que lo pongo a continuación porque así se difunde más facilmente y lo guardo para mi como apuntes...

<!--more-->

El siguiente procedimiento sirve para deshabilitar (o desactivar) una tarjeta NVIDIA cuando contamos con un sistema híbrido de gráficos, es decir, cuando contamos con dos tarjetas de video. El objetivo es reducir el consumo de energía en Linux, ya que no existe un buen soporte para gráficos híbridos en este sistema operativo (ni existirá en el corto plazo, aparentemente).

En mi caso, poseo una laptop Dell XPS 15 con las siguientes dos tarjetas de video:
- Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller
- NVIDIA® GeForce® GT 540M 2GB

La tecnología Optimus se encarga de administrar estas dos tarjetas, activandolas o desactivandolas según sea necesario (la NVIDIA solo es activada cuando estamos haciendo uso intensivo de gráficos en 3D). De esta forma, se minimiza el consumo de energía.

Solo hay un problema: ¡No existe Optimus para Linux! Esto conlleva a que el sistema utilice las dos tarjetas al mismo tiempo (consumiendo tu batería en minutos).

La solución temporal es desactivar la tarjeta NVIDIA cargando un módulo (desarrollado por la comunidad) en el kernel. Los pasos son los siguientes:
```bash
# instalamos el paquete git si no lo tenemos ya
usuari@debian:~$ sudo apt-get install git
usuari@debian:~$ git clone https://github.com/mkottman/acpi_call.git
usuari@debian:~$ cd acpi_call

# ahora procedemos a compilar el codigo
usuari@debian:~$ make
# procedemos a cargar el  modulo en el kernel
usuari@debian:~$ sudo insmod acpi_call.ko

# damos permisos de ejecución al fichero
usuari@debian:~$ chmod 755 test_off.sh
# y desactivamos la tarjeta NVIDIA
usuari@debian:~$ ./test_off.sh
```

Si aparece algún mensaje `works!`, entonces todo ha funcionado correctamente.

Espero que esto os ayuda tanto como a mi. Así mismo, agradezco al autor original de este documento .
#### Referencia

