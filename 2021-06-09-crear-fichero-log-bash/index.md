# Crear fichero de logs en bash

A veces tienes la necesidad de crear un fichero de log para saber cuando se ejecuta un proceso en un script que puedes haber creado, aqui pongo el que yo uso.

<!--more-->

A traves del siguiente codigo de bash, podemos crear nuestro propio fichero de logs:

```bash
tie=/tmp/script_final.log*
# PER SAPIGUER LA DATA D'INICI*
hi=`date`*
# PER SAPIGUER LA DATA FINAL*
hf=`date`*

echo $hf" " >> $tie*
```

Con esto ya tenemos nuestro log
#### Referencia

