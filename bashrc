#!/bin/bash

echo "Sourcing ROS1"
source /opt/ros/noetic/setup.bash
echo -n "Your ROS Master URI is "
echo ${ROS_MASTER_URI}

echo -n "This computer's IP is "
ip route get 8.8.8.8 | grep -oP 'src \K[^ ]+'

alias python=python3

# echo "192.168.131.1 ${warthog_hostname}" >> /etc/hosts