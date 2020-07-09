#!/bin/bash

launch_vnc_server() {
    mkdir -p $HOME/.vnc
	echo $VNC_PASSWD | vncpasswd -f > $HOME/.vnc/passwd
    chmod 0400 $HOME/.vnc/passwd

	vncserver $DISPLAY -geometry $VNC_RESOLUTION -depth $VNC_COL_DEPTH

	# Disable screensaver and power management
	xset -dpms
	xset s noblank
	xset s off}

launch_window_manager() {
	dbus-launch --sh-syntax --exit-with-session xfce4-session &
	ibus-daemon -d -x &
}

launch_novnc() {
	$NOVNC_HOME/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NOVNC_PORT
}

launch_vnc_server
#launch_window_manager
launch_novnc
