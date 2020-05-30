# The Rock Project

![alt text](https://github.com/Alopezfu/therockproject/blob/master/docs/img/1.png "Logo")

En este proyecto explicamos como levantar tu propio cluster de kubernetes y te cedmos todo el codigo fuente para que tu puedeas hostear paginas a todo el mundo!!

	> La documentación está en https://alopezfu.github.io/therockproject/

## La web

Una vez creado el cluster puedes levantar la web hacindo un clon de este repo y ponindo el contendio de la carpeta admin en tu web para que los usuarios se registren!

## Autos setup del proyecto

Hemos decidido autorizar el desplegué completo del proyecto con Bash, puedes levantar el proyecto con esta simple secuencia de comandos (primero debes contar con el sistema operativo instalado y la configuración visudo y de red que se muestra en los docs oficiales):

En el master:
```bash
wget https://raw.githubusercontent.com/Alopezfu/therockproject/master/autosetup/script.sh
chmod +x ./script.sh
sudo ./$_
```
