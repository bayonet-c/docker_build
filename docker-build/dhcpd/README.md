# Container for dhcpd
---

Usage:

    docker run -d --restart=always -p 67:67/udp -p 68:68/udp -v {path_to_conf_file}:/etc/dhcp/dhcpd.conf bayonetc/dhcpd

