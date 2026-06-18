#!/usr/bin/env bash
set -e

xhost +local:docker >/dev/null 2>&1 || true

docker compose run --rm tdk bash