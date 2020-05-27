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

function installBind9(){

    apt install bind9 -y
    systemctl enable bind9
}

function installLAMP(){

    apt install lamp-server^ -y

}

# Configuradores
function configBind9(){

    mkdir /etc/bind/zonas
    echo -e 'zone "rock.com"{
    type master;
    file "/etc/bind/zonas/rock.db";
};' > /etc/bind/named.conf.local

    echo -e "\$TTL    604800
@   IN  SOA rock.com. root.rock.com. (
                   2
              604800
               86400
             2419200
              604800 )
;

@   IN  NS  rock.com.
rock.com.   IN  A   192.168.1.5
*.rock.com.  IN  A   192.168.1.6
*.rock.com.   IN  A   192.168.1.7" > /etc/bind/zonas/rock.db

    echo -e 'options {
    directory "/var/cache/bind";
    forwarders {
        8.8.8.8;
    };

    dnssec-validation auto;
    auth-nxdomain no;
    listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

    service bind9 restart
}

function configMysql(){

    echo -e "CREATE DATABASE therockproject;
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';
GRANT ALL PRIVILEGES ON therockproject.* TO 'dev'@'localhost';" > script.sql
    
    mysql < script.sql
    rm script.sql
}

function configApache(){

    echo -e "<VirtualHost *:80>
    DocumentRoot /var/www/html
    ErrorDocument 404 /404.html
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf

    rm /var/www/html/index.html
    git clone https://github.com/Alopezfu/therockproject.git
    cp -r therockproject/admin/* /var/www/html
    mysql < /var/www/html/DDBB.sql
    rm -rf therockproject
}

function swap(){

    swapoff -a
    sed -i '$ d' /etc/fstab
}

function sshSetup(){

    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y
    apt install sshpass -y
    sshpass -p "kube" ssh-copy-id kube@192.168.1.6
    sshpass -p "kube" ssh-copy-id kube@192.168.1.7
}

function cluster(){

    kubeadm init --pod-network-cidr=10.244.0.0/16 --v=5 > salida
    cat salida | tail -2 > joinOut
    mkdir -p $HOME/.kube
    cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config
    scp joinOut kube@192.168.1.6:/home/kube/
    ssh kube@192.168.1.6 chmod +x ./joinOut
    ssh kube@192.168.1.6 sudo ./joinOut
    scp joinOut kube@192.168.1.7:/home/kube/
    ssh kube@192.168.1.7 chmod +x ./joinOut
    ssh kube@192.168.1.7 sudo ./joinOut
    rm joinOut salida
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    kubectl apply -f https://raw.githubusercontent.com/Alopezfu/therockproject/master/traefik/apply-traefik.yml
    cp -r /home/kube/.kube /var/www/html/php/
    chown www-data:www-data /var/www/html -R
    chmod 755 /var/www/html -R
}

function nfs(){

    mkdir /sitios
    apt install nfs-kernel-server -y
    echo -e "/sitios \t 192.168.1.0/24(rw,sync,no_subtree_check)" >> /etc/exports
    exportfs -a 
    systemctl restart nfs-kernel-server
}

function main(){

    apt update
    apt upgrade -y
    installDocker
    installKubernetes
    installBind9
    installLAMP
    sshSetup

    configBind9
    configMysql
    configApache

    swap
    cluster
    nfs
}

main
