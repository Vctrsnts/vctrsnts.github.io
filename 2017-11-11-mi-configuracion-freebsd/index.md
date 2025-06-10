# Mi configuración en FreeBSD

Siguiendo con mis entradas que hacen referencia a **FreeBSD**, a continuación dejo la que uso en mi portatil **Lenovo Y700** y que parece ser que funciona correctamente.

A lo mejor en el futuro la voy modificando dependiendo del funcionamiento que vaya teniendo...

<!--more-->

```bash
root@freebsd:~# vi /boot/loader.conf

# CONSOLA
kern.vty=vt
# Esto es una cosa que tengo que seguir investigando, porque no acaba de funcionar
# correctamente.
kern.vt.fb.default_mode="1440x900"
hw.vga.textmode=1
# ACPI IBM/LENOVO
acpi_ibm_load="YES"
acpi_video_load="YES"
hint.p4tcc.0.disabled=1
hint.acpi_throttle.0.disabled=1
# WIFI
# LO TENGO DESACTIVADO, PORQUE NO LO USO, PERO...
#if_iwm_load="YES"
#iwm7265fw_load="YES"
```

```bash
root@freebsd:~# vi /etc.rc.conf

# ESTO YA VIENE POR DEFECTE DESPUES DE INSTALAR EL SISTEMA
clear_tmp_enable="YES"
sendmail_enable="NONE"
keymap = "es.acc"
hostname = "miMaquina"
ifconfig_xxx = "inet x.x.x.x netmask 255.255.255.0"
defaultrouter = "x.x.x.x"
dumpdev = "AUTO"
# COSAS QUE HE AÑADIDO
# NTP_DATE (TENGO QUE SEGUIR INVESTIGANDO PORQUE NO ME ACABA DE FUNCIONAR
# CORRECTAMENTE)
ntpd_enable = "YES"
# XORG
dbus_enable = "YES"
hald_enable = "YES"
# POWERD
powerd_enable = "YES"
performance_cx_lowert = "Cmax"
economy_cx_lowert = "Cmax"
# SSH (DE MOMENTO NO LO TENGO CONFIGURADO), ASI QUE, DESACTIVADO
sshd_enable = "NO"
# WIFI (DESACTIVADO PORQUE NO LO USO)
#wlans_iwm0 = "wlan0"
ifconfig_wlan0 = "WPA SYNCDHCP"
```

```bash
root@freebsd:~# vi /etc/sysctl.conf

# Desactivamos el Speaker
hw.syscons.bell = 0
```

```bash
root@freebsd:~# vi /etc/fstab

proc	/proc	procfs	rw	0	0
```
De momento, esto es todo.
#### Referencia

