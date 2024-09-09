#!/usr/bin/env python

import rospy
from std_msgs.msg import String
from warthog_msgs.msg import Lights
import asyncio
from websockets.asyncio.server import serve, Server, ServerConnection


def bridge():
    pub = rospy.Publisher("CHATTER", String, queue_size=10)
    light_pub = rospy.Publisher("/cmd_lights", Lights, queue_size=10)
    rospy.init_node("warthog_bridge", anonymous=True)
    rate = rospy.Rate(5)  # 10hz
    while not rospy.is_shutdown():
        rospy.loginfo("hi")
        pub.publish("hi")

        light_msg = Lights()

        light_pub.publish(light_msg)

        rate.sleep()


async def spinWebsocketServer():
    async with serve(echo, "localhost", 8765):
        await asyncio.get_running_loop().create_future()  # run forever


async def spinRos(freq=1e4):
    while rclpy.ok():
        # Manually spin the ROS node at a rate of 1e4 Hz.
        rclpy.spin_once(node, timeout_sec=0)
        await asyncio.sleep(1 / freq)


if __name__ == "__main__":
    # Run both the ROS loop and the Websocket server loop
    future = asyncio.wait([bridge(), spinWebsocketServer()])

    # Spin until both loops complete or are cancelled
    asyncio.get_event_loop().run_until_complete(future)

    try:
        bridge()
    except rospy.ROSInterruptException:
        pass
