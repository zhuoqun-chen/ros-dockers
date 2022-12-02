# ros-dockers

## nvim-noetic

### current tags
+ `nvim-noetic:beta-1` -- only integrate neovim inside ros-noetic-desktop-full
+ `nvim-noetic:elemap` -- based on beta-1, install minial dependencies for building elevation_mapping

### beta-1 tag

Used docker multi-stage feature to copy `neovim/` from builder to `osrf/ros:noetic-desktop-full`.

Before using `run-nvim-noetic-docker.sh` to create a new container from the image, make sure you have 
`nvidia-docker2` installed.

build this docker from scratch:

```bash
cd nvim-noetic/
docker build -f "nvim-noetic.Dockerfile" -t "nvim-noetic" .
```

or directly pull to your local machine from Docker Hub:

```bash
docker pull zqchen33/nvim-noetic:beta-1
```

stop or start the same container:

```bash
docker stop nvim-noetic-docker
docker start nvim-noetic-docker
```

to open more bash shell session:

```bash
./exec-nvim-noetic-docker.sh
```

### elemap tag

Noting more but installing `elevation_mapping` system level dependencies(kindr, kindr_ros, message_logger not included).
