---
layout: post
title: "Mover ficheros de un arbol de directorios a un directorio"
author: Victor
date: 2020-08-29
category: [linux]
---

A veces tengo que mover varios ficheros ( normalmente epub - libros electronicos ). Si son 5 no pasa nada, pero cuando son más de 20, pues al final te cansas un poco.

Pero buscando por internet, encontre una instrucción en **BASH** que hace lo mismo. La instrucción es la siguiente:

```find . -type f -name *.ext -exec mv {} /tmp \;```

Donde:

- ***.ext**: extensión de los ficheros que queremos mover
