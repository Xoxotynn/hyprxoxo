#!/bin/bash

source ./scripts/functions.sh
if [ $? -ne 0 ]; then
  echo "Error: failed to source functions.sh, please execute from $(dirname $(realpath $0))..."
  exit 1
fi

# services
if [ ! -f /etc/systemd/system/lockgpuconf.service ]; then
  sudo cp $CloneDir/services/lockgpuconf.service /etc/systemd/system/
  sudo cp $CloneDir/services/lockgpuclock /usr/bin/
fi

# rules
if [ ! -f /etc/udev/rules.d/81-bluetooth-hci.rules ]; then
  sudo cp $CloneDir/rules/81-bluetooth-hci.rules /etc/udev/rules.d/
else
  cat $CloneDir/rules/81-bluetooth-hci.rules | sudo tee -a /etc/udev/rules.d/81-bluetooth-hci.rules
fi
