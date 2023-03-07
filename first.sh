#!/bin/bash
source /etc/profile.d/test.sh
echo $Version
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${ECR_REPO_URL}
docker pull ${ECR_REPO_URL}/${REPO_NAME}:$Version
docker images
CONTAINER_NAME='tailcutter-frontend-${CIRCLE_BRANCH}'
CID=$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME}$)
EXIT=$(docker ps -q -f status=exited -f name=^/${CONTAINER_NAME}$)
if [ "${CID}" ]; then
   echo "Container exists"
   docker-compose -f /home/ubuntu/composetest/docker-compose-${CIRCLE_BRANCH}.yml down
fi

if [ "${EXIT}" ]; then
   echo "Container exists"
   docker rm tailcutter-frontend-${CIRCLE_BRANCH}
fi

if [ "${EXIT}" ]; then
  echo "Container exists"
  docker rm tailcutter-backend-${CIRCLE_BRANCH}
fi


docker run -itd --name tailcutter-frontend-${CIRCLE_BRANCH} ${ECR_REPO_URL}/${REPO_NAME}:$Version 
