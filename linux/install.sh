#!/bin/sh
set echo off
curr_build="b001"

if [ -d "$HOME/powercord/instance_*-*" ]; then
    echo "Powercord Alredy Installed!"
    exit 1
fi

curr_distro=$(cat /etc/*-release | grep "^ID=" | cut -d "=" -f 2)

if [ $curr_distro == *"ubuntu"* ]; then
    curr_distro_pkgmng="apt-get install -y"
elif [ $curr_distro == *"arch"* ]; then
    curr_distro_pkgmng="pacman -S --noconfirm"
elif [ $curr_distro == *"fedora"* ]; then
    curr_distro_pkgmng="dnf install"
elif [ $curr_distro == *"cent"* ]; then
    curr_distro_pkgmng="yum install"
elif [ $curr_distro == *"suse"* ]; then
    curr_distro_pkgmng="zypper install"
elif [ $curr_distro == *"void"* ]; then
    curr_distro_pkgmng="xbps-install -S"
elif [ $curr_distro == *"solus"* ]; then
    curr_distro_pkgmng="eopkg install"
elif [ $curr_distro == *"debian"* ]; then
    curr_distro_pkgmng="apt-get install -y"
else
    echo "Unsupported Distro!"
    exit 1
fi

set echo on
sudo echo "Installing Powercord..."
set echo off

sudo $curr_distro_pkgmng grep

if ! ls /bin | grep "git"; then
    echo "Installing Git..."
    sudo $curr_distro_pkgmng git
fi

if ! ls /bin | grep "node"; then
    echo "Installing NodeJS..."
    sudo $curr_distro_pkgmng nodejs
fi

if ! ls /bin | grep "npm"; then
    echo "Installing NPM..."
    sudo $curr_distro_pkgmng npm
fi

cd ~
mkdir powercord
cd powercord

git clone "https://github.com/powercord-org/powercord"
cd powercord

echo "Installing dependencies..."
npm i

echo "Plugging into Discord..."
sudo npm run plug

touch "$HOME/powercord/instance_$curr_build-$(date +%D)_$(date +%T)"
set echo on
echo "Powercord Successfuly Installed!"
echo "Done!"