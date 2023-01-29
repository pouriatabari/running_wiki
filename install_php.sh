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

install_php_debian(){
        apt update -y
        apt upgrade -y
        apt install software-properties-common -y
        add-apt-repository ppa:ondrej/php -y
        apt install php7.4 -y
        apt install php7.4-{cli,common,curl,zip,gd,mysql,xml,mbstring,json,intl} -y
        update-alternatives --config php
                        }

install_php_centos(){
        yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
        yum -y install yum-utils
        yum-config-manager --enable remi-php74
        yum -y update
        yum -y install php php-cli
        yum -y install php  php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json
        }


install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        install_php_centos
    else
        install_php_debian
    fi
}

install_base
