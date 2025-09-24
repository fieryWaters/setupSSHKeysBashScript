#!/bin/bash

# Check for root permissions
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update /etc/systemd/logind.conf to ignore lid switch events
sed -i '/^#HandleLidSwitch=suspend/s/^#//' /etc/systemd/logind.conf
sed -i '/HandleLidSwitch=suspend/c\HandleLidSwitch=ignore' /etc/systemd/logind.conf

# Restart systemd-logind service
if systemctl --version &> /dev/null ; then
    systemctl restart systemd-logind
else
    service systemd-logind restart
fi

echo "Lid switch behavior updated. System will no longer suspend when the lid is closed."
