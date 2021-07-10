#!/bin/bash
set -ex

./scripts/001-update.sh
./scripts/010-pre-setup.sh
./scripts/100-deploy-kubeadm.sh
./scripts/200-deploy-infra.sh
./scripts/300-deploy-apps.sh
