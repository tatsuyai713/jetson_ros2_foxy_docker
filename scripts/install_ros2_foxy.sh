#!/bin/bash

sudo apt-get update
sudo apt-get install -y curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu \
    `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt-get update
sudo apt update
sudo apt install -y ros-foxy-desktop
