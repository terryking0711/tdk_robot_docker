#!/usr/bin/env bash
set -e

xhost +local:docker >/dev/null 2>&1 || true

docker compose run --rm tdk bash -lc "
source /opt/ros/humble/setup.bash
source /workspaces/tdk_slam_ws/install/setup.bash
source /workspaces/robot_fsm_v2_ws/install/setup.bash
echo 'Container ready for Gazebo simulation.'
echo 'Example: ros2 launch <your_package> <your_sim_launch>.py'
bash
"