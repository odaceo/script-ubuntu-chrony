#!/bin/bash

# Copyright Odaceo 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

# Start timesyncd when the system starts
sudo systemctl enable systemd-timesyncd.service

# Restart timesyncd
sudo systemctl restart systemd-timesyncd.service
