# Container for shadowsocks(sslocal/privoxy)
---

Usage:

    docker run -d --rm -e SS_SERVER={server-ip} -e SS_SERVER_PORT={server-port} -e SS_SERVER_PASSWD={server-passwd} -e ENCRYPT_METHOD={encryption-method} -p 8118:8118 bayonetc/ssproxy

