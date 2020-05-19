#!/bin/bash

USERNAME=$1

cat deployment/deploy.yml > deployment/deploy_now.yml

sed -i 's/alopezfu/'$USERNAME'/g' deployment/deploy_now.yml

# kubectl apply -f deployment/deploy_now.yml

#rm -rf deployment/$WORKDIR/
