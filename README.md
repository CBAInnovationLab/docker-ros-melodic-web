# ROS Melodic docker image with PyRIDE Message Bridge and ROS Bridge for Web built-in

### How to build the docker images

- run `docker build -t docker-ros-melodic-web .`

### How to use the image

- run `docker run --rm -it -p 11311:11311 -p 9090:9090 docker-ros-melodic-web` to start the built-in processes and a terminal.

- start ```Python``` in the terminal, do
```python
>>> import PyConnect
>>> PyConnect.discover()
>>> m=PyConnect.PyRIDEMsgBridge
>>> m.sendMessageToNode( 'joyride_foreground', '{"type": "img", "value": "art/Work-in-Progress.png"}' ) # for example

```

- you can also attach a new shell with `docker exec -it <container name> bash`

**NOTE**: The ```chip-monitor``` should set ```ROSBRIDGE_URI``` to ```ws://localhost:9090``` in its ```webpack.config.js```.
