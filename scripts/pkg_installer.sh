#!/bin/bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

# check if debugedit is installed
if ! pkg_installed debugedit; then
  echo "installing dependency debugedit..."
  sudo pacman -S debugedit
fi

# check if fakeroot is installed
if ! pkg_installed fakeroot; then
  echo "installing dependency fakeroot..."
  sudo pacman -S fakeroot
fi

# check if git is installed
if ! pkg_installed git; then
  echo "installing dependency git..."
  sudo pacman -S git
fi

# find out which aur helper is installed and set it to aurhlpr
chk_aurh

if [ -z "$aurhlpr" ]; then
  echo -e "Select aur helper to install packages:\n1) yay\n2) paru"
  read -r -p "Enter number: " aurhlpr

  case $aurhlpr in
  1) aurhlpr="yay" ;;
  2) aurhlpr="paru" ;;
  *) echo "invalid option, exiting..." && exit 1 ;;
  esac

  echo "installing dependency $aurhlpr..."
  ./scripts/install_aur.sh "$aurhlpr" 2>&1
fi

# install packages from install_pkg.lst
install_list="${1:-./lists/install_pkg.lst}"

while read -r pkg; do
  if [ -z "$pkg" ]; then
    continue
  fi

  if pkg_installed "$pkg"; then
    echo "$pkg is already installed..."
  elif pkg_available "$pkg" | aur_available "$pkg"; then
    echo "queueing $pkg..."
    pkg_lst+="$pkg "
  else
    echo "error: $pkg not found in arch or aur repo..."
  fi
done < <(cut -d '#' -f 1 "$install_list")

if [ -n "$pkg_lst" ]; then
  echo "installing ${pkg_lst}..."
  $aurhlpr ${use_default} -S $pkg_lst
fi
