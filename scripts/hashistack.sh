#!/bin/bash

set -o errexit

sudo apt-get update
sudo apt-get install -y unzip wget
echo 'Installing Packer 0.10.1'
wget https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip >/dev/null 2>&1
unzip packer_0.10.1_linux_amd64.zip
sudo mv packer /usr/local/bin
echo 'Cleaning up...'
rm packer_0.10.1_linux_amd64.zip
