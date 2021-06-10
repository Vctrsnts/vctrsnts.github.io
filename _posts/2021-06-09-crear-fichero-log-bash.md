---
layout: post
title: "Crear fichero de logs en bash"
author: Victor
date: 2021-06-09
category: [linux,bash]
---

A veces tienes la necesidad de crear un fichero de log para saber cuando se ejecuta un proceso en un script que puedes haber creado, aqui pongo el que yo uso.

A traves del siguiente codigo de bash, podemos crear nuestro propio fichero de logs:

```
tie=/tmp/script_final.log*
# PER SAPIGUER LA DATA D'INICI*
hi=`date`*
# PER SAPIGUER LA DATA FINAL*
hf=`date`*

echo $hf" " >> $tie*
```

Y con esto ya tenemos nuestro log
