#!/bin/bash
source .env
echo $Version
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo apt-get update 
sudo apt-get upgrade -y 
sudo apt-get install docker docker-compose -y
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 310961312410.dkr.ecr.ap-south-1.amazonaws.com
docker pull 310961312410.dkr.ecr.ap-south-1.amazonaws.com/test:$Version
docker images
git init
export $(cat .env | egrep -v "(^#.*|^$)" | xargs)
docker run -itd --name test-container-$containername 310961312410.dkr.ecr.ap-south-1.amazonaws.com/test:$Version 
