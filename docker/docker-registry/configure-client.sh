sudo mkdir /etc/systemd/system/docker.service.d
sudo touch /etc/systemd/system/docker.service.d/docker.conf

sudo echo "[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// --insecure-registry <IP>:<PORT> --registry-mirror=http://<IP>:<PORT>" > /etc/systemd/system/docker.service.d/docker.conf

sudo systemctl daemon-reload
sudo systemctl restart docker
