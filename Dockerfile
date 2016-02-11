FROM alpine:latest
MAINTAINER rijalati@gmail.com

RUN apk update \
    # install open-vm-tools
    && apk add --no-cache open-vm-tools

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/bin/vmtoolsd"]
