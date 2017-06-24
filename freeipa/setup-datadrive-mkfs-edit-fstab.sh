#License: Apache 2.0
#This script aims to automatically  FORMAT, setup and mount the additional drive of a VM
#!/bin/bash
sudo mkdir -p /mnt/data &&
sudo chown -R pgstream:pgstream /mnt &&
sudo mkfs -t ext4 &&
sudo echo "/dev/sdb1 /mnt/data ext4 defaults 0 0" >> /etc/fstab &&
sudo mount -a
