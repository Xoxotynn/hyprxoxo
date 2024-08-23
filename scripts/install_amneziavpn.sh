#!/bin/bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

#----------------------------#
# install amnezia vpn client #
#----------------------------#

# download latest .tar.zip release from github
curl -s https://api.github.com/repos/amnezia-vpn/amnezia-client/releases/latest |
  grep '"browser_download_url":.*AmneziaVPN_Linux_.*\.tar\.zip' |
  awk '{print $2}' |
  tr -d '"' |
  xargs curl -L -O

# extract installer
if [ ! -d ./installers ]; then
  mkdir installers
fi

if [ -z "$( ls -A './installers' )" ]; then
  rm -rf ./installers/*
fi

7z e $(ls -1 | grep AmneziaVPN)
tar -xvf AmneziaVPN_Linux_Installer.tar -C installers
rm $(ls -1 | grep 'AmneziaVPN.*zip$') AmneziaVPN_Linux_Installer.tar
