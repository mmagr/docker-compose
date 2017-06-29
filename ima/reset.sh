#!/bin/bash -x

ROOTP="/opt/deploy/0.0.0-hackathon/"
SPATH="/home/matheus-cpqd"
USER=$(hostname | grep -oP '\d{2}')

cd $ROOTP/public
docker-compose down

docker-compose up -d
sleep 60
$ROOTP/kong.config.sh
$SPATH/create.user.sh

cd $SPATH/data/dc
$SPATH/data/dc/loadData.py -r public -u team_$USER -p $(cat /tmp/team$USER.passwd)

cd $SPATH/data/tp
$SPATH/data/tp/loadData.py -r public -u team_$USER -p $(cat /tmp/team$USER.passwd) -f $SPATH/data/tp/sample.csv

