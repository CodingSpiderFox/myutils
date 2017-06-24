#License: Apache 2.0
#This script aims to automatically setup the apt-cacher client configuration
#!/bin/bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak &&
sudo sed -i 's/de.archive.ubuntu.com/IP:3142/g' /etc/apt/sources.list &&
sudo sed -i 's/us.archive.ubuntu.com/IP:3142/g' /etc/apt/sources.list
