#!/bin/bash
set -ex

##### Install CNI

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml

./scripts/helpers/wait-for-pods.sh kube-system
./scripts/helpers/wait-for-pods.sh calico-system

##### Install Certificate Manager

helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade cert-manager jetstack/cert-manager -n cert-manager \
  --values ./charts/cert-manager/values.yaml \
  --create-namespace \
  --install \
  --wait

./scripts/helpers/wait-for-pods.sh cert-manager

##### Install Bare Metal Load Balancer

helm repo add metallb https://metallb.github.io/metallb
helm repo update
helm upgrade metallb metallb/metallb -n metallb \
  --values ./charts/metallb/values.yaml \
  --create-namespace \
  --install \
  --wait

./scripts/helpers/wait-for-pods.sh metallb


##### Install Ingress Controller

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx \
  --values ./charts/ingress-nginx/values.yaml \
  --create-namespace \
  --install \
  --wait

./scripts/helpers/wait-for-pods.sh ingress-nginx
