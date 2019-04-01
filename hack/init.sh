#!/usr/bin/env bash

set -e

PROJECT_NAME=${1:-workshop-operator}
ROOT_DIR="$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"

read -p "This script assumes you are already logged into OpenShift as a cluster admin. Would you like to continue? [y/n] " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]] ; then
    oc new-project ${PROJECT_NAME}

    oc create -f ${ROOT_DIR}/deploy/crds/operator_v1_workshop_crd.yaml
    oc create -f ${ROOT_DIR}/deploy/crds/operator_v1_student_crd.yaml

    oc create -f ${ROOT_DIR}/deploy/service_account.yaml -n ${PROJECT_NAME}
    oc create -f ${ROOT_DIR}/deploy/role.yaml
    oc create -f ${ROOT_DIR}/deploy/role_binding.yaml
    oc create -f ${ROOT_DIR}/deploy/operator.yaml -n ${PROJECT_NAME}
fi
