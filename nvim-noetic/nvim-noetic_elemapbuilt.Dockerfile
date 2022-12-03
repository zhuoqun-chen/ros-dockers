FROM zqchen33/nvim-noetic:elemap

LABEL maintainer="zhc057@ucsd.edu"

ENV ELEMAP_WS=/elemapws

WORKDIR /root

RUN cat /root/.bashrc

# It seems that I forgot to install git in nvim-noetic:elemap
RUN apt-get update && apt-get install -y \
    git

RUN mkdir -p /elemapws/src && cd /elemapws/src && \
    git clone https://github.com/ANYbotics/kindr.git && \
    git clone https://github.com/ANYbotics/kindr_ros.git && \
    git clone https://github.com/ANYbotics/message_logger.git && \
    git clone https://github.com/ANYbotics/elevation_mapping.git && \
    cd /elemapws && \
    echo $PWD

RUN echo $PWD
# Though at the last step of above RUN changed dir to /elemapws, but here it will go back to /root
# so we need to change the dir explicitly again, or the rest catkin build will show errs
WORKDIR ${ELEMAP_WS}
RUN echo $PWD

RUN /bin/bash -c " \
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release; \
    source /opt/ros/${ROS_DISTRO}/setup.bash; \
    catkin build kindr; \
    source ${ELEMAP_WS}/devel/setup.bash; \
    catkin build; \
    source ${ELEMAP_WS}/devel/setup.bash; \
"

# The above has to be run with /bin/bash, rather than directly RUN(which will result in errs)
    # source /opt/ros/${ROS_DISTRO}/setup.bash && \
    # catkin build kindr && \
    # source ${ELEMAP_WS}/devel/setup.bash && \ 
    # catkin build && \
    # source ${ELEMAP_WS}/devel/setup.bash
    
RUN echo "source ${ELEMAP_WS}/devel/setup.bash" >> ~/.bashrc
