#!/bin/bash
cd `rospack find oit_navigation_minibot_03`/launch/real
roslaunch mapping.launch rosbag:=true

