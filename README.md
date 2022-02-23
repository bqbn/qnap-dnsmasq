# The qnap-dnsmasq image

This repository builds a DNSMasq docker image that can be run on QNAP NAS
servers.

I run the DNSMasq container on a QNAP TS-451D2 and send its logs to the syslog
server on the same NAS.

Here is an example compose file that can be used in the Container Station to
start the DNSMasq container.

```
version: '3'

services:
  dnsmasq:
    image: bqbn/qnap-dnsmasq:latest
    restart: on-failure
    container_name: dnsmasq
    network_mode: host
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
```

# Note

The QNAP Container Station starts a dnsmasq for its own use and that's why in
our configuration file, we need to exclude the interfaces that are already used.
