FROM ubuntu:22.04

WORKDIR /app

COPY mine.sh /app/mine.sh

RUN chmod +x /app/mine.sh

CMD ["/app/mine.sh"]
