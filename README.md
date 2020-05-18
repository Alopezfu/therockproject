# The Rock Project

En este proyecto explicamos como levantar tu propio cluster de kubernetes y te cedmos todo el codigo fuente para que tu puedeas hostear paginas a todo el mundo!!

	> La documentación está en https://alopezfu.github.io/therockproject/

## La web

Una vez creado el cluster puedes levantar la web hacindo un clon de este repo y ponindo el contendio de la carpeta admin en tu web para que los usuarios se registren!

## Autos setup del proyecto

Hemos decidido autorizar el desplegué completo del proyecto con Bash, puedes levantar el proyecto con esta simple secuencia de comandos (primero debes constar con el sistema operativo instalado y la configuración de red que se muestra en los docs oficiales):

Workers primero:
```bash
git clone https://github.com/Alopezfu/therockproject.git
cd therockproject/autosetup
chmod +x ./script-workers.sh
sudo ./$_
```

Una vez ejecutada la parte de los workeres, en el master:
```bash
git clone https://github.com/Alopezfu/therockproject.git
cd therockproject/autosetup
chmod +x ./script-master.sh
sudo ./$_
```
