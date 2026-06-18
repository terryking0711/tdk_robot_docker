#!/usr/bin/env bash
set -e

mkdir -p workspaces
cd workspaces

if [ ! -d tdk_slam_ws ]; then
  git clone -b sim https://github.com/terryking0711/tdk_slam_ws.git
else
  echo "[tdk_slam_ws already exists]"
fi

if [ ! -d robot_fsm_v2_ws ]; then
  git clone https://github.com/terryking0711/robot_fsm_v2_ws.git
else
  echo "[robot_fsm_v2_ws already exists]"
fi