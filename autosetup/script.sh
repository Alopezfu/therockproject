#!/bin/bash

ip=$(hostname -I | cut -d ' ' -f 1)
master=192.168.1.5
workers=(192.168.1.6 192.168.1.7)

function install(){

    wget https://raw.githubusercontent.com/Alopezfu/therockproject/master/autosetup/install4All
    chmod +x ./install4All
    sudo ./install4All
}

function installOnWorkers(){

    echo ' --- Remote install ---'
    for i in "${workers[@]}"
    do
        workerIp=$(ssh -o StrictHostKeyChecking=no kube@$i hostname -I | cut -d ' ' -f 1)
        if [ "$workerIp" == "$i" ];
        then
            ssh -o StrictHostKeyChecking=no kube@$i sudo mkdir /data
            ssh -o StrictHostKeyChecking=no kube@$i wget https://raw.githubusercontent.com/Alopezfu/therockproject/master/autosetup/install4All
            ssh -o StrictHostKeyChecking=no kube@$i chmod +x ./install4All
            ssh -o StrictHostKeyChecking=no kube@$i sudo ./install4All
        else
            echo "Ip no valida."
        fi
    done
}

function installMaster(){

    echo ' --- Install Bind9 ---'
    sudo apt install bind9 -y
    sudo systemctl enable bind9

    echo ' --- Install LAMP ---'
    sudo apt install lamp-server^ -y
}

function swap(){

    echo ' --- Disable Swap ---'
    sudo swapoff -a
    sudo sed -i '$ d' /etc/fstab
}

function sshCopy(){

    echo ' --- Copy SSH Keys ---'
    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y
    sudo apt install sshpass -y
    sshpass -p "kube" ssh-copy-id -o StrictHostKeyChecking=no kube@192.168.1.6
    sshpass -p "kube" ssh-copy-id -o StrictHostKeyChecking=no kube@192.168.1.7
}

function configMaster(){

    echo ' --- Config Bind9 ---'
    sudo mkdir /etc/bind/zonas
    sudo chown kube:kube /etc/bind/ -R
    sudo cat << EOF > /etc/bind/named.conf.local
    zone "rock.com"{
        type master;
        file "/etc/bind/zonas/rock.db";
    };
EOF

    sudo cat << EOF > /etc/bind/zonas/rock.db 
$TTL    604800
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
*.rock.com.   IN  A   192.168.1.7
EOF

    sudo cat << EOF > /etc/bind/named.conf.options
    directory "/var/cache/bind";
    forwarders {
        8.8.8.8;
    };

    dnssec-validation auto;
    auth-nxdomain no;
    listen-on-v6 { any; };
};
EOF
    sudo chown root:root /etc/bind/ -R
    sudo service bind9 restart
    
    echo ' --- Config MySQL ---'
    echo -e "CREATE DATABASE therockproject;
CREATE USER 'dev'@'localhost' IDENTIFIED BY 'dev';
GRANT ALL PRIVILEGES ON therockproject.* TO 'dev'@'localhost';" > script.sql
    
    sudo mysql < script.sql
    rm script.sql

    sudo chown kube:kube /etc/apache2/ -R
    echo ' --- Config Apache ---'
    sudo cat << EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html
    ErrorDocument 404 /404.html
</VirtualHost>"
EOF
    sudo chown root:root /etc/apache2/ -R
    sudo rm /var/www/html/index.html
    git clone https://github.com/Alopezfu/therockproject.git
    sudo cp -r therockproject/admin/* /var/www/html
    sudo mysql < /var/www/html/DDBB.sql
    rm -rf therockproject
}

function nfs(){

    echo ' --- Config NFS ---'
    sudo mkdir /sitios
    sudo chown www-data:root /sitios/ -R
    sudo apt install nfs-kernel-server -y
    sudo chown kube:kube /etc/exports
    sudo cat << EOF > /etc/exports
    /sitios     192.168.1.0/24(rw,sync,no_subtree_check)
EOF
    sudo chown root:root /etc/exports
    sudo exportfs -a 
    sudo systemctl restart nfs-kernel-server
    ssh -o StrictHostKeyChecking=no kube@192.168.1.6 sudo mount 192.168.1.5:/sitios /data
    ssh -o StrictHostKeyChecking=no kube@192.168.1.7 sudo mount 192.168.1.5:/sitios /data
}

function cluster(){

    echo ' --- Cluster Setup ---'
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --v=5 > salida
    cat salida | tail -2 > joinOut
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    scp -o StrictHostKeyChecking=no joinOut kube@192.168.1.6:/home/kube/
    ssh -o StrictHostKeyChecking=no kube@192.168.1.6 chmod +x ./joinOut
    ssh -o StrictHostKeyChecking=no kube@192.168.1.6 sudo ./joinOut
    scp -o StrictHostKeyChecking=no joinOut kube@192.168.1.7:/home/kube/
    ssh -o StrictHostKeyChecking=no kube@192.168.1.7 chmod +x ./joinOut
    ssh -o StrictHostKeyChecking=no kube@192.168.1.7 sudo ./joinOut
    rm joinOut salida
    sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    sudo kubectl apply -f https://raw.githubusercontent.com/Alopezfu/therockproject/master/traefik/apply-traefik.yml
    sudo cp -r /home/kube/.kube /var/www/html/php/
    sudo chown www-data:www-data /var/www/html -R
    sudo chmod 755 /var/www/html -R
}

function main(){

    if [ "$ip" == "$master" ];
    then
        sshCopy
        install
        installOnWorkers
        installMaster
        swap
        configMaster
        nfs
        cluster
    else
        echo "Ip no valida."
    fi
}

main

