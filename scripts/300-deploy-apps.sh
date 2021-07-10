#!/bin/bash
set -ex

##### Install dynamic NFS storage

helm upgrade nfs ./charts/nfs -n nfs \
  --values ./charts/nfs/values.yaml \
  --create-namespace \
  --install \
  --wait

./scripts/helpers/wait-for-pods.sh nfs

##### Install Certificate Issuers

helm upgrade issuers ./charts/issuers -n issuers \
  --values ./charts/issuers/values.yaml \
  --create-namespace \
  --install \
  --wait

./scripts/helpers/wait-for-pods.sh issuers

##### Install Continuous Deployment

helm upgrade tekton-dashboard ./charts/tekton-dashboard -n tekton-pipelines \
  --values ./charts/tekton-dashboard/values.yaml \
  --create-namespace \
  --install \
  --wait

helm upgrade tekton-pipelines ./charts/tekton-pipelines -n tekton-pipelines \
  --values ./charts/tekton-pipelines/values.yaml \
  --create-namespace \
  --install \
  --wait

helm upgrade tekton-triggers ./charts/tekton-triggers -n tekton-pipelines \
  --values ./charts/tekton-triggers/values.yaml \
  --create-namespace \
  --install \
  --wait

./scripts/helpers/wait-for-pods.sh tekton-pipelines