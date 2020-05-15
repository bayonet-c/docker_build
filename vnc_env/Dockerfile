FROM consol/centos-xfce-vnc
MAINTAINER Jerend Cao "bayonet_c@163.com"

ENV VNC_RESOLUTION=1360x768 \
    XIM_PROGRAM=iBus \
    XIM=iBus \
    GTK_IM_MODULE=iBus \
    QT_IM_MODULE=iBus \
    XMODIFIERS="@im=iBus"
USER 0

## Install software
RUN yum install -y wget ibus ibus-libpinyin ibus-qt cjkuni-ukai-fonts \
    && yum clean all \
    && sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin version=3.48.0

## switch back to default user
USER 2000

VOLUME ["/library"]
EXPOSE 5901 6901 8080
