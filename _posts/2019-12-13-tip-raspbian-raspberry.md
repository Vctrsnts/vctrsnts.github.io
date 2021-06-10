---
layout: post
title: "TIP Sobre Raspbian / Raspberry"
author: Victor
date: 2019-12-13
category: [raspberry],[raspbian]
---

A continuación pongo unos cuantos TIPS más con respecto a Raspbian, mayormente para que no se me olviden para más adelanta ;)

## Desactivar la wifi y el bluetooth de la Raspberry

Para hacer esto, solamente se tiene que modificar un fichero :

```
root@maquina:~# vi /boot/config.txt
```

Y luego añadimos lo siguiente :

```
dtoverlay=disable-wifi
dtoverlay=disable-bt
```

## Obtener más voltaje en las salidas de USB

```
root@maquina:~# vi /boot/config.txt
```

Y luego añadimos lo siguiente: `max_usb_current=1`

## Alias SSH

A continuación, pongo un atajo ( que he descubierto hace poco de un Youtuber llamado [PeladoNerd](https://www.youtube.com/channel/UCrBzBOMcUVV8ryyAU_c6P5g) para cuando tenemos que conectarnos a maquinas remotas a través de `SSH`, en vez de estar escribiendo todo el rato la *IP*, *Puerto* y *Usuario*, se puede hacer a través de un alias.

Esto se hace a traves del siguiente fichero:

```
usuari@maquina: ~$ vi .ssh/config
```

Y añadimos lo siguiente :

```
Host aliasMaquina
  Hostname Ip de la Maquina
  User usuario de connexión
  Port Puerto de connexión en caso de no tener el por defecto
```

Con este simple fichero, tal como he dicho antes, con solo hacer :

```
usuari@maquina: ~$ ssh aliasMaquina
```

Nos conectaremos directamente a la maquina. En mi caso, me pide el password, porque lo tengo configurado así.

**Referencia:**

* [OpenSSH Config](https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix)
* [Aprendiendo SSH](https://www.youtube.com/watch?v=RMS5zBYQIqA)
