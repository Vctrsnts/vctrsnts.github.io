# Raspberry Pi. Instalar y configurar fail2ban

Siguiendo con mis capitulos con respecto a la configuración y uso de mi RPI4 (tambien explicado en este otro [articulo](/2020-10-30-rpi-cambiando-equipo), pues ahora pasamos a añadir una protección más y que en  todos los sitios donde explican su configuración, se preguntan, porque no esta instalada por defecto en todos los sistemas GNU/Linux.

<!--more-->

Esta protección es **fail2ban**.

Su funcionalidad es la de monitorizar todos los intentos de conexión a los servicios que hayas indicado en el fichero de configuración,  `jail.local` y cuando ve que una `IP` intenta hacer más de un intento fallido, *bloquea - banea* durante el tiempo que tu hayas indicado.

Ahora, pasamos a explicar unos cuantos conceptos del fichero de configuración:
- **maxretry**: Cuantos intentos de conexión se aceptan antes del bloqueo / baneo.
- **fintime**: Es durante cuanto tiempo se monitoriza una IP antes de activarse la opcion **maxretry**
- **bantime**: Cuanto tiempo permanecera baneada la ip de donde ha venido el intento de conexión. En el caso de que quieras ser agresivo, puedes poner más tiempo. En mi caso lo tengo con que el baneo sea de 1 dia (86.400 segundos).
- **ignoreip**: Para ignorar los intentos de conexión fallidos que vienen de nuestra propia red.

Ahora pasamos a su modificación.

Lo que he leido en todos sitios con respecto a **fail2ban**, es que lo mejor es copiar el fichero `jail.conf` a `jail.local`.
```bash
usuari@raspberry:~$ cd /etc
usuari@raspberry:~$ sudo cp jail.conf jail.local
```

Una vez hecho esto, ya lo podemos editar con las opciones que más nos interesan que en mi caso son las siguiente:
```bash
# descomentar la opción ignoreip para que no tenga en cuenta los accesos
# que vienen de nuestra propia red
ignoreip = 127.0.0.1/8::1
# descomentamos la opción bantime y en mi caso he puesto 86400
bantime = 86400
# descomentamos la opcion fintime y yo he dejado el valor por defeccto
fintime = 10m
```

Ahora pasamos a activar los modulos que nos interesa que en mi caso es el modulo de `sshd`. Los modulos se encuentran a partir de la opción `JAILS`.

Se activan con la opción `enabled = true`. Y en mi caso el modulo de `SSHD` queda de la siguiente manera:
```bash
enabled = true
filter = sshd
# Aqui es donde ponemos los puertos a controlar. Si ponemos ssh,
# se monitoriza el puerto por defecto de ssh (22), pero
# tambien podemos poner otros puertos.
port = ssh, xxxx
```

Si revisas los modulos disponibles, ves que hay un monto, por ejemplo `dropbear`, `apache`, `nginx`, `lighttpd` y unos cuantos más.

De esta manera ya tenemos configurado **fail2ban**, ahora solamente falta activarlo:
```bash
usuari@raspberry:~$ sudo /etc/init.d/fail2ban start
```

Ahora, nos toca disfrutar de los baneos, que puedes ver en el fichero de los:
```bash
usuari@raspberry:~$ sudo tail -f /var/log/fail2ban.log
```

{{< admonition tip >}}
Que como dice un youtuber famoso [PeladoNerd](https://www.youtube.com/channel/UCrBzBOMcUVV8ryyAU_c6P5g), es un ejercicio muy saludable.
{{< /admonition >}}

Asi mismo, tambien pongo el codigo necesario para poder `desbanear` nuestra ip de acceso a la raspberry (me ha pasado más de una vez), lo que se tiene que hacer es lo siguiente:
```bash
usuari@raspberry:~$ fail2ban-client set sshd unbanip x.x.x.x
# Donde x.x.x.x es la ip
```

Ten en cuenta, que esto lo tienes que hacer desde otro PC, porque desde el que tienes acceso normalmente no te dejara acceder, si es que no le cambias la ip.
#### Referencia
- [fail2ban en una Raspberry Pi](https://elblogdelazaro.gitlab.io/2017-10-05-fail2ban-raspberry)
- [ESTO TENDRIA QUE VENIR POR DEFECTO EN LINUX - V2M / fail2ban](https://www.youtube.com/watch?v=PAK7I1cKwzA)
- [Desbanear IP](https://support.moonpoint.com/os/unix/linux/fail2ban-unban.php)

