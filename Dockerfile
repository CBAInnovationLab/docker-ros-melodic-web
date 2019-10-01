FROM ros:melodic-ros-core-bionic
MAINTAINER Xun Wang <wang.xun@gmail.com> #derived from github.com/uts-magic-lab/ros-docker and osrf/docker_images

ENV ROS_DISTRO melodic

# Install additional dependencies
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  ros-${ROS_DISTRO}-actionlib \
  ros-${ROS_DISTRO}-rosbridge-server \
  sudo  \
  nano   \
  && rm -rf /var/lib/apt/lists/*

#RUN rosdep init
WORKDIR /home/pepper
RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
  rosdep update

# Build Pepper workspace
RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
  mkdir -p ~/dev/catkin_ws/src && \
  cd ~/dev/catkin_ws/src && \
  catkin_init_workspace && \
  cd ~/dev/catkin_ws && \
  catkin_make

ENV EDITOR nano -wi

RUN . ~/dev/catkin_ws/devel/setup.sh && \
  cd ~/dev/catkin_ws/src && \
  git clone https://github.com/uts-magic-lab/pyride_common_msgs.git && \
  cd ~/dev/catkin_ws && \
  catkin_make

RUN . ~/dev/catkin_ws/devel/setup.sh && \
  cd ~/dev/catkin_ws/src && \
  git clone -b basic --recursive https://github.com/kunle12/pyride_msg_bridge.git && \
  cd ~/dev/catkin_ws && \
  catkin_make

RUN cd ~/dev/catkin_ws/src/pyride_msg_bridge/pyconnect && \
  python pyconnect_ext_setup.py install --user && \
  rm -rf build

ADD assets /

# Publish roscore and rosbridge and pyride port
EXPOSE 11311
EXPOSE 9090
EXPOSE 37251

ENTRYPOINT ["/usr/local/bin/ros_entrypoint"]
