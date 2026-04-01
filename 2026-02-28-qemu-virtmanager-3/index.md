# Instalar Qemu y VirtManager en Arch - 3

Aqui va el tercero y ultimo articulo con respecto a **Qemu** y **VirtManager**, pero en este caso, lo explico desde la manera de usarlo como cliente de una maquina creada en **unRaid** y que podemos usar como si estuviera en local que es mi caso.

<!--more-->

En este caso, tal como he dicho al principio, es conectar la maquina virtual que tengo creada en mi servidor unRaid y poderla usar en mi equipo local, como si fuera otra maquina más, pero ubicada en otro sitio. A continuación os explico como lo hice y por si os puede servir de ayuda.

Antes de empezar a explicar todo el proceso, teneis que saber, que **unRaid** utiliza **KVM + libvirt** para la creación de las maquinas virtuales que es muy parecido a **QEMU + VirtManager** en GNU/Linux, con esto se consigue que desde mi equipo con **Arch Linux** me pueda conectar al un servidor **unRaid**, como el mio y poder usar las maquinas virtuales de forma remota, manteniendo la gestión principal desde **unRaid**.

### Arquitectura general
Se podria decir, que desde mi equipo local, podria llegar a tener la siguiente configuración con respecto al control de maquinas virtuales:
```text
Equipo local (Arch Linux)
 └── virt-manager
     ├── QEMU/KVM (local)
     └── QEMU/KVM (unRAID remoto)
          └── VM Windows XP / Windows 7
````
Tambien se puede decir que:
- unRaid **define y gestiona** las VMs.
- Virt-Manager se usa como **visor** de las VMs.

#### Requisitos

Los paquetes que vamos a necesitar son los siguientes:
- En **unRaid**:
  - Servició de virtualización activado. En pocas palabras, que puedas crear una VM sin problemas.
  - Acceso por **SSH**.
  - VM creada con grafica **SPICE** o **VNC**.
  - Red en modo **bridge**.
- En **Arch Linux**:
  - Tener instalado **virt-manager** y lo podemos utilizar de 2 maneras diferentes que son:
    - Como **host** de virtualización local.
    - Como **cliente** remoto (unRaid haria de servidor).

Es importante saber distinguir entre las dos maneras, porque con cada funcionalidad requiere unos paquetes.

#### Virt-Manager como cliente (unRaid) 

En este escenario, **Arch Linux** no ejecuta ninguna VM, sino que se conecta a *libvirt* de *unRaid* en remoto. Los paquetes que se necesitan son los siguientes:
- *Virt-Manager* → Usaremos como interfaz grafica.
- *Libvirt* → Usaremos como cliente de *libvirt* (unRaid).
- *Virt-Viewer* → Es la consola para *SPICE / VNC*.
- *Spice-GTK* → Sera el soporte grafica de *SPICE*
- *OpenSSH* → Que tenemos que tener instalado si es que no lo tenemos.
> En esta manera de funcionar, no nos hace falta *QEMU*, aunque es muy posible que se instale como dependencia de algun otro paquete.

Una cosa que pongo, pero que no haria falta explicar, es la manera de realizar la instalación de estos paquetes:
```bash
usuari@archlinux:~/ sudo pacman -S virt-manager libvirt virt-viewer spice-gtk openssh
```
Una vez ya tenemos instalados los paquetes necesarios, procedemos a realizar la conexión mediante SSH.
{{< admonition note >}}
Lo que si que tenemos que tener en cuenta, es que **virt-manager** asume que la conexión a traves de *SSH* se realiza por el **puerto 22**, en mi caso, yo tenia configurada la conexión de *SSH* (`./ssh/config`) a mi servidor *unRaid*:
```ssh
Host unRaid
    HostName 192.168.1.100
    User root
    Port 2222
```
{{< /admonition >}}

Solamente nos queda realizar la conexión entre nuestro *cliente de Virt-Manager* y nuestra VM de *unRaid* y lo hacemos de la siguiente manera:
- Vamos a **Archivo** → **Añadir conexión**
- Seleccionamos el tipo de conexión `QEMU/KVM`
- Seleccionamos **Conexión remota** 
- En **URI personalizada** introducimos lo siguiente `qemu+ssh://unRaid/system`.
  - Yo pongo **unRaid** porque es como tengo identificada la conexión con el servidor, si vosotros lo teneis con otro nombre, hay que poner el vuestro.

### Flujo de trabajo recomendado

El procedimiento que tenemos que seguir para crear una VM en *unRaid* seria el siguiente (hay miles de articulos explicando esto, pero yo lo pongo, porque me sirve como apunte para cuando lo necesite):
- Desde la interfaz web de unRAID:
  - Crear nueva VM
  - Definir CPU, RAM y disco
  - Elegir BIOS (SeaBIOS / OVMF)
  - Red en modo bridge
  - Gráfica: **SPICE**
  - Vídeo: **QXL**
  - Audio:
    - Windows XP → `ac97`
    - Windows 7 → `ich9`

> Toda la **definición de hardware** debe hacerse desde *unRaid*.

- Arrancar y usar la VM desde virt-manager
  - Conectarse al host unRAID
  - Arrancar la VM
  - Abrir la consola gráfica
  - Instalar y configurar el sistema operativo

> Virt-Manager actúa únicamente como *Pantalla + teclado + ratón remotos*

A continuación os pongo unos consejos que he ido recogiendo a medida que he ido haciendo pruebas:
- **Buenas prácticas**:
  - Crear y modificar las VMs desde el servidor *unRaid*.
  - Usar *Virt-Manager* para el uso diario.
- **No recomendado**:
  - Crear VMs desde *Virt-Manager* en *unRaid*.
  - Cambiar el hardware de la maquina virtual desde *Virt-Manager*.
  - Editar el fichero `XML` manualmente.
  
Como resumen final, se podria decir que:
- Virt-Manager puede usarse como **cliente remoto**
- No requiere el stack completo de virtualización local
- unRAID **define y gestiona** las VMs
- Virt-Manager **se conecta y se usa**
- Es el método más limpio y estable

> **unRAID manda, virt-manager se usa**

Con este articulo, doy por finalizado mis articulos con respecto a la instalación, configuración y uso de **QEMU + Virt-Manager** en **Arch Linux**.
#### Referencia

