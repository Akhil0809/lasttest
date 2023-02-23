#!/bin/bash
#source .env
echo $Version
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
#sudo ./aws/install
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install docker docker-compose -y
#export $(cat .env | egrep -v "(^#.*|^$)" | xargs)
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_REPO_URL
docker pull $ECR_REPO_URL/$REPO_NAME:$Version
docker images
docker run -itd --name test-container-ssh-test $ECR_REPO_URL/$REPO_NAME:$Version
