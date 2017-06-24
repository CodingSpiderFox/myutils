#License: Apache 2.0
#This script aims to automatically install docker-ce and docker-compose on ubuntu
#!/bin/bash
sudo sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y &&
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update &&
sudo apt-get install docker-ce -y &&
sudo docker run hello-world &&

sudo curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose &&
sudo sudo chmod +x /usr/local/bin/docker-compose &&
sudo systemctl enable docker &&

