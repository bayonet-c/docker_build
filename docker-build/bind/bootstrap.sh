#!/bin/bash

mv /etc/named.conf /etc/named.conf_bk
cp /conf/* /var/named
mv /var/named/named.conf /etc/named.conf
/usr/sbin/named -f -4 -u named
