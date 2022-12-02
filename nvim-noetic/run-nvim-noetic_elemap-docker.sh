# --privileged is important, with it, docker can use rqt, rviz normally without libgl error.

# add following line for using elevation_mapping, this can also be integrated directly into this docker(to be done)
# --volume="$HOME/docker/volume/noetic-elemapws/:/noetic-elemapws/" \ 

# if manually mapping host $HOME/docker/volume/elemapws/:/elemapws/ and git clone elevation_mapping repo into it,
# then running this docker and catkin build all packs(elemap + all deps), then can normally run the turtlebot3 demo. 
docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --privileged \
    --name nvim-noetic_elemap-docker \
    zqchen33/nvim-noetic:elemap
