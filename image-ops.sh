#!/bin/bash

# exit on error
set -eou pipefail

# print commands
set -x

# Get directory containing this script.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TIMESTAMP=`date "+%Y%m%d%H%M"`
LAST_TAG_OUTPUT="$SCRIPT_DIR/.docker_last_tag"
TAG=${TAG-$TIMESTAMP}
BUILD=false
PUSH=false
RUN=false

source $SCRIPT_DIR/docker-config.sh

function print_help() {
  echo "\
usage: $0
  -b|--build       Build image
  -p|--push        Push image
  -B|--build-push  Build and push image
  -h|--help        Print this help message
  -r|--run         Run the docker image
  -t|--tag         Specify tag to use (default = current datetime )
"
}

if [[ $# = 0 ]]; then
  print_help
  exit 1
fi

while [[ $# > 0 ]]
  do
  key="$1"
  case $key in
      -h|--help)
        print_help
        exit 0
        ;;
      -b|--build)
        BUILD=true
        ;;
      -p|--push)
        PUSH=true
        ;;
      -B|--build-push)
        BUILD=true
        PUSH=true
        ;;
      -r|--run)
        RUN=true
        ;;
      -t|--tag)
        TAG="$2"
        shift
        ;;
      *)
        # unknown option
        print_help
        exit 1
        ;;
  esac
  shift # past argument or value
done

if [ $BUILD == true ]
then
  docker build \
      -t $IMAGE_NAME:$TAG \
      -t $IMAGE_NAME:latest \
      -t $REGISTRY/$IMAGE_NAME:$TAG \
      -t $REGISTRY/$IMAGE_NAME:latest \
      .
  echo "export TAG=$TAG">$LAST_TAG_OUTPUT
fi


if [ $PUSH == true ]
then
  source $LAST_TAG_OUTPUT
  docker push $REGISTRY/$IMAGE_NAME:$TAG
  docker push $REGISTRY/$IMAGE_NAME:latest
fi

if [ $RUN == true ]
then
  source $LAST_TAG_OUTPUT
  docker_run_command
fi
