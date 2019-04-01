#!/usr/bin/env bash

set -e

IMAGE_PATH=${1:-quay.io/jhocutt/workshop-operator:v0.1}

sudo operator-sdk build ${IMAGE_PATH}
sudo docker push ${IMAGE_PATH}
