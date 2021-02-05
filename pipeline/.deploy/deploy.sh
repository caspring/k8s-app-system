#!/bin/bash -e
#set -x
set -e
#pull the upstream helm template (as starter template)
helm create --starter=$TEMPLATE_NAME $APP_NAME > helm-create-output.json

#deploy using helm
helm upgrade \
    $RELEASE_NAME \
    ./$APP_NAME \
    -f "$(pwd)"/../../$APP_NAME/values.yaml \
    --set image.tag=$IMAGE_VERSION \
    --set image.repository=$REGISTRY_NAME/$APP_NAME #\
    > helm-deploy-output.json

# cat helm-deploy-output.json | jq . 

#clean up
rm -rf ./$APP_NAME 


#sleep for a few seconds so load balancer has time to show up
sleep 10

#get service url
kubectl get service $SERVICE_NAME -o json > kubectl-get-service-output.json

echo "Service Name: $(cat kubectl-get-service-output.json | jq '.items[] | .metadata.name ')"
echo "Load Balancer DNS: $(cat kubectl-get-service-output.json | jq '.items[] | .status.loadBalancer.ingress[] | .hostname ')"