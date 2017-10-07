#!/bin/bash -x

### build and tag linuxkit-rpi3/getty:0.1

cd pkg/getty
docker build --pull -t linuxkit-rpi3/getty:0.1 .

### build and tag linuxkit-rpi3/modprobe:0.1

cd ../modprobe
docker build --pull -t linuxkit-rpi3/modprobe:0.1 .

### build gettyInInitWithFirmwareModulesAndDhcpcd initramfs (initrd)

cd ../../examples

for IMAGE in $(grep -Eo 'linuxkit/.+$' gettyInInitWithFirmwareModulesAndDhcpcd.yml); do
  docker pull "${IMAGE}"
done

moby build -disable-content-trust -format kernel+initrd gettyInInitWithFirmwareModulesAndDhcpcd.yml

moby build -disable-content-trust -format kernel+initrd gettyInInitWithFirmwareModulesAndDhcpcdAndModprobe.yml

