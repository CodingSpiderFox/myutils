#/!bin/bash

docker run freeipa-server-container -ti \
   --net ipanet \
   -h ipa.example.org \
   -e IPA_SERVER_IP=10.0.0.1 \
   -p 53:53/udp -p 53:53 \
   -p 80:80 -p 443:443 -p 389:389 -p 636:636 -p 88:88 -p 464:464 \
   -p 88:88/udp -p 464:464/udp -p 123:123/udp -p 7389:7389 \
   -p 9443:9443 -p 9444:9444 -p 9445:9445  \
   -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
   --tmpfs /run --tmpfs /tmp \
   --cap-add SYS_ADMIN \
   -v /var/docker-data/ipa-server:/data:Z 