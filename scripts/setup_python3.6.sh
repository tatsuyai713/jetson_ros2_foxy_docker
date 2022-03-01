#!/bin/bash

sudo rm /etc/apt/apt.conf.d/docker-clean
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install -y python3.6 python3.6-dev python3.6-venv
update-alternatives --list python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 3
