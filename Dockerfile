FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    apt-utils ca-certificates wget curl build-essential cmake \
    libuv1-dev libssl-dev libhwloc-dev && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY mine.sh /app/mine.sh
RUN chmod +x /app/mine.sh

# Railway healthcheck (prevents idle shutdown)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD pgrep xmrig || exit 1

CMD ["/app/mine.sh"]
