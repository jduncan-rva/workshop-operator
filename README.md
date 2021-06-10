# Workshop Operator

## Developer Guide

This guide assumes you have `admin` access to a K8s cluster. For the sake of simplicity a K3D playground has been used.

### Build Image

To start, you must build the operator container image.

You will need to have docker installed and started. You will also need a
registry you can push this image to. We recommend Quay.io.

Once you have a registry path you can push the generated image to, run the
following helper script to build and push your image.

```bash
export OPERATOR_IMAGE_PATH=k3d-dev.localhost:12345/workshop-operator:v1

./hack/build.sh
```
### Initialize Cluster

After your operator image has been pushed to a registry, you need to deploy
some initial components to get the operator and its custom resources
defined.

You need to have an active K3D context. Just verify your current connection with:
```
kubectl config current-context
```

Then you can run the following helper script to initialize your cluster.

```bash
export OPERATOR_IMAGE_PATH=k3d-dev.localhost:12345/workshop-operator:v1

./hack/init.sh
```

### Deploy Example Workshop

To see the operator in action, you can deploy an example workshop.

```bash
kubectl create -f ./deploy/crds/operator_v1_workshop_cr.yaml -n workshop-operator
```

### Cleanup Cluster

If you need to start over, you can remove all of the custom resources and
operator from your cluster.

You need to have an active K3D context. Just verify your current connection with:
```
kubectl config current-context
```

Then you can run the following helper script to initialize your cluster.

```bash
./hack/cleanup.sh
```