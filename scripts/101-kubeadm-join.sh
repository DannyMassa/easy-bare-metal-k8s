#!/bin/bash
set -ex

sudo kubeadm join 192.168.86.17:6443 \
  --token 3mjp6y.rn4ondslig9869qg \
  --discovery-token-ca-cert-hash sha256:0c973ec7b32079b3babcbd112c2bc63b942049cef4695200e8f02f8f9c03ee42

