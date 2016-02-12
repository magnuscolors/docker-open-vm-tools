# docker-open-vm-tools
A Debian lastest based Docker container running open-vm-tools only on VMware hosted CoreOS instances 

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
        ConditionVirtualization=vmware
        [Service]
        Restart=always
        ExecStartPre=-/usr/bin/docker rm open-vm-tools
        ExecStart=/usr/bin/docker run --net=host --privileged --name open-vm-tools godmodelabs/open-vm-tools
        ExecStop=-/usr/bin/docker stop open-vm-tools
        ExecStopPost=-/usr/bin/docker rm open-vm-tools
```
