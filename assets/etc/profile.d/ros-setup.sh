if [ ! -z "$BASH" ]; then
    . /opt/ros/${ROS_DISTRO}/setup.bash
    . /home/pepper/dev/catkin_ws/devel/setup.bash

else
    . /opt/ros/${ROS_DISTRO}/setup.sh
    . /home/pepper/dev/catkin_ws/devel/setup.sh
fi
