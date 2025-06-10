# Grabar fichero img a USB

Siguiendo mi aprendizaje con FreeBSD, aqui explico, seguramente en otros sitios diferentes de este basto oceano llamado internet, lo encontrareis mejor explicado, como grabar un fichero `*.img` a un prendrive, es una cosa que nunca me acuerdo como se hace y siempre acabo buscandolo.

<!--more-->

La instrucción para realizar esta acción es la siguiente:

```bash
root@debian:~# dd if=FreeBSD-11.0-STABLE-amd64-20170510-r318134-memstick.img of=/dev/sdb bs=1024 conv=sync
```

Donde:
- [dd](https://es.wikipedia.org/wiki/Dd_(Unix)) es el comanda para realizar la grabación.
- `if=*.img` donde se encuentra la imagen de disco memstick.
- `of=/dev/sdb` donde esta el pendrive (lo estoy haciendo desde GNU/Linux).
- `bs=10204` y `conv=sync` son los valores recomendados por el *equipo FreeBSD* para realizar la grabación.
#### Referencia

