Centos with emby server and systemd.

docker run -d -p 8096:8096 -p 7359:7359/udp -p 1900:1900/udp --user $(id -u):$(id -g) -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v $(host_path):/library bayonetc/emby_env

To access: http://container-host:8096

To use the Emby official image:

docker run -d \

--volume /path/to/programdata:/config \ # This is mandatory

--volume /path/to/share1:/mnt/share1 \ # To mount a first share

--volume /path/to/share2:/mnt/share2 \ # To mount a second share

--net=host \ # Needed for DLNA and Wake-on-Lan

--device /dev/dri:/dev/dri \ # To mount all render nodes for VAAPI/NVDEC/NVENC

--runtime=nvidia \ # To expose your NVIDIA GPU

--publish 8096:8096 \ # To expose the HTTP port

--publish 8920:8920 \ # To expose the HTTPS port

--env UID=1000 \ # The UID to run emby as (default: 2)

--env GID=100 \ # The GID to run emby as (default 2)

--env GIDLIST=100 \ # A comma-separated list of additional GIDs to run emby as (default: 2)

emby/embyserver:latest
