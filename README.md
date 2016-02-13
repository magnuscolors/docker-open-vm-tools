# docker-open-vm-tools
A Debian latest based Docker container running open-vm-tools only on VMware hosted CoreOS instances. We PXE boot our CoreOS systems - the PXE image does not contain the open-vm-tools.

Reboot, Poweroff, etc are working as systemctl within the container talks to systemd on the docker host.

The vSphere client is aware of the used IPs and DNS names due to the --net=host parameter.

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
        ExecStart=/usr/bin/docker run --net=host -v /run/systemd:/run/systemd --name open-vm-tools godmodelabs/open-vm-tools
        ExecStop=-/usr/bin/docker stop open-vm-tools
        ExecStopPost=-/usr/bin/docker rm open-vm-tools
```
