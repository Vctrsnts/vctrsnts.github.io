# Instalar Qemu y VirtManager en Arch - 2

En este segundo articulo, explicaremos un poco como me voy adaptando a usar *VirtManager* en vez de *VirtualBox* y las modificaciones que he tenido que hacer en mi flujo de trabajo con respecto al usar *VirtManager*.

<!--more-->

Hay que partir de la base que el uso de le doy yo a *VirtManager* es muy basico, esto se debe, a que no he encontrado alternativas que me guste a las diferentes aplicaciones que uso. 

Además, como no quiero usar muchos recursos para esto, pueso como sistema operativo que virtualizo es principalmente un *Windows XP*, y porque no funcionan correctamente con *Windows 2000*, porque sino 😀. Si lo siento, soy un nostalgico con respecto a los *SO*.

Las aplicaciones a las que me refiero, son las siguientes:
- **mp3Tag** → Para modificar la información de los archivos de musica.
- **PDFSam** → Para unificar archivos de PDF. Seguramente en Arch hay alguno mejor, pero estoy acostumbrado a este.
- **IrfanView** → Para gestionar imagenes. No he encontrado ninguno que lo supere.
- **TransmissionGui** → Me gusta tenerlo para emergencias cuando el acceso por web no funciona.
- **aMuleGUI** → Para gestionar la descarga de ISO's de mis distribuciones favoritas.

Muchos pensareis, que la mayoria de las aplicaciones que uso, se podrian encontrar en **Arch Linux**, pero es que me gustan estas y estoy tan habituado a usarlas, además, son tan simples que no requieren mucho esfuerzo 😆.

Pero es aqui donde esta el problema principal, que tener directorios compartidos entre Arch Linux o cualquier otro *GNU/Linux* y *VirtManager* no se hace de la misma manera que con *VirtualBox*, y por eso tuve que buscarme una alternativa funcional viendo que las opciones que tiene *VirtManager* con *Windows XP* no funcionan, por ser un sistema operativo muy antiguo. 

Y no encontra una mejor manera que a traves de *SAMBA*.

{{< admonition note >}}
Habiendo miles de manuales para la instalación de *Samba*, como vengo aqui a crear un nuevo articulo con la instalación y configuración de Samba en Arch, pero como siempre he dicho, este es mi almacen particular del conocimiento, para que, llegado el momento, lo tengo que volver a hacer, encontrar mas facilmente la información de como se hace y si además, os puede servir de ayuda, mejor que mejor 😀.
{{< /admonition >}}

Ahora vayamos a lo más importante, la instalación y configuración de *Samba* en *Arch Linux* para poderlo usar en *Windows XP*.

### Instalación de Samba en Arch Linux
Es lo más facil de todo y se hace de la siguiente manera:
```bash
usuari@archlinux:~/ sudo pacman -S samba
```
Una vez tenemos *samba* instalado, pasamos a crear el directorio que compartiremos con *Windows XP*:
```bash
usuari@archlinux:~/ mkdir -p /home/usuario/Compartida
usuari@archlinux:~/ chmod 777 /home/usuario/Compartida
```
### Configuración de Samba
Es tambien, facil de hacer, solamente se tiene que modificar el archivo `/etc/samba/smb.conf`, en mi caso al final del archivo he añadido lo siguiente:
```yml
[global]
   workgroup = WORKGROUP
   map to guest = Bad User
   interfaces = lo virbr0
   bind interfaces only = yes

[Compartida]
   path = /home/usuari/Compartida
   browseable = yes
   read only = no
   guest ok = yes
   force user = usuari
   create mask = 0664
   directory mask = 0775
```
Donde:
- `guest ok = yes` → permite acceso sin usuario/contraseña.
- `interfaces` → limita Samba a escuchar solo en la interfaz de **lo** y en la red virtual **NAT**.

### Habilitar y arrancar los servicios
Una vez ya hemos configurado nuestro archivo para *samba*, pasamos a habilitar e iniciar los servicios de *samba*:
```bash
usuari@archlinux:~/ sudo systemctl enable --now smb nmb
# Verificar que Samba está activo:
usuari@archlinux:~/ systemctl status smb
usuari@archlinux:~/ systemctl status nmb
# reiniciamos los servicios
usuari@archlinux:~/ sudo systemctl restart smb nmb
```
### Configuración de virt-manager
Ahora nos vamos a realizar la configuración en *VirtManager*:
- Abrir virt-manager y seleccionar tu máquina virtual.
- Ir a Detalles → `NIC (Interfaz de red)`.
  - Asegurarte de que la Fuente de red está configurada como `Virtual network 'default': NAT`

Con *NAT*, la VM tiene acceso a Internet y puede ver al host en la dirección `10.0.2.2`.

### Acceso desde Windows XP invitado
- En el explorador de archivos de Windows, escribe en la barra de direcciones `\\10.0.2.1\Compartida`
  - La ip depende de como tengas configurado tu maquina virtual y la que le haya dado *Virt-Manager* a tu maquina virtual, unicamente tienes que saber que para acceder al directorio compartido tienes que poner la IP de tu maquina (local) dentro de esta red fictica, siendo esta `1`.
- Si configuraste `guest ok = yes` entrarás directamente. 
  - En el caso de que quieras acceso con usuario y contraseña, se tiene que hacer lo siguiente:
```bash
usuari@archlinux:~/ sudo smbpasswd -a usuari
```
  - Modifica el bloque en `smb.conf` añadiendo lo siguiente `valid users = usuario`
- Ahora podrás copiar y pegar archivos entre el host Arch Linux y el invitado Windows.

### Hablemos de seguridad
Si usamos **NAT**, el recurso compartido solo podra ser accesible desde la maquina virtual, no desde la red externa. Además, si quieres puedes añadir más seguridad para que *samba* solo *escuche* las peticiones que le vengan de *lo* y de *virbr0* y que no se exponga a tu *LAN*.

Esto se consigue añadiendo lo siguiente `interfaces = lo virbr0` en el fichero de configuración de *samba*.

De esta manera, tenemos ya configurado nuestro *samba* para poderlo usar, en mi caso, con la maquina virtual. A lo mejor existe otro metodo mejor, pero yo no lo he encontrado. Si vosotros lo conoceis estare deseoso de aprenderlo.
#### Referencia
- [Ruben](https://www.youtube.com/@Ruben-Linux)
- [Instalación de Qemu, KVM y Virt Manager en Arch Linux](https://www.youtube.com/watch?v=HN-krqqblOA)
- [VirtualBox](https://www.virtualbox.org)

