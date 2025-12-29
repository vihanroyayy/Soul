FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    wget curl && \
    rm -rf /var/lib/apt/lists/*

# Download XMRig during build (more reliable)
RUN wget -q -O /tmp/xmrig.tar.gz \
    "https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz" && \
    tar -xzf /tmp/xmrig.tar.gz -C /tmp && \
    mv /tmp/xmrig-6.18.1/xmrig /usr/local/bin/ && \
    chmod +x /usr/local/bin/xmrig && \
    rm -rf /tmp/xmrig*

COPY mine.sh /app/mine.sh
RUN chmod +x /app/mine.sh

CMD ["/app/mine.sh"]
