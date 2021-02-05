#!/bin/bash
set -e
#assert AWS CLI installed
#assert APP_NAME=IMAGE_NAME
#package container image
docker build -f "$(pwd)"/../../spring-runtime-container/Dockerfile  "$(pwd)"/../../$APP_NAME -t $APP_NAME:$IMAGE_VERSION

#login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REGISTRY_NAME

#push the newly built image to ECR
docker tag $APP_NAME:$IMAGE_VERSION $REGISTRY_NAME/$APP_NAME:$IMAGE_VERSION
docker push $REGISTRY_NAME/$APP_NAME:$IMAGE_VERSION

