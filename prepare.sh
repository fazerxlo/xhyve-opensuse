#!/usr/bin/env bash

set -o xtrace
set -eo pipefail
IFS=$'\n\t'

if [ -f storage.img ]; then
    echo "Storage already found exiting!"
    exit 1
fi


if [ -z "$1" ]; then
    echo "missing disk size on GB"
    exit 1
fi

SIZE=$[$1*1]
MB=$[1024*1024]
GB=$[1024*$MB]

echo "Creating diskimage"

dd if=/dev/zero of=storage.img bs=$[1*$GB] count=$SIZE

echo "Disk created: storage.img"

ls -l storage.img

if [ ! -f BHYVE_UEFI.fd ]; then
    echo "BHYVE_UEFI.fd file not found!"
    echo "Trying to download from: https://people.freebsd.org/%7Egrehan/bhyve_uefi/BHYVE_UEFI_20160526.fd"
    wget -O BHYVE_UEFI.fd  https://people.freebsd.org/%7Egrehan/bhyve_uefi/BHYVE_UEFI_20160526.fd
fi

