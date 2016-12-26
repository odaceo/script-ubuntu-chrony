#!/bin/bash

# Init variables
NTP=${1}
FallbackNTP=${2:-'0.ubuntu.pool.ntp.org 1.ubuntu.pool.ntp.org 2.ubuntu.pool.ntp.org 3.ubuntu.pool.ntp.org'}

# Check preconditions
if [ -z "${NTP}" ]; then
    echo 'The NTP server list is required.'
    exit 1
fi

# Enable time syncronization
sudo timedatectl set-ntp true 

# Configure NTP Servers
sudo sed -i "s|^[#]*NTP=.*|NTP=${NTP}|" /etc/systemd/timesyncd.conf
sudo sed -i "s|^[#]*FallbackNTP=.*|FallbackNTP=${FallbackNTP}|" /etc/systemd/timesyncd.conf

# Restart timesyncd
sudo systemctl restart systemd-timesyncd.service
