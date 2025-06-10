# Copiar un archivo a varios directores

A veces tengo que copiar un fichero (normalmente una caratula para la musica) a varios directorios. Si son 5 no pasa nada, pero cuando son más de 20, pues al final te cansas un poco.

<!--more-->

Pero buscando por internet, encontre una instrucción en `BASH` que hace lo mismo. La instrucción es la siguiente:

```bash
usuari@debian:~$ for dir in *; do [ -d "$dir" ] && cp /path/file.txt "$dir" ; done
```

Donde:
- **$dir**: son los directorios de destino
- **/path/file.txt**: es el fichero que quiero copiar en los diferentes directorios

Hasta aqui hemos llegado. A ver si en un futuro, voy poniendo otras instrucciones que me son de utilidad y nunca se sabe, tambien os pueden servir.
#### Referencia

