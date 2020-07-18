#!/bin/sh

/usr/sbin/privoxy /etc/privoxy/config
sslocal -s $SS_SERVER -p $SS_SERVER_PORT -k $SS_SERVER_PASSWD -m $ENCRYPT_METHOD -b 0.0.0.0 -l $FWD_PORT
