# Raspberry Pi. Configurar la red

Ahora que ya tenemos configurado y funcionando nuestra Raspberry, ahora le toca el turno a la red (en mi caso, quiero ip fija).

<!--more-->

Para realizar la configuración, ya no se hace antes, modificando el fichero:
```bash
root@raspberry:~# /etc/network/interfaces
```

Ahora se modifica el fichero:
```bash
root@raspberry:~# vi /etc/dhcpcd.conf
```

En mi caso, como quiero que tenga ip fija, yo lo dejo configurado de esta manera:
```bash
interface eth0
static ip_address = 192.168.0.2/24
static routers = 192.168.0.1
static domain_name_servers = 80.58.61.250 80.58.61.254
```

Yo estoy usando `vi`, otras personas a lo mejor usa `nano`, cuestión de gustos...

Después de esto, ya tenemos configurado nuestra tarjeta de red.

Ahora solamente falta reiniciar el servicio. Hay 2 maneras, reiniciar la Raspberry o reiniciando el servicio:
```bash
root@raspberry:~# /etc/init.d/networking stop
root@raspberry:~# /etc/init.d/networking start
```

Listos. En el proximo capitulo, explicare como copiar la raiz del sistema `/` a un [HDD](/2016-04-03-rpi-iniciar-hd-externo), para preservar la SD.

Hasta la proxima
#### Referencia

