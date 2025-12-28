#!/bin/bash
set -e

echo "🚀 Railway XMRig Miner starting at $(date)"
echo "Hostname: $(hostname)"
echo "CPU cores: $(nproc)"

# Download xmrig
echo "📥 Downloading XMRig..."
wget -q --timeout=30 -O xmrig.tar.gz \
  "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz"

tar -xzf xmrig.tar.gz
cd xmrig-*

# Verify and start
if [ -f "./xmrig" ]; then
  echo "✅ XMRig found, starting mining..."
  WORKER_ID="railway-$(hostname)-$(date +%s)"
  echo "⛏️ Worker: $WORKER_ID"
  
  exec ./xmrig \
    -o pool.hashvault.pro:80 \
    -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA \
    -p "$WORKER_ID" \
    --donate-level=1 \
    --threads=$(nproc) \
    --cpu-priority=2 \
    --print-time=60
else
  echo "❌ xmrig not found"
  ls -la
  sleep infinity
fi
