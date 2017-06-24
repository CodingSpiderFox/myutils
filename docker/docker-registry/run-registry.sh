#following two lines from old version need to be fixed
#mkdir -p /home/user/docker-data/docker-registry &&
#sudo openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 &&

#todo add persistent volume (see old version's docker-compose file)
sudo docker run -d -p 5000:5000 --restart=always --name registry -v `pwd`/configml:/etc/docker/registry/config.yml registry:2

