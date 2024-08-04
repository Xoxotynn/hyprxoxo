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
curl -s https://api.github.com/repos/amnezia-vpn/amnezia-client/releases/latest \
| grep '"browser_download_url":.*AmneziaVPN_Linux_.*\.tar\.zip' \
| awk '{print $2}' \
| tr -d '"' \
| wget -i -

# extract installer
7z e $(ls -1 | grep AmneziaVPN)
tar -xvf AmneziaVPN_Linux_Installer.tar
rm $(ls -1 | grep 'AmneziaVPN.*zip$') AmneziaVPN_Linux_Installer.tar

# start GUI installation
QT_QPA_PLATFORM=xcb ./AmneziaVPN_Linux_Installer.bin

rm AmneziaVPN_Linux_Installer.bin