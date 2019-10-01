if [ ! -z "$BASH" ]; then
    . /opt/ros/${ROS_DISTRO}/setup.bash
    . /home/root/dev/catkin_ws/devel/setup.bash

else
    . /opt/ros/${ROS_DISTRO}/setup.sh
    . /home/root/dev/catkin_ws/devel/setup.sh
fi
