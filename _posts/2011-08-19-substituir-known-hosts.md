---
layout: post
title: "Sustituir una clave antigua de known_hosts"
author: Victor
date: 2011-08-19
category: [linux],[ssl]
---

Es posible que más de una vez nos hayamos encontrado con un mensaje similar a éste (siento decirlo, pero a mi me a pasado muchas veces):
```
usuari@maquina:~> ssh servidor-ssh
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED! @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that the RSA host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
00:ff:00:ff:00:ff:00:ff:00:ff:00:ff:00:ff:00:ff.
Please contact your system administrator.
Add correct host key in /home/usuario/.ssh/known_hosts to get rid of this message.
Offending key in /home/usuario/.ssh/known_hosts:8
RSA host key for localhost has changed and you have requested strict checking.
Host key verification failed.
```

Este error se produce debido a que ha fallado la autenticación de la clave pública ssh del servidor. Esto podría ser debido a un intento de ataque man in the middle, o también simplemente que el administrador ha reinstalado el sistema en el que se ejecuta el servidor SSH y no ha recordado hacer copia de su clave. Esto provoca que por seguridad, en clientes configurados con la opción <code>StrictHostKeyChecking=yes</code> no te permita conectar al servidor.

Una manera rápida de solucionar esto sería conectar forzando ignorar este aviso:

```
usuari@maquina:~> ssh -o "StrictHostKeyChecking=yes" servidor-ssh
```

Por supuesto, esta no es la manera más adecuada de hacerlo, primero, porque si lo hacemos sin ninguna comprobación podríamos ser víctimas de ataque que hablábamos antes, y segundo, porque el aviso no desaparecerá en futuras conexiones.

Si efectivamente verificamos que se trata de una simple cambio de IP, DNS o reinstalación de sistema (comprobando que el nuevo fingerprint coincide con el del servidor), tenemos que borrar la clave vieja. Antiguamente, podíamos editar el archivo <code>~/.ssh/known_hosts</code> directamente, pero actualmente los nombres de los hosts en este archivo estan “ocultos” mediante HMAC. Es por ello que para borrar dicha clave tendremos que ejecutar:

```
ssh-keygen -R servidor-ssh
```

La próxima vez que conectemos, el cliente ssh preguntará si deseamos conectar y guardar la nueva clave.
