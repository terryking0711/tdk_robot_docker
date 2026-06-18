#!/usr/bin/env bash
set -e

source /opt/ros/humble/setup.bash

export ROS_DOMAIN_ID=${ROS_DOMAIN_ID:-30}
export RMW_IMPLEMENTATION=${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}

echo "========== Build tdk_slam_ws =========="
cd /workspaces/tdk_slam_ws

rosdep install \
  --from-paths src \
  --ignore-src \
  -r -y \
  --rosdistro humble || true

colcon build --symlink-install

source install/setup.bash

echo "========== Build robot_fsm_v2_ws =========="
cd /workspaces/robot_fsm_v2_ws

rosdep install \
  --from-paths src \
  --ignore-src \
  -r -y \
  --rosdistro humble || true

colcon build --symlink-install

echo "========== Done =========="