#!/bin/bash

sudo apt update

sudo apt purge -y command-not-found
sudo apt install -y update-manager

sudo apt dist-upgrade -y
sudo do-release-upgrade
