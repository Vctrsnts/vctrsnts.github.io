# Dividir / Unir Fichero en GNU/Linux

Un truco nuevo, en mi caso, pero que seguro que mucha gente lo conoce, pero que nunca esta de más tenerlo a mano por si se necesita...

<!--more-->

En este caso, tengo que pasar un fichero de 10Gb a otro PC, pero no tengo red y como único medio posible de pasar la información es un USB de 8Gb. Si podría comprarme uno más grande, pero ...

Así que vamos a dividir el fichero y después volverlo a juntar. Vamos a por ello.

Para dividir el fichero usaremos la instrucción `split` de la siguiente manera :
```bash
usuari@debian:~$ split -b tamaño_trozos fichero_a_trocear nombre_trozos
```

Donde :
- **tamaño_trozos**: se indica un nº. Por defecto es *en bytes*, pero añadiendo la opción `m` diríamos megas.
- **fichero_a_trocear**: fichero que queremos dividir en trozos.
- **nombre_trozos**: prefijo de los trozos (split añadirá aa, ab, ac, etc.)

Una vez que hemos dividido el fichero, para volverlo a unir, usaremos la instrucción `cat` de la siguiente manera :
```bash
usuari@debian:~$ cat trozos.* > fichero_destino
```

Donde :
- **trozos**: serà el nombre de los ficheros a unir.
- **fichero_destino**: nombre del fichero original.

Espero que esto os pueda servir de ayuda en un apuro. A mi me va a ser de mucha utilidad en algunos momentos.
#### Referencia

