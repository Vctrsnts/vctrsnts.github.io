# Mover ficheros de un arbol de directorios a un directorio

A veces tengo que mover varios ficheros (normalmente epub - libros electronicos). Si son 5 no pasa nada, pero cuando son más de 20, pues al final te cansas un poco.

<!--more-->

Pero buscando por internet, encontre una instrucción en **Bash** que hace lo mismo. La instrucción es la siguiente:

```bash
usuari@debian:~$ find . -type f -name *.ext -exec mv {} /tmp \;
```

Donde:
- **.ext**: extensión de los ficheros que queremos mover

Hasta aqui hemos llegado. A ver si en un futuro, voy poniendo otras instrucciones que me son de utilidad y nunca se sabe, tambien os pueden servir.
#### Referencia

