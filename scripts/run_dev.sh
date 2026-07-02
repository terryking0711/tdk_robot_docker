#!/usr/bin/env bash
set -e

# 放行本地連線（特別針對 SSH 轉發的憑證）
xhost +local:root >/dev/null 2>&1 || true

# 強制將主機的 DISPLAY 與 XAUTHORITY 帶入 docker compose
DISPLAY=$DISPLAY \
XAUTHORITY=~/.Xauthority \
docker compose run --rm tdk bash