# Instalar Qemu y VirtManager en Arch - 1

Este articulo es más un resumen o unos apuntes para mi, de como se hace la instalación de **Qemu** y **VirtManager** en **Arch**, basado en este [video](https://www.youtube.com/watch?v=HN-krqqblOA) que podeis encontrar en **Youtube**.

Nunca se sabe si puede desaparecer o no, pero yo me lo guardo, por si acaso.

<!--more-->

{{< admonition note >}}
Antes de empezar lo primero es agradecer a [Ruben](https://www.youtube.com/@Ruben-Linux) por este excelente guia de instalación.
{{< /admonition >}}

Desde hace mucho tiempo, he estado usando [VirtualBox](https://www.virtualbox.org), pero ultimamente con tanto cambio de equipo, habia empezado a notar, que la temperatura de la CPU (incluso con un **Xeon**) era un poco alta, por no decir, más de lo normal, a la hora de utilizar este programa para virtualizar. 

Desde hace un par de semanas, supongo que como tengo **Arch**, me voy fijando más en todas las noticias que hacen referencia a este sistema, habia escuchado a miembros del canal de telegram de [atareao](https://t.me/atareao_con_linux/37878) donde se comentaba, que habian notado una gran mejora a la hora de usar **Qemu** en comparación de **VirtualBox**. 

Me puse a buscar información de que habia de cierto en esto, además, de buscar tambien, como se realiza la instalación en **Arch** y me encontre este estupendo [video](https://www.youtube.com/watch?v=HN-krqqblOA), donde esta explicado todo perfectamente y muy facilmente de seguir. Pero como ya he dicho antes, me apunto las instrucciones, porque nunca sabes que puede pasar.

{{< admonition note >}}
Lo que si que puedo decir, es que pasadas ya unas cuantas semanas que llevo usando *Qemu*, puedo decir que si que se hay una diferencia en el consumo de recursos entre *Qemu* y *VirtualBox*.
{{< /admonition >}}

Después de esta pequeña introducción, ahora pasamos a lo más importante, como se realiza la instalación.

### Capacidad de virtualización de nuestra CPU
Con esta instrucción, sabemos el numero de nucleos que tiene nuestro procesador con capacidad de virtualización. A mayor numero, mejor nos ira.
```bash
usuari@archlinux:~/ grep -Ec '(vmx|svm)' /proc/cpuinfo  
```

### Instalación
Ahora viene la parte más importante, la instalación en si de **Qemu** y **VirtManager** más todo lo necesario, yo uso la siguiente instrucción:
```bash
usuari@archlinux:~/ update
usuari@archlinux:~/ install virt-manager virt-viewer qemu vde2 iptables-nft nftables dnsmasq bridge-utils swtpm
```
Aqui hay que tener en cuentas 2 cosas:
- Yo tengo un alias para la actualización de paquetes - **update** (`sudo pacman -Syy`) y otra para instalación - **install** (`sudo pacman -S`).
- A la hora de instalar **qemu**, os pedira si queris instalar **1) qemu-base**, **2) qemu-desktop** o **3) qemu-full**, en mi caso he probado la opción **2** y la opción **3** y al final escogi la opción **2**. Pero es mi elección.
- Tambien os puede aparecer un mensaje donde indique `iptable-nft y iptables estan en conflicto. Quitar iptables [s/N]`, se tiene que escoger la opción **S**.

Tambien se puede dar el caso, de que haga falta instalar los siguientes paquetes:
```bash
usuari@archlinux:~/ install openbsd-netcat demicode iptables libguestfs 
```
Pero a mi no me hizo falta instalarlos.

### Configuración de libvirt
Ahora procedemos a la modificación del archivo `/etc/libvirt/libvird.conf` de la siguiente manera:
```bash
usuari@archlinux:~/ sudo nano /etc/libvirt/libvirtd.conf
```
Buscamos las opciones `unix_sock_group` y la opción `unix_sock_rw_perms` y quitamos la almohadilla **#**, quedando de la siguiente manera:
```bash
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```

### Añadimos nuestro usuario al group kvm y libvirt
No hace falta explicar mucha cosa de este paso
```bash
usuari@archlinux:~/ sudo usermod -a -G kvm,libvirt $(whoami)
usuari@archlinux:~/ newgrp libvirt
```

### Activamos el servicio
No hace falta explicar mucha cosa de este paso
```bash
usuari@archlinux:~/ sudo systemctl enable libvirtd.service
usuari@archlinux:~/ sudo systemctl start libvirtd.service
usuari@archlinux:~/ sudo systemctl status libvirtd.service
```
En la ultima instrucción, lo unico importante, es que ponga **active running**, si es asi, todo esta funcionando correctamente. Sino, es que tenemos un problema.

### Configuración de qemu.conf
Ahora pasamos a configurar el archivo `/etc/libvirt/qemu.con`:
```bash
usuari@archlinux:~/ sudo nano /etc/libvirt/qemu.conf
```
Donde tenemos que buscar las opciones `user` y `group` y tenemos que poner nuestro nombre de usuario. Esto sirve, para que nuestro usuario pueda funcionar correctamente con **qemu**, quedando de la siguiente manera:
```bash
user = "your username"
group = "your username"
```

### Reiniciar el servicio libvirtd
No hace falta explicar mucha cosa de este paso
```bash
usuari@archlinux:~/ sudo systemctl restart libvirtd
```

### Crear red para qemu
Lo que hacemos a continución, es crear una red, para que la podamos usar en nuestras virtualizaciones que llamamos **default**:
```bash
usuari@archlinux:~/ sudo virsh net-autostart default
```

### Reiniciar el sistema
No hace falta explicar mucha cosa de este paso
```bash
usuari@archlinux:~/ sudo reboot
```
A continuación, voy a explicar como se tiene que activar la funcionalidad de poder virtualizar una maquina dentro de otra maquina que ya estamos virtualizando. No le encuentro ningun sentido a esta opción, porque es consumir recursos de un sistema virtualizado para virtualizar otro 🤨.

### Habilitar virtualización anidada
La función de virtualización anidada le permite ejecutar máquinas virtuales dentro de una VM. Habilite la virtualización anidada kvm_intel / kvm_amd habilitando el módulo del kernel como se muestra.
```bash
usuari@archlinux:~/ sudo modprobe -r kvm_intel
usuari@archlinux:~/ sudo modprobe kvm_intel nested=1
usuari@archlinux:~/ echo "options kvm_intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf
```
Para verificar que funciona correctamente, se hace a traves de la siguiente instrucción:
```bash
usuari@archlinux:~/ systool -m kvm_intel -v | grep nested
usuari@archlinux:~/ cat /sys/module/kvm_intel/parameters/nested
```
En el caso de que tengamos un procesador **AMD** en vez de **Intel**, lo unico que se tiene que hacer es substituir **kvm_intel** por **kvm_amd**, quedando de la siguiente manera:
```bash
usuari@archlinux:~/ sudo modprobe -r kvm_amd
usuari@archlinux:~/ sudo modprobe kvm_amd nested=1
usuari@archlinux:~/ echo "options kvm_amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf
```

Espero que esto os sirva de ayuda. Ya os digo que a mi si, porque este articulo lo guardare como oro en paño 😀.

#### Referencia
- [Ruben](https://www.youtube.com/@Ruben-Linux)
- [Instalación de Qemu, KVM y Virt Manager en Arch Linux](https://www.youtube.com/watch?v=HN-krqqblOA)
- [VirtualBox](https://www.virtualbox.org)

