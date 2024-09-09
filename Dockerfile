FROM ros:foxy-ros1-bridge-focal

RUN apt update 



# Link to allow sourcing
RUN rm /bin/sh && ln -s /bin/bash /bin/sh 

# Alias for sourcing
# sr1 -> source ros 1, sr2 -> source ros 2
RUN echo "alias sr1='source /opt/ros/noetic/setup.bash'" >> ~/.bashrc
RUN echo "alias sr2='source /opt/ros/foxy/setup.bash" >> ~/.bashrc

# Install networking tools
RUN apt update && apt install -y iproute2 python3-pip ros-noetic-teleop-twist-keyboard openssh-client iputils-ping
RUN python3 -m pip install websockets

# # Append robot's hostname to /etc/hosts (for ROS1 communication)
# RUN

RUN useradd -ms /bin/bash main
USER main

ENV ROS_MASTER_URI=http://CPR-CMU25:11311

# Your Remote Computer's wireless IP address
# See (click to expand): https://docs.clearpathrobotics.com/docs/ros1noetic/robots/outdoor_robots/warthog/tutorials_warthog/#remote-computer-software
# ENV ROS_IP=172.27.187.90 
ENV ROS_IP=0.0.0.0


ADD bashrc /home/main/.bashrc

# Add and build the ROS1 packages
ADD --chown=main:admin catkin_ws /home/main/catkin_ws
ADD --chown=main:admin entrypoint.sh /home/main/entrypoint.sh

RUN chmod +x /home/main/entrypoint.sh
WORKDIR /home/main/catkin_ws
RUN . /opt/ros/noetic/setup.sh && catkin_make

CMD ["/home/main/entrypoint.sh"]
