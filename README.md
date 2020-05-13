# The Rock Project

En este proyecto explicamos como levantar tu propio cluster de kubernetes y te cedmos todo el codigo fuente para que tu puedeas hostear paginas a todo el mundo!!

	> La documentación está en https://alopezfu.github.io/therockproject/

## La web

Una vez creado el cluster puedes levantar la web hacindo un clon de este repo y ponindo el contendio de la carpeta admin en tu web para que los usuarios se registren!

## Vagrant

Hemos decidido autorizar el desplegué completo del proyecto con la ayuda de Vagrant, puedes levantar el proyecto con esta simple secuencia de comandos:

```bash
git clone https://github.com/Alopezfu/therockproject.git
cd therockproject/vagrant
vagrant up
```
<<<<<<< HEAD

El proceso es algo demorado, puesto que se aplican todos los pasos mostrados en la documentación oficial.
Para obtener la shell:
vagrant ssh kubeMaster/kubeWorker1/kubeWorker2
=======
>>>>>>> 6ef0b0213390bf868e191f13e9e24e45c7ead273
