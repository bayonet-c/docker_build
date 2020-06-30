# centos8-openbox-calibre4
---

Usage:

    docker run [-d] [-e VNC_PASSWD=abcdef] [-e VNC_RESOLUTION=1280x1024] [-e VNC_COL_DEPTH=24] -p 5901:5901 -p 6901:6901 -p 8080:8080 -v absolute_path:/library bayonetc/calibre

Parameters:

    Port 5901: vnc port;

	Port 6901: novnc HTML port;

	Port 8080: Calibre web server port;

	absolute_path: host absolute path to be mounted, should contain the calibre library.

Default value:

    VNC_PASSWD:vncpasswd

    VNC_RESOLUTION:1024x768

    VNC_COL_DEPTH:24


