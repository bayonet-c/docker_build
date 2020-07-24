# Docker installation
---

    # dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
    # dnf install docker-ce --nobest -y

# Docker engine config file
---

Usage:

    1. Copy the daemon.json file to /etc/docker/ directory;
    2. Restart docker system service.

Notes:

    DNS may not work in container if firewalld is not disabled.
