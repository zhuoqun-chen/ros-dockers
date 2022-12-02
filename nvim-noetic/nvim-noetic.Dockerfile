FROM ubuntu:20.04 AS nvim-builder

LABEL maintainer="zhc057@ucsd.edu"

# https://github.com/neovim/neovim/wiki/Building-Neovim#:~:text=are%20listed%20below.-,Ubuntu%20/%20Debian,-sudo%20apt%2Dget
ARG BUILD_APT_DEPS="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen" 
ARG DEBIAN_FRONTEND=noninteractive
ARG TARGET=stable

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    # package utils:
    dpkg pkg-config apt-utils \
    # git:
    git \
    # neovim dependencies: 
    ${BUILD_APT_DEPS} && \
    git clone https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim && \
    git fetch --all --tags -f && \
    git checkout ${TARGET} && \
    make CMAKE_BUILD_TYPE=Release && \
    make CMAKE_INSTALL_PREFIX=$HOME/neovim install 

# CMD["$HOME/neovim/bin/nvim"]

FROM osrf/ros:noetic-desktop-full
COPY --from=nvim-builder /root/neovim/ /root/neovim/

ENV PATH="/root/neovim/bin:$PATH"
RUN echo "Add neovim to the PATH: " && \
    echo $PATH

# the following won't exit globally, only effective for current line's instructions
RUN export "PATH=$HOME/neovim/bin:$PATH" 

# nvidia-container-runtime, nvidia-docker2 requires libglvnd installed inside image, melodic and up already installed
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo "alias clc=clear" >> ~/.bashrc && \
    echo "alias l='ls -al --color'" >> ~/.bashrc
    # -- source elevation_mapping if needed
    # echo "source /noetic-elemapws/devel/setup.bash" >> ~/.bashrc

# CMD["/root"]
