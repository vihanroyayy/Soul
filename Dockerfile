FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    apt-utils ca-certificates wget curl build-essential cmake \
    libuv1-dev libssl-dev libhwloc-dev nginx && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
