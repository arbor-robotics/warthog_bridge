#!/bin/bash

echo "Sourcing ROS1"
source /opt/ros/noetic/setup.bash
echo -n "Your ROS Master URI is "
echo ${ROS_MASTER_URI}

# echo "192.168.131.1 ${warthog_hostname}" >> /etc/hosts