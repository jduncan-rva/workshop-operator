#!/usr/bin/env bash

PROJECT_NAME="workshop-operator"
ROOT_DIR="$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"

read -p "This script assumes you are already logged into OpenShift as a cluster admin. Would you like to continue? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
    oc delete deployment workshop-operator -n ${PROJECT_NAME}
    oc delete clusterrolebinding workshop-operator
    oc delete clusterrole workshop-operator
    oc delete serviceaccount workshop-operator -n ${PROJECT_NAME}

    # Deleting a CRD will also delete any custom resources defined
    # https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/#delete-a-customresourcedefinition
    oc delete crd students.operator.redhatgov.io
    oc delete crd workshops.operator.redhatgov.io

    oc delete project ${PROJECT_NAME}
fi
