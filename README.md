# ROS Melodic docker image with PyRIDE Message Bridge and ROS Bridge for Web built-in

### How to build the docker images

- run `docker build -t docker-ros-melodic-web .`

### How to use the image

- run `docker run --rm -it -p 11311:11311 -p 9090:9090 docker-ros-melodic-web`

- run ros apps in the main shell

- attach a new shell with `docker exec -it bash -l`
