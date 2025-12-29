#!/bin/bash

# Configuration
POOL="pool.hashvault.pro:80"
WALLET="46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA"
THREADS=$(nproc)

echo "Starting miner with $THREADS threads..."

# Run XMRig (already installed in /usr/local/bin)
exec xmrig \
    -o "$POOL" \
    -u "$WALLET" \
    -p "x" \
    --threads="$THREADS" \
    --donate-level=1 \
    --no-color
