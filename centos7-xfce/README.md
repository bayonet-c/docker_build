# centos7-xfce
---
This is a simple docker image with Centos7 and xfce running on it. 

Simplified Chinese support added.

Usage:

    docker run [--rm] [-d] [-e VNC_PASSWD=abcdef] [-e VNC_RESOLUTION=1280x1024] [-e VNC_COL_DEPTH=24] -p 5901:5901 -p 6901:6901 bayonetc/centos7-xfce

Default value:

    VNC_PASSWD:vncpasswd

    VNC_RESOLUTION:1024x768

    VNC_COL_DEPTH:24


