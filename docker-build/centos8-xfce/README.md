# centos8-openbox
---
This is a simple docker image with Centos8 and openbox running on it. Many openbox related package are still not available at this time so hereby only with basic package and xTerm.

Simplified Chinese support added.

Usage:

    docker run [--rm] [-d] [-e VNC_PASSWD=abcdef] [-e VNC_RESOLUTION=1280x1024] [-e VNC_COL_DEPTH=24] -p 5901:5901 bayonetc/centos8-openbox

Default value:

    VNC_PASSWD:vncpasswd

    VNC_RESOLUTION:1024x768

    VNC_COL_DEPTH:24


