---
layout: post
title: "Raspberry Pi. Acceso a traves de ssh"
author: Victor
date: 2016-04-04
category: [raspberry],[raspbian],[ssl]
---

Una vez que ya tenemos nuestra Raspberry en marcha y funcionando ahora viene la parte divertida, como acceder a ella desde el exterior. En mi caso desde otra ubicación y además con un poco de seguridad para que nadie pueda acceder a ella.

Esto se consigue a traves de nuestro bien intencionado `ssh` y una correcta configuración que pasare a explicar a continuación.

Lo primero es tener instalado el paquete `openssh-server`, luego, procedemos a generar nuestras claves publicas para realizar la connexión con la Raspberry. Este procedimento se realiza a traves de la instruccion `ssh-keygen` como se muestra a continuación:

```
usuari@maquina:~$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/tuUsuario/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/tuUsuario/.ssh/id_rsa.
Your public key has been saved in /home/tuUsuario/.ssh/id_rsa.pub.
The key fingerprint is:
be:11:15:e3:6a:dc:a6:a6:7e:e9:6c:7b:9f:30:28:40 root@poe
The key's randomart image is:
+--[ RSA 2048]----+
| o |
| . o |
| E o |
| . . + |
| . S o |
| . o = |
| . *.o |
| =+o.o . |
| .o+=o .o |
+-----------------+
```

Ahora, pasamos a copiar esta clave publica a nuestro Raspberry con la instrucción `ssh-copy-id` como se muestra a continuación:

```
usuari@maquina:~$ ssh-copy-id -i .ssh/id_rsa.pub tuUsuario@ipRaspberry
```

Con esta instrucción, lo que se hace es copiar nuestra clave publica en la Raspberry.

Ahora solamente faltaria realizar la connexión a traves de ssh para ver el resultado:

```
usuari@maquina:~$ ssh -l tuUsuario -p tuPuerto ipRaspberry
```

Asi mismo, para obtener un poco más de seguridad, yo lo he echo, es configurar de la siguiente manera el fichero:

```
root@maquina:~# vi /etc/ssh/sshd_config
```

Y modificaremos las siguientes opciones:

```
# Desactivar la opción de acceso a traves de password
PasswordAuthetication no
# Desactivar la opción de acceso a traves de root
PermitRootLogin       no
# Acceso a traves de una llave publica
PubkeyAuthenticacion  yes
# Se aconseja cambiar el puerto de acceso del servicio ssh
Port 2222
# Cantidad de segundos que la pantalla de login estara disponible
LoginGraceTime 60
# No permitimos contraseñas vacias o en blanco
PermitEmptyPasswords no
# Numero maximo de errores permitidos al hacer login
MaxAuthTries 3
# Numero maximo de conexiones simultaneas por IP
MaxStartups 2
```

# Nota: Antes de realizar este procedimiento, es aconsejable borrar las claves que tenemos en la Raspberry y volverlas a generar como simple medida de seguridad, porque estas claves son las mismas en todas las imagenes de Jessie que nos bajamos.

Entonces, si anteriormente nos hemos conectados desde nuestro PC a la Raspberry, ahora nos mostrara un mensaje donde nos indicara que las claves son erroneas. Para solucionar este problema, hay dos maneras, que son las siguientes:

- Borrar el directorio .ssh de nuestro usuario
- Borrar la clave que tenemos almacenada de nuestra Raspberry

Es preferible realizar la segunda opción de la siguiente manera:

```
usuari@maquina:~$ ssh-keygen -f "/home/tuUsuario/.ssh/know_host" -R ipRaspberryerry
```

Con esto conseguimos borrar la clave de la Raspberry que tenemos en nuestro PC. Lo siguiente que pasariamos ha realizar, es la configuració.

Esto lo vamos a realizar a traves de la siguiente.
