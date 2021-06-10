#!/usr/bin/env bash

set -e

PROJECT_NAME="workshop-operator"
ROOT_DIR="$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"

if [[ -z "${OPERATOR_IMAGE_PATH}" ]]; then
    echo "You must set the environment variable OPERATOR_IMAGE_PATH"
    echo
    echo "Example:"
    echo "export OPERATOR_IMAGE_PATH=quay.io/path/to/image:v0.1"

    exit 1
fi

read -p "This script assumes you are already logged into OpenShift as a cluster admin. Would you like to continue? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
    kubectl create ns ${PROJECT_NAME}

    kubectl create -f ${ROOT_DIR}/deploy/crds/operator_v1_workshop_crd.yaml
    kubectl create -f ${ROOT_DIR}/deploy/crds/operator_v1_student_crd.yaml

    kubectl create -f ${ROOT_DIR}/deploy/service_account.yaml -n ${PROJECT_NAME}
    kubectl create -f ${ROOT_DIR}/deploy/role.yaml -n ${PROJECT_NAME}
    kubectl create -f ${ROOT_DIR}/deploy/role_binding.yaml -n ${PROJECT_NAME}

    sed "s|{{ OPERATOR_IMAGE_PATH }}|${OPERATOR_IMAGE_PATH}|" ${ROOT_DIR}/deploy/operator.yaml > /tmp/${PROJECT_NAME}-operator.yaml

    kubectl create -f /tmp/${PROJECT_NAME}-operator.yaml -n ${PROJECT_NAME}

    rm -f /tmp/${PROJECT_NAME}-operator.yaml
fi
