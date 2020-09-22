#!/bin/bash

cd /root
sed -i -e 's/\r$//' webmin.sh
clear

echo "I am going to install Webmin and update the system for you"
echo ""

echo "   _____ _          _ _    _       _______    _       _ "
echo "  / ____| |        (_) |  | |     |__   __|  | |     | |"
echo " | (___ | |__   ___ _| | _| |__      | | __ _| | __ _| |"
echo "  \___ \| '_ \ / _ \ | |/ / '_ \     | |/ _  | |/ _  | |"
echo "  ____) | | | |  __/ |   <| | | |    | | (_| | | (_| | |"
echo " |_____/|_| |_|\___|_|_|\_\_| |_|    |_|\__ _|_|\__ _|_|"
echo ""

read -n1 -r -p "Press any key to continue..."

apt-get update && apt-get -y full-upgrade

echo "System is upgraded, Now we will install the Webmin Control Panel"

read -n1 -r -p "Press any key to continue..."

apt-get -y install sudo nano curl gnupg gnupg2 net-tools dnsutils git wget apt-transport-https dirmngr speedtest-cli netcat psmisc idn2 sqlite3 libcap2-bin dns-root-data lighttpd php-common php-cgi php-sqlite3 php-xml php-intl perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python

echo 'deb https://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list

cd /root
wget https://download.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc

apt-get update
apt-get -y install webmin

clear

iptables -A INPUT -p tcp -m tcp --dport 10000 -j ACCEPT

apt-get --purge autoremove -y

SERVER_PUB_IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | head -1)

echo ""
echo "========================================================="
echo " Installation is done !!!! Thanks"
echo " It was very easy process"
echo " To use Webmin please use your web browser by surfing:"
read -rp "http://" -e -i "${SERVER_PUB_IP}:10000/" SERVER_PUB_IP
echo " For any inquiry please email me on: talal.zaki@gmail.com"
echo "========================================================="
echo ""
read -n1 -r -p "Press any key to continue..."
