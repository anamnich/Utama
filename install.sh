#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

clear

installTheme(){
    cd /var/www/
    tar -cvf Utamabackup.tar.gz pterodactyl
    echo "Installing theme..."
    cd /var/www/pterodactyl
    rm -r Utama
    git clone https://github.com/anamnich/Utama.git
    cd Utama
    rm /var/www/pterodactyl/resources/scripts/Utama.css
    rm /var/www/pterodactyl/resources/scripts/index.tsx
    mv index.tsx /var/www/pterodactyl/resources/scripts/index.tsx
    mv Utama.css /var/www/pterodactyl/resources/scripts/Utama.css
    cd /var/www/pterodactyl

    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    apt update
    apt install -y nodejs

    npm i -g yarn
    yarn

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear


}

installThemeQuestion(){
    while true; do
        read -p "Are you sure that you want to install the theme [y/n]? " yn
        case $yn in
            [Yy]* ) installTheme; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

repair(){
    bash <(curl https://raw.githubusercontent.com/anamnich/Utama/main/repair.sh)
}

restoreBackUp(){
    echo "Restoring backup..."
    cd /var/www/
    tar -xvf Utamabackup.tar.gz
    rm Utamabackup.tar.gz

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear
}
echo "ZassXdOfficial"
echo "AUTO INSTALL THEME"
echo ""
echo "Wa: +63 822-1887-6020"
echo "Nama: ZassXd Official"
echo ""
echo "Install theme"

read -p "Please enter a number: " choice
if [ $choice == "1" ]
    then
    installThemeQuestion
fi
if [ $choice == "2" ]
    then
    restoreBackUp
fi
if [ $choice == "3" ]
    then
    repair
fi
if [ $choice == "4" ]
    then
    exit
fi
