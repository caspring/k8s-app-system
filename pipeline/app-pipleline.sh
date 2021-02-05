#!/bin/bash
set -x
set -e



POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    howtouse
    ;;
    -s|--service-name)
    SERVICE_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -iv|--image-version)
    IMAGE_VERSION="$2"
    shift # past argument
    ;;
    -r|--relese-name)
    RELEASE_NAME="$2"
    shift # past argument
    ;;
    -sb|--skip-build)
    SKIP_BUILD=""
    shift # past argument
    shift
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z "${SERVICE_NAME}" ]]; then
  echo Service name not found
  exit 1
fi

if [[ -z "${IMAGE_VERSION}" ]]; then
  echo Image version name not found
  exit 1
fi



#App specific settings
export APP_NAME=$SERVICE_NAME
#Service Image settings
export IMAGE_VERSION=$IMAGE_VERSION
export REGISTRY_NAME=895173571296.dkr.ecr.us-west-2.amazonaws.com

export AWS_REGION=us-west-2

#Helm/K8S settings
export TEMPLATE_NAME=spring-boot
export K8S_NAMESPACE=specto-app
#image names
export RELEASE_NAME=$RELEASE_NAME
export SERVICE_VERSION=0.0.1





#set namespace for all actions in pipeline
kubectl config set-context --current --namespace=$K8S_NAMESPACE

# build
pushd ./.build
./build-app.sh
popd


# package 
pushd ./.package
./package-app.sh
popd

# deploy it
pushd ./.deploy
./deploy.sh
popd

#unset k8s namespace
#kubectl config set-context --current --namespace=default