#!/bin/bash

function installDocker(){

    apt install docker.io -y
    usermod -aG docker $USER
    systemctl enable docker
}

function installKubernetes(){

    apt install software-properties-common curl -y
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
    apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    apt install kubeadm -y
}

function main(){

    apt update
    apt upgrade -y
    installDocker
    installKubernetes    
}

main