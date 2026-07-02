# syntax=docker/dockerfile:1

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV ROS_DOMAIN_ID=30

SHELL ["/bin/bash", "-c"]

# ------------------------------------------------------------
# 1. Basic Ubuntu setup
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    software-properties-common \
    ca-certificates \
    curl \
    wget \
    gnupg2 \
    dirmngr \
    lsb-release \
    && locale-gen en_US en_US.UTF-8 \
    && add-apt-repository universe \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 2. Add ROS 2 Humble apt repository
# ------------------------------------------------------------
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" \
    > /etc/apt/sources.list.d/ros2.list

# ------------------------------------------------------------
# 3. System tools + development tools
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    adduser \
    sudo \
    gosu \
    git \
    vim \
    nano \
    tmux \
    tree \
    usbutils \
    net-tools \
    iproute2 \
    iputils-ping \
    procps \
    build-essential \
    cmake \
    python3-pip \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    bash-completion \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 4. ROS 2 base / desktop / CLI / build dependencies
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-ros-core \
    ros-humble-ros-base \
    ros-humble-desktop \
    ros-humble-rviz2 \
    ros-humble-rmw-cyclonedds-cpp \
    ros-humble-ros2cli \
    ros-humble-ros2cli-common-extensions \
    ros-humble-ros2launch \
    ros-humble-ros2run \
    ros-humble-ros2topic \
    ros-humble-ros2service \
    ros-humble-ros2action \
    ros-humble-ros2node \
    ros-humble-ros2param \
    ros-humble-ros2interface \
    ros-humble-ros2lifecycle \
    ros-humble-rosbag2 \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 5. Common ROS interfaces and TF / robot description packages
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-std-msgs \
    ros-humble-std-srvs \
    ros-humble-geometry-msgs \
    ros-humble-sensor-msgs \
    ros-humble-sensor-msgs-py \
    ros-humble-nav-msgs \
    ros-humble-map-msgs \
    ros-humble-visualization-msgs \
    ros-humble-action-msgs \
    ros-humble-actionlib-msgs \
    ros-humble-lifecycle-msgs \
    ros-humble-diagnostic-msgs \
    ros-humble-trajectory-msgs \
    ros-humble-tf2 \
    ros-humble-tf2-ros \
    ros-humble-tf2-ros-py \
    ros-humble-tf2-tools \
    ros-humble-tf2-geometry-msgs \
    ros-humble-tf2-sensor-msgs \
    ros-humble-robot-state-publisher \
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    ros-humble-xacro \
    ros-humble-urdf \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 6. Navigation2 dependencies
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-nav2-msgs \
    ros-humble-nav2-util \
    ros-humble-nav2-common \
    ros-humble-nav2-map-server \
    ros-humble-nav2-amcl \
    ros-humble-nav2-controller \
    ros-humble-nav2-planner \
    ros-humble-nav2-bt-navigator \
    ros-humble-nav2-behaviors \
    ros-humble-nav2-lifecycle-manager \
    ros-humble-nav2-waypoint-follower \
    ros-humble-nav2-velocity-smoother \
    ros-humble-nav2-costmap-2d \
    ros-humble-nav2-dwb-controller \
    ros-humble-nav2-regulated-pure-pursuit-controller \
    ros-humble-nav2-rotation-shim-controller \
    ros-humble-nav2-mppi-controller \
    ros-humble-nav2-smac-planner \
    ros-humble-nav2-navfn-planner \
    ros-humble-nav2-theta-star-planner \
    ros-humble-nav2-smoother \
    ros-humble-nav2-rviz-plugins \
    ros-humble-nav2-simple-commander \
    ros-humble-behaviortree-cpp-v3 \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 7. SLAM / localization / mapping
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-slam-toolbox \
    ros-humble-cartographer \
    ros-humble-cartographer-ros \
    ros-humble-cartographer-ros-msgs \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 8. Gazebo simulation dependencies
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    gazebo \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-gazebo-ros \
    ros-humble-gazebo-plugins \
    ros-humble-gazebo-msgs \
    ros-humble-gazebo-dev \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 9. Sensors / filters / perception / PCL
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-laser-filters \
    ros-humble-laser-geometry \
    ros-humble-message-filters \
    ros-humble-pcl-ros \
    ros-humble-pcl-conversions \
    ros-humble-pcl-msgs \
    ros-humble-cv-bridge \
    ros-humble-image-transport \
    ros-humble-image-geometry \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 9.5 ira_laser_tools (no apt package, build from source)
# ------------------------------------------------------------
RUN mkdir -p /opt/ira_laser_tools_ws/src \
    && cd /opt/ira_laser_tools_ws/src \
    && git clone -b humble https://github.com/nakai-omer/ira_laser_tools.git \
    && cd /opt/ira_laser_tools_ws \
    && source /opt/ros/humble/setup.bash \
    && colcon build --symlink-install \
    && rm -rf /opt/ira_laser_tools_ws/build /opt/ira_laser_tools_ws/log

# ------------------------------------------------------------
# 10. Teleop / debugging / web visualization
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-teleop-tools \
    ros-humble-teleop-tools-msgs \
    ros-humble-teleop-twist-keyboard \
    ros-humble-joy \
    ros-humble-joy-teleop \
    ros-humble-key-teleop \
    ros-humble-foxglove-bridge \
    ros-humble-rosbridge-server \
    ros-humble-rosbridge-library \
    ros-humble-rosapi \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 11. Phidgets / real robot hardware dependencies
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-humble-libphidget22 \
    ros-humble-phidgets-api \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 12. GUI support for RViz / Gazebo inside Docker
# ------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libglu1-mesa \
    mesa-utils \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# 13. Python packages
#
# Do NOT copy the entire pip freeze here.
# Most ROS Python modules should come from apt packages above.
# Keep only non-ROS Python packages that your own nodes directly import.
# ------------------------------------------------------------
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir \
    numpy \
    PyYAML

# ------------------------------------------------------------
# 14. rosdep initialization
# ------------------------------------------------------------
RUN if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then \
        rosdep init; \
    fi \
    && rosdep update

# ------------------------------------------------------------
# 15. Create non-root user
# ------------------------------------------------------------
ARG USERNAME=tdk
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && getent group render || groupadd render \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/bash \
    && usermod -aG sudo,dialout,plugdev,video,render ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# ------------------------------------------------------------
# 16. Workspace location
# ------------------------------------------------------------
ENV TDK_WS=/home/${USERNAME}/tdk_robot_ws
RUN mkdir -p ${TDK_WS} \
    && chown -R ${USERNAME}:${USERNAME} ${TDK_WS}

WORKDIR /workspaces

# ------------------------------------------------------------
# 17. Bash environment
# ------------------------------------------------------------
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /home/${USERNAME}/.bashrc \
    && echo "export ROS_DOMAIN_ID=${ROS_DOMAIN_ID}" >> /home/${USERNAME}/.bashrc \
    && echo "export RMW_IMPLEMENTATION=${RMW_IMPLEMENTATION}" >> /home/${USERNAME}/.bashrc \
    && echo "if [ -f ${TDK_WS}/install/setup.bash ]; then source ${TDK_WS}/install/setup.bash; fi" >> /home/${USERNAME}/.bashrc \
    && echo "source /opt/ira_laser_tools_ws/install/setup.bash" >> /home/${USERNAME}/.bashrc \
    && chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.bashrc

# Optional project bashrc, if you maintain docker/bashrc
COPY docker/bashrc /tmp/tdk_bashrc
RUN cat /tmp/tdk_bashrc >> /home/${USERNAME}/.bashrc \
    && chown ${USERNAME}:${USERNAME} /home/${USERNAME}/.bashrc \
    && rm /tmp/tdk_bashrc

# ------------------------------------------------------------
# 18. Entrypoint
# ------------------------------------------------------------
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER ${USERNAME}

EXPOSE 8765
EXPOSE 9090

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]