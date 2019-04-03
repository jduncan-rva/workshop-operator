# Workshop Operator

## Developer Guide

This guide assumes you have `cluster-admin` access to an OpenShift 3.11+ cluster.

### Build Image

To start, you must build the operator container image.

You will need to have docker installed and started. You will also need a
registry you can push this image to. We recommend Quay.io.

Once you have a registry path you can push the generated image to, run the
following helper script to build and push your image.

```bash
export OPERATOR_IMAGE_PATH=quay.io/username/workshop-operator:v0.1

./hack/build.sh
```
### Initialize Cluster

After your operator image has been pushed to a regstry, you need to deploy
some initial components to get the operator and it's custom resources
defined.

You will need to already be logged into your OpenShift 3.11+ cluster as a
user with `cluster-admin` access.

```bash
oc login openshift.example.com
```

Then you can run the following helper script to initialize your cluster.

```bash
export OPERATOR_IMAGE_PATH=quay.io/username/workshop-operator:v0.1

./hack/init.sh
```

### Deploy Example Workshop

To see the operator in action, you can deploy an example workshop.

```bash
oc create -f ./deploy/crds/operator_v1_workshop_cr.yaml -n workshop-operator
```

### Cleanup Cluster

If you need to start over, you can remove all of the custom resources and
operator from your cluster.

You will need to already be logged into your OpenShift 3.11+ cluster as a
user with `cluster-admin` access.

```bash
oc login openshift.example.com
```

Then you can run the following helper script to initialize your cluster.

```bash
./hack/cleanup.sh
```

