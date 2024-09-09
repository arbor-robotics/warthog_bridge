# Warthog Bridge

A Docker container that:

1. Connects to the Warthog's OBC using ROS1
2. Links the Warthog's ROS1 network with our ROS2 nodes using Websockets

## Running
```bash
$ docker build . -t warthog_bridge:latest
$ docker run -it --network host --add-host CPR-CMU25=192.168.131.1 warthog_bridge bash
```
