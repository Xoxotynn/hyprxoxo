#!/bin/bash

set -e

CloneDir=$(dirname $(dirname $(realpath $0)))
GitPkgDir=$HOME/Packages

service_ctl() {
  local ServChk=$1

  if [[ $(systemctl list-units --all -t service --full --no-legend "${ServChk}.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "${ServChk}.service" ]]; then
    echo "$ServChk service is already enabled, enjoy"
  else
    echo "$ServChk service is not running, enabling..."
    sudo systemctl enable "${ServChk}".service
    sudo systemctl start "${ServChk}".service
    echo "$ServChk service enabled, and running"
  fi
}

pkg_installed() {
  pacman -Qi "$1" &>/dev/null
  return $?
}

pkg_available() {
  pacman -Si "$1" &>/dev/null
  return $?
}

chk_aurh() {
  if pkg_installed yay; then
    aurhlpr="yay"
  elif pkg_installed paru; then
    aurhlpr="paru"
  fi
}

aur_available() {
  chk_aurh
  $aurhlpr -Si "$1" &>/dev/null
  return $?
}
