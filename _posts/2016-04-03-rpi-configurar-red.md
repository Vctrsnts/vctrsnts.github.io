---
layout: post
title: "Raspberry Pi. Configurar la red"
author: Victor
date: 2016-04-03
category: [raspberry,raspbian]
---

Ahora que ya tenemos configurado y funcionando nuestra Raspberry, ahora le toca el turno a la red ( en mi caso, quiero ip fija ).

Para realizar la configuración, ya no se hace antes, modificando el fichero :

```
root@maquina:~# /etc/network/interfaces
```

Ahora se modifica el fichero :

```
root@maquina:~# vi /etc/dhcpcd.conf
```

En mi caso, como quiero que tenga ip fija, yo lo dejo configurado de esta manera :

```
interface eth0
static ip_address = 192.168.0.2/24
static routers = 192.168.0.1
static domain_name_servers = 80.58.61.250 80.58.61.254
```

Yo estoy usando `vi`, otras personas a lo mejor usa `nano`, cuestión de gustos...

Después de esto, ya tenemos configurado nuestra tarjeta de red.

Ahora solamente falta reiniciar el servicio. Hay 2 maneras, reiniciar la Raspberry o reiniciando el servicio :

```
root@maquina:~# /etc/init.d/networking stop
root@maquina:~# /etc/init.d/networking start
```

Listos. En el proximo capitulo, explicare como copiar la raiz del sistema `/` a un HD externo, para preservar la SD.

Hasta la proxima
