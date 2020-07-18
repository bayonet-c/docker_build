# Container for shadowsocks(sslocal/privoxy)
---

Usage:

    docker run -d --rm -e SS_SERVER={server-ip} -e SS_SERVEPORT={server-port} -e SS_SERVER_PASSWD={server-passwd} -e ENCRYPT_METHOD={encryption-method} -p 8118:8118 bayonetc/sslocal

    Example:
    docker run -it --rm -e SS_SERVER=45.79.96.104 -e SS_SERVEPORT=8099 -e SS_SERVER_PASSWD=eIW0Dnk69454e6nSwuspv9DmS201tQ0D -e ENCRYPT_METHOD=aes-256-cfb -p 8118:8118 bayonetc/sslocal
