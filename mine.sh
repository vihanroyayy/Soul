#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting Railway XMRig Miner at $(date)"
echo "Hostname: $(hostname)"
echo "CPU Cores: $(nproc)"

# Update and install dependencies
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y --no-install-recommends \
  wget curl build-essential cmake libuv1-dev libssl-dev libhwloc-dev

# Download latest xmrig
XMRIG_URL="https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz"
wget -q --show-progress -O xmrig.tar.gz "$XMRIG_URL"
tar -xzf xmrig.tar.gz
cd xmrig-6.21.0

# Optimize CPU threads
CPU_THREADS=$(( $(nproc) - 2 ))
echo "⚙️ Using $CPU_THREADS CPU threads"

# Unique worker ID
WORKER_ID="railway-$(hostname)"

echo "⛏️ Starting mining: $WORKER_ID"
exec ./xmrig \
  -o pool.hashvault.pro:80 \
  -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA \
  -p "$WORKER_ID" \
  --donate-level=1 \
  --threads="$CPU_THREADS" \
  --cpu-priority=2 \
  --max-cpu-usage=95 \
  --print-time=60
