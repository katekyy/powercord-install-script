#!/bin/sh
set echo off
curr_build="v001"

if [ ! -f "$HOME/powercord/instance_*-*" ]; then
    echo "Powercord Is Not Installed!"
    exit 1
fi

sudo echo "Uninstalling Powercord..."

cd ~/powercord/powercord

sudo npm run unplug

cd ..

sudo rm -rf ./powercord/
sudo rm ./instance_*-*

echo "Powercord Successfuly Uninstalled!"
echo "Done!"

exit 0