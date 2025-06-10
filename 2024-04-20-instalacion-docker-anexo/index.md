# Instalación de docker. Annexo

Ya habia escrito un [articulo](/2020-03-08-rpi-usando-docker) sobre la instalación de docker, pero lo explicaba para hacer la instalación en una Raspberry, pero ahora lo voy a explicar para su instalación en un equipo normal y corriente. Más concretamente en **Debian GNU/Linux** y asi, lo tengo más a mano y no tengo que volverme loco buscando esta información en internet, porque si sigo el de la Raspberry, al final no funciona correctamente.

<!--more-->

Antes nada tenemos que validar si tenemos las aplicaciones necesarias para poder, al menos, instalar **docker**:
```bash
usuari@debian:~$sudo apt-get update
usuari@debian:~$sudo apt-get install ca-certificates curl
usuari@debian:~$sudo install -m 0755 -d /etc/apt/keyrings
usuari@debian:~$sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
usuari@debian:~$sudo chmod a+r /etc/apt/keyrings/docker.asc

# AFEGIM EL REPOSITORI A LES FONTS
usuari@debian:~$echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# ACTUALITZEM EL SISTEMA
usuari@debian:~$sudo apt-get update
```
Procedemos, ahora si, a la instalación de **docker**:
```bash
usuari@debian:~$sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
Ahora solamente, yo siempre lo hago, seguramente no se tendria que hacer pero, es añadir mi usuario al grupo de docker:
```bash
usuari@debian:~$sudo usermod -aG docker ${USER}
```
Con esto, ya tenemos instalado **docker** en nuestro sistema.
#### Referencia
- [Install docker on Debian](https://docs.docker.com/engine/install/debian)
- [Raspberry Pi. Pasos para instalar Docker en Raspbian](/2020-03-08-rpi-usando-docker)

