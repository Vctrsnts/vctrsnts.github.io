---
layout: post
title: "Copiar un archivo a varios directores"
author: Victor
date: 2020-08-30
category: [linux,bash]
---

A veces tengo que copiar un fichero ( normalmente una caratula para la musica ) a varios directorios. Si son 5 no pasa nada, pero cuando son más de 20, pues al final te cansas un poco.

Pero buscando por internet, encontre una instrucción en `BASH` que hace lo mismo. La instrucción es la siguiente:

```for dir in *; do [ -d "$dir" ] && cp /path/file.txt "$dir" ; done```

Donde:

- **$dir**: son los directorios de destino
- **/path/file.txt**: es el fichero que quiero copiar en los diferentes directorios
