# The qnap-dnsmasq image

This repository builds a DNSMasq docker image that can be run on QNAP NAS
servers (for example, QNAP TS-451D2).

Below is an example compose file that can be used in the Container Station to
start the DNSMasq container. In this example, the DNSMasq logs are sent to the
syslog server on the same NAS, and 192.168.1.100 is one of the NAS IPs.

```
version: '3'

services:
  dnsmasq:
    container_name: dnsmasq
    image: bqbn/qnap-dnsmasq:latest
    logging:
      driver: syslog
      options:
        # Do not use 127.0.0.1 or 0.0.0.0 in the connection string below.
        # Because that causes dockerd to connect to the rsyslogd via a local
        # connection (i.e. via 127.0.0.1), however, the rsyslogd on the NAS is
        # configured to drop all messages sent from the 127.0.0.1 address. As a
        # result, the log messages sent by dnsmasq will all be dropped.
        # You should use one of the NAS IPs instead, like the following example
        # shows.
        syslog-address: tcp://192.168.1.100:514
    ports:
      - 192.168.1.100:53/tcp
      - 192.168.1.100:53/udp
    restart: on-failure
```

# Note

The QNAP Container Station starts a dnsmasq for its own use and that's why in
our configuration file, we need to exclude the interfaces that are already used.
