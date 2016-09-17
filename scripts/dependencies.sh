#!/bin/bash

set -o errexit

sudo apt-get update
sudo apt-get install -y aptitude
sudo apt-get install -y build-essential libssl-dev libffi-dev makepasswd
sudo apt-get install -y python-pip git python-dev
sudo pip install ansible markupsafe
