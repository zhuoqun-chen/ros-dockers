####
# This Dockerfile adds minimal dependencies for building 
# and running ANYbotics/elevation_mapping based on zqchen33/nvim-noetic
####

# here use beta-1 tag only for tests, finally will use stable
FROM zqchen33/nvim-noetic:beta-1

LABEL maintainer="zhc057@ucsd.edu"

# In fact, eigen3 and pcl are already installed in osrf/ros:noetic-desktop-full
# turtlebot3* is for running elemap demo
ARG BUILD_ELEMAP_DEPS=" \
        libeigen3-dev \
        libpcl-dev \
        ros-${ROS_DISTRO}-grid-map \
        ros-${ROS_DISTRO}-turtlebot3* \
        "

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    # for using catkin build(recommended way to build elemap & other ros packs than catkin make)
    python3-catkin-tools \
    ${BUILD_ELEMAP_DEPS}


