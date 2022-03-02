FROM nvcr.io/nvidia/l4t-ml:r32.6.1-py3

ARG UID=9001
ARG GID=9001
ARG UNAME=nvidia
ARG HOSTNAME=docker

ARG NEW_HOSTNAME=Docker-${HOSTNAME}print(torch.cuda.device_count())

ARG USERNAME=$UNAME
ARG HOME=/home/$USERNAME


RUN useradd -u $UID -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        usermod  --uid $UID $USERNAME && \
        groupmod --gid $GID $USERNAME && \
        chown -R $USERNAME:$USERNAME $HOME && \
        chmod 666 /dev/null && \
        chmod 666 /dev/urandom

# install package
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        sudo \
        less \
        apt-utils \
        tzdata \
        git \
        bash-completion \
        vim \
        ssh \
        sed \
        ca-certificates \
        wget \
        git \
        gpg \
        gpg-agent \
        gpgconf \
        gpgv \
        lsb-release \
        net-tools \
        gnupg \
        gnupg2 \
        locales \
        avahi-daemon \
        software-properties-common


        
RUN apt upgrade -y && apt autoremove -y && apt clean && \
        rm -rf /var/lib/apt/lists/*

RUN gpasswd -a $USERNAME video


# set locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

USER ${USERNAME}
COPY scripts ${HOME}
