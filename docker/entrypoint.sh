#!/usr/bin/env bash
set -e

source /opt/ros/humble/setup.bash

# 建議實機也固定用同一個 domain，避免多台 ROS2 電腦互相干擾
export ROS_DOMAIN_ID=${ROS_DOMAIN_ID:-30}

# CycloneDDS 通常比 FastDDS 在 Docker/實機網路上比較少奇怪問題
export RMW_IMPLEMENTATION=${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}

# Gazebo/RViz GUI
export QT_X11_NO_MITSHM=1
export LIBGL_ALWAYS_SOFTWARE=${LIBGL_ALWAYS_SOFTWARE:-0}

# Source workspaces if already built
if [ -f /workspaces/tdk_slam_ws/install/setup.bash ]; then
  source /workspaces/tdk_slam_ws/install/setup.bash
fi

if [ -f /workspaces/robot_fsm_v2_ws/install/setup.bash ]; then
  source /workspaces/robot_fsm_v2_ws/install/setup.bash
fi

exec "$@"