#!/bin/bash

function installDocker(){

    apt install docker.io -y
    usermod -aG docker $USER
    systemctl enable docker
    echo -e '
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m"
},
    "storage-driver": "overlay2"
}' > /etc/docker/daemon.json

    mkdir -p /etc/systemd/system/docker.service.d
    systemctl daemon-reload
    systemctl restart docker
}

function installKubernetes(){

    apt install software-properties-common curl -y
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
    apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    apt install kubeadm -y
}

function swap(){

    swapoff -a
    sed -i '$ d' /etc/fstab
}

function main(){

    apt update
    apt upgrade -y
    installDocker
    installKubernetes
    swap
}

main