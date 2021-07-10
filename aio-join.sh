#!/bin/bash
set -ex

./scripts/001-update.sh
./scripts/010-pre-setup.sh
./scripts/101-kubeadm-join.sh