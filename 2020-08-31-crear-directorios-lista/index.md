# Crear directorios a partir de un fichero de texto

A veces tengo que crear unos cuantos directorios (normalmente para musica). Si son 5 no pasa nada, pero cuando son más de 20, pues al final te cansas un poco.

<!--more-->

Pero buscando por internet, encontre una instrucción en `BASH` que hace lo mismo. La instrucción es la siguiente:

```bash
usuari@debian:~$ xargs -I{} mkdir -p "{}" < dirs.txt
```

Donde:
- **dirs.txt**: El fichero donde estan los directorios a crear

Hasta aqui hemos llegado. A ver si en un futuro, voy poniendo otras instrucciones que me son de utilidad y nunca se sabe, tambien os pueden servir.
#### Referencia

