#!/bin/bash

cat <<"EOF"

+--------------------------------+
____  ___                  
\   \/  /_______  _______  
 \     //  _ \  \/  /  _ \ 
 /     (  <_> >    <  <_> )
/___/\  \____/__/\_ \____/ 
      \_/          \/   
+--------------------------------+

EOF

#--------------------------------#
# import variables and functions #
#--------------------------------#
source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

#------------------#
# evaluate options #
#------------------#
flg_Install=0
flg_Ricing=0
flg_Service=0

while getopts idrs RunStep; do
  case $RunStep in
  i) flg_Install=1 ;;
  d)
    flg_Install=1
    export use_default="--noconfirm"
    ;;
  r) flg_Ricing=1 ;;
  s) flg_Service=1 ;;
  *)
    echo "...valid options are..."
    echo "i : [i]nstall hyprland without configs"
    echo "d : install hyprland [ d]efaults without configs --noconfirm"
    echo "r : [r]ice hyprland with custom configs"
    echo "s : enable system [s]ervices"
    exit 1
    ;;
  esac
done

if [ $OPTIND -eq 1 ]; then
  flg_Install=1
  flg_Ricing=1
  flg_Service=1
fi

#------------#
# installing #
#------------#
if [ $flg_Install -eq 1 ]; then
  cat <<"EOF"

 _         _       _ _ _         
|_|___ ___| |_ ___| | |_|___ ___ 
| |   |_ -|  _| .'| | | |   | . |
|_|_|_|___|_| |__,|_|_|_|_|_|_  |
                            |___|

EOF

  #----------------------#
  # prepare package list #
  #----------------------#
  shift "$((OPTIND - 1))"
  custom_pkg=$1
  cp ./lists/default_pkg.lst ./lists/install_pkg.lst

  if [ -f "$custom_pkg" ] && [ -z "$custom_pkg" ]; then
    cat "$custom_pkg" >>./lists/install_pkg.lst
  fi

  #--------------------------------#
  # install packages from the list #
  #--------------------------------#
  ./scripts/pkg_installer.sh ./lists/install_pkg.lst 2>&1

  rm ./lists/install_pkg.lst

  echo "packages installed, continuing..."
fi

#----------------------------#
# ricing with custom configs #
#----------------------------#
if [ $flg_Ricing -eq 1 ]; then
  cat <<"EOF"
     
     _     _         
 ___|_|___|_|___ ___ 
|  _| |  _| |   | . |
|_| |_|___|_|_|_|_  |
                |___|

EOF
  # install fonts and icons
  ./scripts/install_fnt.sh

  # install configs
  ./scripts/install_cfg.sh

  # install wine, dxvk and vkd3d
  ./scripts/install_wine.sh

  # install amnezia vpn client
  ./scripts/install_amneziavpn.sh
fi

#-------------------------------------------#
# update sddm, grub, zsh and dnscrypt-proxy #
#-------------------------------------------#
if [ $flg_Install -eq 1 ] && [ $flg_Ricing -eq 1 ]; then
  ./scripts/install_etc.sh
fi

#------------------------#
# enable system services #
#------------------------#
if [ $flg_Service -eq 1 ]; then
  cat <<"EOF"

                 _             
 ___ ___ ___ _ _|_|___ ___ ___ 
|_ -| -_|  _| | | |  _| -_|_ -|
|___|___|_|  \_/|_|___|___|___|

EOF

  ./scripts/install_services.sh

  while read -r service; do
    service_ctl "$service"
  done <./lists/system_ctl.lst

fi
