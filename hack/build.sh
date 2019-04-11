#!/usr/bin/env bash

set -e

if [[ -z "${OPERATOR_IMAGE_PATH}" ]]; then
    echo "You must set the environment variable OPERATOR_IMAGE_PATH"
    echo
    echo "Example:"
    echo "export OPERATOR_IMAGE_PATH=quay.io/path/to/image:v0.1"

    exit 1
fi

sudo operator-sdk build ${OPERATOR_IMAGE_PATH}
sudo docker push ${OPERATOR_IMAGE_PATH}
