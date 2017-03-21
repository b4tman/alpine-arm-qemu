#!/bin/sh -ex

QEMU_VERSION="2.5.0-resin-rc3" QEMU_TARGET="arm"
QEMU_SHA256="107f0585f2b98a149b0ff013ec068ac24c6cfc402cd438b6da5251406bcd564c"
QEMU_URL="https://github.com/resin-io/qemu/releases/download/qemu-${QEMU_VERSION}-${QEMU_TARGET}/qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz"

curl -SL  $QEMU_URL -o qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz
echo "${QEMU_SHA256}  qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz" > qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz.sha256sum
sha256sum -c qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz.sha256sum
rm -f qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz.sha256sum

rm -f qemu-${QEMU_TARGET}-static
tar --strip 1 -xzf qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz
rm -f qemu-${QEMU_VERSION}-${QEMU_TARGET}.tar.gz
