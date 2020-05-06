#!/bin/bash

USERNAME=$1
WORKDIR='dir_'$USERNAME

mkdir $WORKDIR
cat deploy.yml > $WORKDIR/deploy.yml

sed -i 's/alopezfu/'$USERNAME'/g' $WORKDIR/deploy.yml

kubectl apply -f $WORKDIR/deploy.yml 

#rm -rf $WORKDIR/
