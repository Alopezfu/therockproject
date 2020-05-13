#!/bin/bash

USERNAME=$1
WORKDIR='dir_'$USERNAME

mkdir deployment/$WORKDIR
cat deployment/deploy.yml > deployment/$WORKDIR/deploy.yml

sed -i 's/alopezfu/'$USERNAME'/g' deployment/$WORKDIR/deploy.yml

<<<<<<< HEAD
kubectl apply -f deployment/$WORKDIR/deploy.yml
=======
sudo -u kube "kubectl apply -f deployment/$WORKDIR/deploy.yml" 
>>>>>>> 6ef0b0213390bf868e191f13e9e24e45c7ead273

#rm -rf deployment/$WORKDIR/
