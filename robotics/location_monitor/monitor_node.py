#!/usr/bin/env python
import math
import rospy
# from std_msgs.msg import String
from nav_msgs.msg import Odometry

# def talker():
#     pub = rospy.Publisher('chatter', String, queue_size=10)
#     rospy.init_node('talker', anonymous=True)
#     rate = rospy.Rate(10) # 10hz
#     while not rospy.is_shutdown():
#         hello_str = "hello world %s" % rospy.get_time()
#         rospy.loginfo(hello_str)
#         pub.publish(hello_str)
#         rate.sleep()

landmarks = []
landmarks.append(("Cube", 1.83, -0.31));
landmarks.append(("Dumpster", 0.74, -3.53));
landmarks.append(("Cylinder", -2, -3.48));
landmarks.append(("Barrier", -4, -1));
landmarks.append(("Bookshelf", 0, 1.53));

def distance(x1, y1, x2, y2):
    xd = x1 - x2
    yd = y1 - y2
    return math.sqrt(xd**2 + yd**2)

def callback(msg):
    x = msg.pose.pose.position.x
    y = msg.pose.pose.position.y
    closest_name = None
    closest_distance = None
    for l_name, l_x, l_y in landmarks:
        dist = distance(x, y, l_x, l_y)
        if closest_distance is None or dist < closest_distance:
            closest_name = l_name
            closest_distance = dist
            #rospy.loginfo('close distance:{}, {}'.format(l_name, dist))
    rospy.loginfo('closest: {}'.format(closest_name))
    # rospy.loginfo('x:{}, y:{}'.format(x, y))

def main():
    rospy.init_node('location_monitor')
    rospy.Subscriber("/odom", Odometry, callback)
    rospy.spin()

if __name__ == '__main__':
    main()