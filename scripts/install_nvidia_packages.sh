#!/bin/bash

sudo apt-key adv --fetch-key http://repo.download.nvidia.com/jetson/jetson-ota-public.asc
sudo sh -c "echo 'deb https://repo.download.nvidia.com/jetson/common r32.6 main' > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list"
sudo sh -c "echo 'deb https://repo.download.nvidia.com/jetson/t194 r32.6 main' >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list"

sudo apt update

sudo apt purge -y opencv* libopencv*

wget http://ports.ubuntu.com/pool/main/libf/libffi/libffi6_3.2.1-8_arm64.deb
sudo apt install -y ./libffi6_3.2.1-8_arm64.deb

wget \
        http://ports.ubuntu.com/pool/main/libv/libvpx/libvpx5_1.7.0-3ubuntu0.18.04.1_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libavcodec57_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libavformat57_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libavutil55_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libswresample2_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libswscale4_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/x/x264/libx264-152_0.152.2854+gite9a5903-2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/x/x265/libx265-146_2.6-3_arm64.deb

sudo apt install -y \
        ./libvpx5_*_arm64.deb \
        ./libavcodec57_*_arm64.deb \
        ./libavformat57_*_arm64.deb \
        ./libavutil55_*_arm64.deb \
        ./libswresample2_*_arm64.deb \
        ./libswscale4_*_arm64.deb \
        ./libx264-152_*_arm64.deb \
        ./libx265-146_*_arm64.deb


sudo apt install -y \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libglib2.0-dev \
        libglib2.0-dev-bin \
        jetson-gpio-common \
        nvidia-cuda \
        cuda-minimal-build-10-2 \
        cuda-gdb-src-10-2 \
        nvidia-cudnn8 \
        python-jetson-gpio \
        python3-jetson-gpio \
        libdrm-tegra0 \
        nvidia-visionworks \
        libvisionworks-samples \
        libvisionworks-sfm-dev \
        libvisionworks-tracking-dev \
        deepstream-6.0 \
        libglew-dev \
        nsight-systems-cli-2021.2.3


sudo apt update
apt download python3-libnvinfer=8.0.1-1+cuda10.2
DEBFILE="python3-libnvinfer_8.0.1-1+cuda10.2_arm64.deb"
mkdir temp
chmod 777 temp
TMPDIR=./temp
OUTPUT=python3-libnvinfer_8.0.1-1+cuda10.2_arm64.modified.deb
dpkg-deb -x "$DEBFILE" "$TMPDIR"
dpkg-deb --control "$DEBFILE" "$TMPDIR"/DEBIAN
CONTROL=./temp/DEBIAN/control
sed -i 's/^Depends: python3 (>= 3.6), python3 (<< 3.7)/Depends: python3.6/g' $CONTROL
dpkg -b "$TMPDIR" "$OUTPUT"
rm -r "$TMPDIR"
sudo dpkg -i python3-libnvinfer_8.0.1-1+cuda10.2_arm64.modified.deb
sudo apt install -y python3-libnvinfer-dev=8.0.1-1+cuda10.2 nvidia-tensorrt

sudo ln -s /usr/lib/aarch64-linux-gnu/libmpi.so /usr/lib/aarch64-linux-gnu/libmpi.so.20
sudo ln -s /usr/lib/aarch64-linux-gnu/libmpi_cxx.so /usr/lib/aarch64-linux-gnu/libmpi_cxx.so.20
sudo ldconfig


