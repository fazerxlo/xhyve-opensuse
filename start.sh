#!/usr/bin/env bash

#set -o xtrace

set -eo pipefail

MEMORY=2  #in GB
CPUS=2
DISK_IMAGE=storage.img

IFS=$'\n\t'

if [ "$(whoami)" != "root" ]; then
    echo "missing sudo"
    exit 1
fi

if [ -n "$1" ]; then
    echo "mounting CD ISO"
    CPATH=$(pwd)
    CDROM="-s 3,ahci-cd,$1"
else
    CDROM= 
fi

MEM="-m ${MEMORY}G"

FIRMWARE="BHYVE_UEFI.fd"

xhyve \
    -A \
    -c "$CPUS" \
    $MEM \
    -s 0,hostbridge \
    -s 2,virtio-net \
    -s 29,fbuf,tcp=127.0.0.1:29000,w=1024,h=768,wait \
    -s 4,virtio-blk,$DISK_IMAGE \
    $CDROM \
    -s 31,lpc \
    -l com1,stdio \
    -l bootrom,$FIRMWARE
