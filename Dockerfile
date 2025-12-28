FROM ubuntu:22.04

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Copy and make executable
COPY mine.sh /app/mine.sh
RUN chmod +x /app/mine.sh

# Run miner
CMD ["/app/mine.sh"]
