#!/bin/bash

USERNAME=$1

cat deployment/deploy.yml > deployment/deploy_now.yml

sed -i 's/alopezfu/'$USERNAME'/g' deployment/deploy_now.yml

