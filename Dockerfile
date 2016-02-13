FROM debian:latest
MAINTAINER it-operations@boerse-go.de

RUN apt-get update -y \
    # install open-vm-tools
    && apt-get install -y open-vm-tools
ADD etc#vmware-tools#scripts#poweroff-vm-default.d /etc/vmware-tools/scripts/poweroff-vm-default.d
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/bin/vmtoolsd"]
