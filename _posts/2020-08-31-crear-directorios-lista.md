---
layout: post
title: "Crear directorios a partir de un fichero de texto"
author: Victor
date: 2020-08-31
category: [linux],[bash]
---

A veces tengo que crear unos cuantos directorios ( normalmente para musica ). Si son 5 no pasa nada, pero cuando son más de 20, pues al final te cansas un poco.

Pero buscando por internet, encontre una instrucción en `BASH` que hace lo mismo. La instrucción es la siguiente:

```xargs -I{} mkdir -p "{}" < dirs.txt```

Donde:

- **dirs.txt**: El fichero donde estan los directorios a crear
