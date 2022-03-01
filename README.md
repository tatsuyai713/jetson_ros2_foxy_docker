# jetson_ros2_foxy_docker
Jetson Docker Container for ROS2 Foxy with CUDA, CUDNN and TensorRT

This docker container is based on l4t-ml.

## Fix nvidia container
please refer this.
https://github.com/dusty-nv/jetson-containers/issues/108

## (For Jetson User) Disable nvidia library automount setting
Nvidia container automatically mount host libraries (CUDA, CUDNN and so on).
But sometimes, this function block the updating the software inside container.
So, you should remove or replace the setting file.
please refer this site.
https://github.com/NVIDIA/nvidia-docker/wiki/NVIDIA-Container-Runtime-on-Jetson

please keep only one file l4t.csv.
/etc/nvidia-container-runtime/host-files-for-container.d/l4t.csv

## How to use "launch_container.sh"
 - first time, you have to setup container.

```
./launch_container.sh setup
```

 - after setup, you can access the inside container by same username and hostname is Docker- + Host hostname.
 - next time, you can enter the inside container with only using

```
./launch_container.sh
```
 - if you want to commit the change inside container, please type this command.

```
./launch_container.sh commit
```

## Setup for Ubuntu 20.04 and ROS2 Foxy
 1. first of all, you have to execute "upgrade_to_20.04.sh" for upgrading the Ubuntu OS. (execute do-release-upgrade command)
 2. execute "setup_python3.6.sh" for installing Python3.6. after that you can use pytorch with Python3.6. 
 3. execute "install_nvidia_packages.sh"
 4. execute "install_ros2_foxy.sh" if you want to use ROS2 Foxy.
