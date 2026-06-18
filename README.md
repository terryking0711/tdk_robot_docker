# TDK Robot Docker

這個 repo 用來管理 TDK robot 專案的 Docker 環境。

它會搭配兩個 workspace 使用：

```text
workspaces/
├── tdk_slam_ws
└── robot_fsm_v2_ws
```

## 1. Clone docker repo

```bash
git clone https://github.com/terryking0711/tdk_robot_docker.git
cd tdk_robot_docker
```

## 2. 確認腳本可執行

```bash
chmod +x scripts/*.sh
```

## 3. Clone 兩個 workspace

```bash
./scripts/clone_ws.sh
```

執行後會產生：

```text
workspaces/
├── tdk_slam_ws
└── robot_fsm_v2_ws
```

目前設定：

* `tdk_slam_ws` 使用 `sim` branch
* `robot_fsm_v2_ws` 使用 `main` branch

## 4. Build Docker image

```bash
docker compose build
```

如果剛修改過 Dockerfile，建議使用：

```bash
docker compose build --no-cache
```

## 5. 進入開發環境

```bash
./scripts/run_dev.sh
```

進入 container 後，主要工作目錄是：

```text
/workspaces
```

## 6. Build workspace

進入 container 後執行：

```bash
cd /workspaces/tdk_slam_ws
rosdep install --from-paths src --ignore-src -r -y --rosdistro humble
colcon build --symlink-install

source install/setup.bash

cd /workspaces/robot_fsm_v2_ws
rosdep install --from-paths src --ignore-src -r -y --rosdistro humble
colcon build --symlink-install
```

或使用專案腳本：

```bash
./scripts/build_all.sh
```

## 7. 模擬環境

```bash
./scripts/run_sim.sh
```

進入 container 後再啟動 Gazebo / RViz / Nav2 相關 launch file。

例如：

```bash
ros2 launch <package_name> <launch_file>.py
```

## 8. 實機環境

```bash
./scripts/run_real.sh
```

實機建議啟動順序：

```text
1. micro-ROS agent 或 serial bridge
2. sensor drivers
3. robot_state_publisher
4. localization / SLAM
5. Nav2
6. FSM
```

## 注意事項

### Dockerfile 檔名

`compose.yaml` 指定的是：

```text
docker/Dockerfile
```

所以檔名必須是大寫 `Dockerfile`，不要是小寫 `dockerfile`。

如果 GitHub 上仍然顯示小寫，請執行：

```bash
git mv -f docker/dockerfile docker/Dockerfile
git commit -m "Rename dockerfile to Dockerfile"
git push
```

### ROS_DOMAIN_ID

預設使用：

```bash
ROS_DOMAIN_ID=30
```

### RMW implementation

預設使用：

```bash
RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
```

### GUI / Gazebo / RViz

如果要使用 Gazebo 或 RViz，需要允許 Docker 使用 X11：

```bash
xhost +local:docker
```

`run_dev.sh` 和 `run_sim.sh` 已經有自動執行這一步。

### 缺 dependency 時

不要只在 container 裡手動安裝後結束。

正確流程是：

```text
1. 記下缺少的套件
2. 補進 docker/Dockerfile 或 package.xml
3. 重新 build image
4. 再測一次
```

重新 build：

```bash
docker compose build --no-cache
```
