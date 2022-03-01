#!/bin/sh
SCRIPT_DIR=$(cd $(dirname $0); pwd)


NAME_IMAGE='jetson_ros2_foxy'

# Make Container
if [ ! "$(docker image ls -q ${NAME_IMAGE})" ]; then
	if [ ! $# -ne 1 ]; then
		if [ "setup" = $1 ]; then
			echo "Image ${NAME_IMAGE} does not exist."
			echo 'Now building image without proxy...'
			docker build --file=./noproxy.dockerfile -t $NAME_IMAGE . --build-arg UID=$(id -u) --build-arg GID=$(id -u) --build-arg UNAME=$USER
		fi
	else
		echo "Docker image not found. Please setup first!"
		exit
  	fi
fi

# Commit
if [ ! $# -ne 1 ]; then
	if [ "commit" = $1 ]; then
		echo 'Now commiting docker container...'
		docker commit jetson_ros2_foxy_container jetson_ros2_foxy:latest
		CONTAINER_ID=$(docker ps -a -f name=jetson_ros2_foxy_container --format "{{.ID}}")
		docker rm $CONTAINER_ID
		exit
	fi
fi


XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
if [ ! -z "$xauth_list" ];  then
  echo $xauth_list | xauth -f $XAUTH nmerge -
fi
chmod a+r $XAUTH

DOCKER_OPT=""
DOCKER_NAME="jetson_ros2_foxy_container"
DOCKER_WORK_DIR="/home/${USER}"
DISPLAY=$(hostname).local:0

## For XWindow
DOCKER_OPT="${DOCKER_OPT} \
        --env=QT_X11_NO_MITSHM=1 \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume=/Users/${USER}:/home/${USER}/host_home:rw \
        --env=XAUTHORITY=${XAUTH} \
        --volume=${XAUTH}:${XAUTH} \
        --env=DISPLAY=${DISPLAY} \
        -w ${DOCKER_WORK_DIR} \
        -u ${USER} \
        --hostname Docker-`hostname` \
        --add-host Docker-`hostname`:127.0.1.1"
		
DOCKER_OPT="${DOCKER_OPT} -it "
		
## Allow X11 Connection
xhost +local:Docker-`hostname`
CONTAINER_ID=$(docker ps -a -f name=jetson_ros2_foxy_container --format "{{.ID}}")

# Run Container
if [ ! "$CONTAINER_ID" ]; then
	docker run ${DOCKER_OPT} \
		--shm-size=1gb \
		--env=TERM=xterm-256color \
		--net=host \
		--name=${DOCKER_NAME} \
		jetson_ros2_foxy:latest \
		bash
else
	docker start $CONTAINER_ID
	docker attach $CONTAINER_ID
fi

xhost -local:Docker-`hostname`

