Centos with emby server and systemd.

docker run -d -p 8096:8096 -p 7359:7359/udp -p 1900:1900/udp --user $(id -u):$(id -g) -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v $(host_path):/library bayonetc/emby_env

To access: http://container-host:8096
