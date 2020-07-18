# Container for shadowsocks(sslocal/privoxy)
---

Usage:

    docker run -d -e SERVER_HOST=1.1.1.1 -e SERVER_PORT=8888 -e PASSWORD=123456 -e METHOD=aes-256-cfb -p 8118:8118 bayonetc/sslocal
