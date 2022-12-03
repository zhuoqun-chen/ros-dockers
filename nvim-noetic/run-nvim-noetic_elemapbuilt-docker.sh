# --privileged is important, with it, docker can use rqt, rviz normally without libgl error.

# integrate elevation_mapping directly into this docker, user's cutom dir is mapped to a custom folder under elemapws/src/
# this mapping is only an example, replace it on your own need.
docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --runtime=nvidia \
    --volume="$HOME/docker/volume/custom-host/:/elemapws/src/custom" \
    --privileged \
    --name nvim-noetic_elemapbuilt-docker \
    zqchen33/nvim-noetic:elemapbuilt
