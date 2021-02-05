#!/bin/bash 
set -e
set -x
#assert APP_NAME=APP_FOLDER
#build service artifact
docker run -it --rm --name $APP_NAME -v "$(pwd)/../../$APP_NAME":/usr/src/mymaven -w /usr/src/mymaven mvn-build:pilot mvn verify

