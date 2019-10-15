#!/bin/sh

# source all /etc/profile.d/ scripts
. /etc/profile
touch ~/rosbridge_server.log
touch ~/pyride_msg_server.log

# Start rosbridge in background
roslaunch rosbridge_server rosbridge_websocket.launch > ~/rosbridge_server.log 2>&1 &
roslaunch --wait pyride_msg_bridge pyride_bridge.launch > ~/pyride_msg_server.log 2>&1 &
ros_pid=$!

touch ~/example.sh
chmod 755 ~/example.sh

cat <<EOF > ~/example.sh
#!/usr/bin/python2.7
import PyConnect

PyConnect.discover()
bridge = PyConnect.PyRIDEMsgBridge

bridge.sendMessageToNode('joyride_foreground', '{"type": "img", "value": "art/innovation-lab-logo.png"}')
EOF

# when run with some command: start that command
if [ $# -gt 0 ]; then
    sleep 1 # give roscore time to start
    exec "$@"

# when run with a terminal and no command: start a shell
elif [ -t 0 ]; then
    shell=$(getent passwd $(whoami) | cut -d: -f7)
    exec $shell -l

# otherwise: wait on child processes
else
    tail -qF ~/*.log &
    wait $ros_pid
fi
