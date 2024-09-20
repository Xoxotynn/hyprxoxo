#!/bin/bash

source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

# rules
if [ ! -f /etc/udev/rules.d/81-bluetooth-hci.rules ]; then
  sudo cp $CloneDir/rules/81-bluetooth-hci.rules /etc/udev/rules.d/
else
  cat $CloneDir/rules/81-bluetooth-hci.rules | sudo tee -a /etc/udev/rules.d/81-bluetooth-hci.rules
fi

if [ ! -f /etc/udev/rules.d/30-amdgpu-high-power.rules ]; then
  sudo cp $CloneDir/rules/30-amdgpu-high-power.rules /etc/udev/rules.d/
else
  cat $CloneDir/rules/30-amdgpu-high-power.rules | sudo tee -a /etc/udev/rules.d/30-amdgpu-high-power.rules
fi