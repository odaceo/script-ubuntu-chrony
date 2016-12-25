#!/bin/bash

# Update your local package index
sudo apt-get update

# Install the Chrony package and its dependencies
sudo apt-get -y install chrony

# Start Chrony when the system starts
sudo systemctl enable chrony

# Start Chrony
sudo systemctl start chrony
