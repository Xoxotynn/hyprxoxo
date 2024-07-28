#!/bin/bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

aurhlpr="${1:-yay}"
pkgdir="Packages"

if pkg_installed yay || pkg_installed paru; then
  echo "aur helper is already installed..."
  exit 0
fi

# create directory for git packages if it doesn't exist
if [ -d $HOME/$pkgdir ]; then
  echo "$HOME/$pkgdir directory exists..."
  rm -rf $HOME/$pkgdir/$aurhlpr
else
  mkdir $HOME/$pkgdir
  echo -e "[Desktop Entry]\nIcon=default-folder-git" >$HOME/$pkgdir/.directory
  echo "$HOME/$pkgdir directory created..."
fi

# clone aur helper from aur
if pkg_installed git; then
  git clone https://aur.archlinux.org/"$aurhlpr".git $HOME/$pkgdir/$aurhlpr
else
  echo "git dependency is not installed..."
  exit 1
fi

# install aur helper
cd $HOME/$pkgdir/$aurhlpr || exit
makepkg ${use_default} -si

# check if aur helper is installed
if [ $? -eq 0 ]; then
  echo "$aurhlpr aur helper installed..."
else
  echo "$aurhlpr installation failed..."
  exit 1
fi

echo "installing ${aurhlpr}-git..."
sudo rm /usr/lib/debug/usr/bin/yay.debug
$aurhlpr ${use_default} -S "${aurhlpr}-git"

if pkg_installed "${aurhlpr}-git"; then
  echo "${aurhlpr}-git installed"
  rm -rf $HOME/$pkgdir/$aurhlpr
  $aurhlpr -Rs ${aurhlpr}-debug ${aurhlpr}-git-debug
  exit 0
else
  echo "${aurhlpr}-git installation failed"
  exit 1
fi
