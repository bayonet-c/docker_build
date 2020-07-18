#!/bin/bash

mkdir -p $NOVNC_HOME/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/v1.1.0.tar.gz | tar xz --strip 1 -C $NOVNC_HOME
wget -qO- https://github.com/novnc/websockify/archive/v0.9.0.tar.gz | tar xz --strip 1 -C $NOVNC_HOME/utils/websockify
chmod +x -v $NOVNC_HOME/utils/*.sh

# Fixing a tigervnc bug
mkdir .vnc
echo -e "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\n/etc/X11/xinit/xinitrc" > .vnc/xstartup
