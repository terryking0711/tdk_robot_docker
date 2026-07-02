#!/usr/bin/env bash
set -e

docker compose run --rm tdk bash -lc "
source /opt/ros/humble/setup.bash
source /workspaces/tdk_slam_ws/install/setup.bash
source /workspaces/robot_fsm_v2_ws/install/setup.bash

export ROS_DOMAIN_ID=\${ROS_DOMAIN_ID:-30}
export RMW_IMPLEMENTATION=\${RMW_IMPLEMENTATION:-rmw_cyclonedds_cpp}

echo 'Container ready for real robot.'
echo 'Check devices:'
ls -l /dev/ttyUSB* /dev/ttyACM* 2>/dev/null || true

echo ''
echo 'Recommended real robot order:'
echo '1. Start micro-ROS agent or serial bridge'
echo '2. Start sensor drivers'
echo '3. Start robot_state_publisher'
echo '4. Start localization / SLAM'
echo '5. Start Nav2'
echo '6. Start FSM'
bash
"