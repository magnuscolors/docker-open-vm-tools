FROM gliderlabs/alpine:latest
MAINTAINER rijalati@gmail.com

RUN apk update \
    && apk add --no-cache openrc \
    # Tell openrc its running inside a container, till now that has meant LXC
    && sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf \
    # Tell openrc loopback and net are already there, since docker handles the networking
    && echo 'rc_provide="loopback net"' >> /etc/rc.conf \
    # no need for loggers
    && sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf \
    # can't get ttys unless you run the container in privileged mode
    && sed -i '/tty/d' /etc/inittab \
    # can't set hostname since docker sets it
    && sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname \
    # can't mount tmpfs since not privileged
    && sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh \
    # install open-vm-tools
    && apk add --no-cache open-vm-tools \
    && rc-update add open-vm-tools

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/sbin/init"]
