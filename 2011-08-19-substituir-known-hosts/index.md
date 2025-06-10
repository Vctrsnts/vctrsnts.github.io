# Sustituir una clave antigua de known_hosts

Es posible que más de una vez nos hayamos encontrado con un mensaje donde nuestro sistema nos indica que la clave publica de nuestro servidor, o del servidor al que nos queremos conectar ha cambiado o a otras posibilidades que ya indicaremos más adelante.

<!--more-->

```bash
usuari@debian:~$ ssh servidor-ssh
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ WARNING: REMOTE 
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

Este error se produce debido a ha fallado la que ha fallado la autenticación de la clave pública ssh del servidor. Esto podría ser debido a:
- Un intento de ataque *man in the middle*.
- Reinstalación del sistema donde se esta ejecutando `SSH` y no nos hemos acordado de hacer una copia de su clave. 

Esto provoca que por seguridad, en clientes configurados con la opción `StrictHostKeyChecking=yes` no te permita conectar al servidor.

Una manera rápida de solucionar esto sería conectar forzando ignorar este aviso:
```bash
usuari@debian:~$ ssh -o "StrictHostKeyChecking=yes" servidor-ssh
```

Por supuesto, esta no es la manera más adecuada de hacerlo, primero, porque si lo hacemos sin ninguna comprobación podríamos ser víctimas de ataque que hablábamos antes, y segundo, porque el aviso no desaparecerá en futuras conexiones.

Si efectivamente verificamos que se trata de una simple cambio de IP, DNS o reinstalación de sistema (comprobando que el nuevo fingerprint coincide con el del servidor), tenemos que borrar la clave vieja. 

Antiguamente, podíamos editar el archivo `~/.ssh/known_hosts` directamente, pero actualmente los nombres de los hosts en este archivo estan *ocultos* mediante HMAC. Es por ello que para borrar dicha clave tendremos que ejecutar:
```bash
usuari@debian:~$ ssh-keygen -R servidor-ssh
```

La próxima vez que conectemos, el cliente ssh preguntará si deseamos conectar y guardar la nueva clave.
#### Referencia

