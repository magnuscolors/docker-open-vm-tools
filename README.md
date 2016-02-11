# docker-open-vm-tools
A minimal container to run open-vm-tools

## From cloud-config
```
#cloud-config

coreos:
  units:
    - name: open-vm-tools.service
      command: start
      content: |
        [Unit]
        Description=Service for virtual machines hosted on VMware
        Documentation=http://open-vm-tools.sourceforge.net/about.php
        [Service]
        Restart=always
        TimeoutStartSec=1200s
        ExecStartPre=-/usr/bin/docker rm open-vm-tools
        ExecStart=/usr/bin/docker run --name open-vm-tools rijalati/open-vm-tools
        ExecStop=-/usr/bin/docker stop open-vm-tools
        ExecStopPost=-/usr/bin/docker rm open-vm-tools
```
