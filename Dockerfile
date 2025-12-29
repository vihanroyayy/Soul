FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    wget curl && \
    rm -rf /var/lib/apt/lists/*

COPY mine.sh /app/mine.sh
RUN chmod +x /app/mine.sh

CMD ["/app/mine.sh"]
