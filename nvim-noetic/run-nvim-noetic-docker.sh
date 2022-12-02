# --privileged is important, with it, docker can use rqt, rviz normally without libgl error.

# add following line for using elevation_mapping, this can also be integrated directly into this docker(to be done)
# --volume="$HOME/docker/volume/noetic-elemapws/:/noetic-elemapws/" \ 
docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --privileged \
    --name nvim-noetic-docker \
    zqchen33/nvim-noetic:beta-1
