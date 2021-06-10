#!/usr/bin/env bash

PROJECT_NAME="workshop-operator"
ROOT_DIR="$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" )"

read -p "This script assumes you are already logged into OpenShift as a cluster admin. Would you like to continue? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] ; then
    kubectl delete deployment workshop-operator -n ${PROJECT_NAME}
    kubectl delete clusterrolebinding workshop-operator
    kubectl delete clusterrole workshop-operator
    kubectl delete serviceaccount workshop-operator -n ${PROJECT_NAME}

    # Deleting a CRD will also delete any custom resources defined
    # https://kubernetes.io/dkubectls/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/#delete-a-customresourcedefinition
    kubectl delete crd students.operator.redhatgov.io
    kubectl delete crd workshops.operator.redhatgov.io

    kubectl delete ns ${PROJECT_NAME}
fi
