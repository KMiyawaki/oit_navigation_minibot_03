#!/usr/bin/env python
# -*- coding: utf_8 -*-
import os
import rospy
from tf.msg import tfMessage


class RemoveMapFrame(object):
    def __init__(self, topic_tf_in, topic_tf_out):
        rospy.Subscriber(topic_tf_in, tfMessage, self.tf_callback)
        self.pub_tf = rospy.Publisher(topic_tf_out, tfMessage, queue_size=1)

    def tf_callback(self, msg):
        filteredTransforms = []
        for m in msg.transforms:
            if m.header.frame_id != "map":
                filteredTransforms.append(m)
        if len(filteredTransforms) > 0:
            self.pub_tf.publish(filteredTransforms)


def main():
    script_name = os.path.basename(__file__)
    node_name = os.path.splitext(script_name)[0]
    rospy.init_node(node_name)

    _ = RemoveMapFrame("tf_raw", "tf")
    rospy.spin()


if __name__ == '__main__':
    main()
