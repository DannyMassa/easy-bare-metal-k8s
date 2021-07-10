#!/bin/bash
set -ex

sudo apt-get update
sudo update-ca-certificates
sudo timedatectl set-ntp yes