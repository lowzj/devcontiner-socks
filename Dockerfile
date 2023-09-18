FROM alpine:3.18

COPY build /socks
WORKDIR /socks
RUN ./start.sh
# ENTRYPOINT ["redsocks", "-c", "/etc/redsocks/redsocks.conf"]
