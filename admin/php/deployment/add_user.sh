#!/bin/bash

USERNAME=$1
WORKDIR='dir_'$USERNAME

mkdir deployment/$WORKDIR
cat deployment/deploy.yml > deployment/$WORKDIR/deploy.yml

sed -i 's/alopezfu/'$USERNAME'/g' deployment/$WORKDIR/deploy.yml

kubectl apply -f deployment/$WORKDIR/deploy.yml

kubectl apply -f deployment/$WORKDIR/deploy.yml

#rm -rf deployment/$WORKDIR/
