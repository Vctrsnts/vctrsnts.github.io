# Montar imagen ISO desde consola en GNU/Linux

Vamos a explicar como a traves de la consola de GNU/Linux se puede montar una imagen / archivo ISO.

No se si os ha pasado alguna vez a vosotros, pero llega un dia, que teneis una **ISO** y os encontrais sin CD para gravar y el lector y no sabeis que hacer en ese momento (me ha pasado más de una vez), hasta que he encontrado este sencillo metodo para resolver el problema.

<!--more-->

Lo primero es acceder a la consola y ejecutamos el siguiente comando:
```bash
usuari@debian:~$ sudo mkdir /media/cdrom
```

Estamos creando el directorio donde vamos a montar la imagen **ISO**, en mi caso, como ya tengo este directorio me puedo saltar este paso.

Ahora pasamos a montar la imagen directamente:
```bash
usuari@debian:~$ sudo mount -o loop -t iso9660 /ruta_imagen.iso /media/cdrom
```

Vamos a explicar un poco que significa cada parametro:
- El parametro **-o** es un indicador de opciones genericas para asi poder usar **loop**. Esta opción de bucle le indica a GNU/Linux que use la interfaz de bucle invertido en lugar de un dispositivo fisico, ya que la imagen ISO no es un dispositivo real con una lista en el directorio **/dev**.
- El parametro **-t** hace referencia al tipo de sistema de archivos a montar, en este caso es **iso9660** o lo que es lo mismo, usa **ISO**.

Cuando tenemos montada la **ISO**, ya podemos acceder a ella como si fuera un CD/DVD normal.

Para finalizar, nos quedara desmontar la imagen **ISO** de la misma manera como se haria con un dispositivo fisico:
```bash
usuari@debian:~$ sudo umount /media/cdrom
```
#### Referencia
- [Cómo montar imagen ISO en Linux](https://www.solvetic.com/tutoriales/article/5805-como-montar-iso-en-linux/)

