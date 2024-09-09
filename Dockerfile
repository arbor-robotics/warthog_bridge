FROM ros:noetic-ros-base
ARG warthog_hostname=CPR-CMU25

# Install networking tools
RUN apt update && apt install -y iproute2

# # Append robot's hostname to /etc/hosts (for ROS1 communication)
# RUN

RUN useradd -ms /bin/bash main
USER main

ENV ROS_MASTER_URI=http://CPR-CMU25:11311

# Your Remote Computer's wireless IP address
# See (click to expand): https://docs.clearpathrobotics.com/docs/ros1noetic/robots/outdoor_robots/warthog/tutorials_warthog/#remote-computer-software
ENV ROS_IP=172.27.187.90 


ADD bashrc /home/main/.bashrc
ADD --chown=main:admin catkin_ws /home/main/catkin_ws

WORKDIR /home/main/catkin_ws