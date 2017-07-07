#!/bin/bash -x

ROOTP="/opt/deploy/0.0.0-hackathon2/"
SPATH="/home/matheus-cpqd"
USER=$(hostname | grep -oP '\d{2}')

cd $ROOTP/public
docker-compose down

cat <<END | tee certs/default.conf
upstream kong {
  server apigw:8000;
}

server {
    listen 443;
    server_name  $1;

    ssl on;
    ssl_certificate /certs/live/$1/fullchain.pem;
    ssl_certificate_key /certs/live/$1/privkey.pem;

    location / {
        proxy_pass http://kong;
        proxy_redirect off;
    }
}

server {
    listen 80;
    server_name $1;
    return 301 https://\$server_name\$request_uri;
}
END


docker-compose up -d
sleep 60
$ROOTP/kong.config.sh
$SPATH/create.user.sh

cd $SPATH/data/dc
$SPATH/data/dc/loadData.py -r public -u team_$USER -p $(cat /tmp/team$USER.passwd)
cd $SPATH/data/tp
$SPATH/data/tp/loadData.py -r public -u team_$USER -p $(cat /tmp/team$USER.passwd) -f $SPATH/data/tp/sample.csv

