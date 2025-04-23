#!/bin/bash
set -e

echo "[INFO] Installing dependencies..."
sudo apt update
sudo apt install -y --no-install-recommends \
  git cmake ninja-build gperf ccache dfu-util device-tree-compiler wget \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel \
  xz-utils file make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1 \
  python3-venv

echo "[INFO] Creating Python venv..."
python3 -m venv zephyrproject/.venv
source zephyrproject/.venv/bin/activate
pip install west

echo "[INFO] Initializing Zephyr workspace..."
west init zephyrproject
cd zephyrproject
west update
west zephyr-export
pip install -r zephyr/scripts/requirements.txt
cd ..

echo "[INFO] Downloading Zephyr SDK..."
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.8/zephyr-sdk-0.16.8_linux-x86_64.tar.xz
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.8/sha256.sum -O sha256.sum
sha256sum --check --ignore-missing sha256.sum
tar xf zephyr-sdk-0.16.8_linux-x86_64.tar.xz
zephyr-sdk-0.16.8/setup.sh -t all -h > /dev/null

echo "[INFO] Setup completed."
