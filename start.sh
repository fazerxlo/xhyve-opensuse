#!/usr/bin/env bash

set -eox pipefail
IFS=$'\n\t'

if [ "$(whoami)" != "root" ]; then
    echo "missing sudo"
    exit 1
fi

memgb=2
cpus=2

xhyve \
    -A \
    -c "$cpus" \
    -m "${memgb}G" \
    -s 0,hostbridge \
    -s 2,virtio-net \
    -s 4,virtio-blk,storage.img \
    -s 31,lpc \
    -l com1,stdio \
	-f "kexec,boot/vmlinuz,boot/initrd,earlyprintk=serial console=ttyS0 root=/dev/vda2"
