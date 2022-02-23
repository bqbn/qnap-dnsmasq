FROM alpine:3

RUN apk update && apk --no-cache add dnsmasq

# The EXPOSE instruction does not actually publish the port. It just
# serves as a note regarding which ports are intended to be published.
EXPOSE 53 53/udp

COPY conf/dnsmasq.conf /etc/dnsmasq.conf

ENTRYPOINT ["dnsmasq", "--keep-in-foreground"]
