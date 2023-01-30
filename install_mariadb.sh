#!/bin/bash

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}THIS SCRIPT IS NOT COMPATIBLE WITH YOUR OS${plain}\n" && exit 1
fi

install_mariadb_debian(){
        apt update -y
        apt upgrade -y
        apt install mariadb-server
        systemctl enable --now mariadb
                                }

install_mariadb_centos(){
     yum install mariadb-server.x86_64 -y
     systemctl enable --now mariadb
        }


install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        install_mariadb_centos
    else
        install_mariadb_debian
    fi
}

install_base
