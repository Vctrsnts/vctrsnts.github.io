---
layout: post
title: "Comprimir / Descomprimir un fichero"
author: Victor
date: 2010-11-05
category: [linux],[bash]
---

Aqui va una cosa, que supongo que como a mi, a veces nos olvidamos de como se hace. Comprimir y descomprimir un fichero en **GNU/Linux Debian**.

### Archivos .tar:
  - Comprimir: ```tar -cvf archivo.tar directorio/```
  - Descomprimir: ```tar -xvf archivo.tar```

### Archivos .gz:
 - Comprimir: ```gzip -9 archivo```
 - Descomprimir: ```gzip -d archivo.gz / gunzip archivo.gz```

### Archivos .bz2:
 - Comprimir: ```bzip2 archivo```
 - Descomprimir: ```bzip2 -d archivo.bz2```

### Archivos .tar.gz:
 - Comprimir: ```tar -cvfz archivo.tar.gz directorio/```
 - Descomprimir: ```tar -xvfz archivo.tar.gz```
 - Visualizar: ```tar -tzf archivo.tar.gz```

### Archivos .tar.bz2:
 - Comprimir: ```tar -cvfj archivo.tar.bz2 directorio/```
 - Descomprimir: ```tar -xvfj archivo.tar.bz2```
 - Visualizar: ```tar -tjf archivo.tar.bz2```

### Archivos .zip:
 - Comprimir: ```zip archivo.zip directorio/```
 - Descomprimir: ```unzip archivo.zip```

### Archivos .tar.xz:
 - Comprimir: ```tar cJf archivo.tar.xz directorio```
 - Descomprimir: ```tar -Jxvf archivo tar.xz```

Espero que os sirva ayuda tanto como a mi. Porque nunca me acuerdo cuando lo necesito y siempre tengo que buscar como se hace...
