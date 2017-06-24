#License: Apache 2.0
#Warning: make sure to check the configuration in this script before executing.
#	Keep in mind to fix the /etc/hosts file that is written by echo command below
#This script aims to help setting up the central services which are used by more than one VM/application of our group
#!/bin/bash
sudo ./install-vm-software-common.sh
echo "Enter directory server password:" &&
read DSPASSWORD &&
echo "Enter administrator password to use for IPA" &&
read ADMINPASSWORD &&
HOSTNAME="ca" &&
REALM="EXAMPLE.ORG" &&
LOWERCASEREALM=$(echo "$REALM" | tr '[:upper:]' '[:lower:]') &&
IPADOCKERIP="172.17.0.2/16" &&
hostname ${HOSTNAME}.${LOWERCASEREALM} &&
echo "${HOSTNAME}.${LOWERCASEREALM}" > /etc/hostname &&
echo "127.0.0.1 localhost
#192.168.0.108 ${HOSTNAME}.${LOWERCASEREALM} #for local testing
#<IP1> ${HOSTNAME}.${LOWERCASEREALM}
#<IP2> demo.${LOWERCASEREALM}
#<IP3> ci.${LOWERCASEREALM}" > /etc/hosts &&
apt-get install docker docker-compose git -y &&
git clone https://github.com/freeipa/freeipa-container &&
cd freeipa-container &&
docker build -t freeipa-server . &&
mkdir /var/lib/ipa-data &&
echo "--realm=${REALM}
--hostname=${HOSTNAME}.${LOWERCASEREALM}
--mkhomedir
--domain=${REALM}
--ip-address=${IPADOCKERIP}
--ds-password=${DSPASSWORD}
--admin-password=${ADMINPASSWORD}" > /var/lib/ipa-data/ipa-server-install-options &&
ufw allow 53,80,443,389,636,88,464/tcp &&
ufw allow 53,123,88,464/udp &&
docker run -e IPA_SERVER_IP=$IPADOCKERIP -p 53:53/udp -p 53:53 -p 80:80 -p 443:443 -p 389:389 -p 636:636 -p 88:88 -p 464:464 -p 88:88/udp -p 464:464/udp -p 123:123/udp -p 7389:7389 -p 9443:9443 -p 9444:9444 -p 9445:9445 --name freeipa-server-container -ti --privileged=true -h $HOSTNAME.$LOWERCASEREALM -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run --tmpfs /tmp -v /var/lib/ipa-data:/data:Z freeipa-server
