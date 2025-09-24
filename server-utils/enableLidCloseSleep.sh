#!/bin/bash

# Check for root permissions
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Revert /etc/systemd/logind.conf to default behavior for lid switch
sed -i '/HandleLidSwitch=ignore/c\#HandleLidSwitch=suspend' /etc/systemd/logind.conf

# Restart systemd-logind service
if systemctl --version &> /dev/null ; then
    systemctl restart systemd-logind
else
    service systemd-logind restart
fi

echo "Lid switch behavior reverted to default. System will suspend when the lid is closed."
