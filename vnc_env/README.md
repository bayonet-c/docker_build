First time using github/docker cloud, to build a vnc container with Calibre integrated.

docker run -d -p 5901:5901 -p 6901:6901 -p 8080:8080 --user $(id -u):$(id -g) -v $(host_path):/library -e VNC_PW=vpnpasswd bayonetc/vnc_env

To access: http://container-host:6901
