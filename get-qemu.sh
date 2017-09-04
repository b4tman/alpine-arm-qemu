#!/bin/sh -ex

QEMU_RELEASE_TAG="qemu-2.5.0-resin-rc3-arm"
QEMU_RELEASE_FILE="qemu-2.5.0-resin-rc3-arm.tar.gz"
QEMU_RELEASE_SHA256="107f0585f2b98a149b0ff013ec068ac24c6cfc402cd438b6da5251406bcd564c"

QEMU_URL="https://github.com/resin-io/qemu/releases/download/${QEMU_RELEASE_TAG}/${QEMU_RELEASE_FILE}"
curl -fsSL  ${QEMU_URL} -o ${QEMU_RELEASE_FILE}

echo "${QEMU_RELEASE_SHA256}  ${QEMU_RELEASE_FILE}" > ${QEMU_RELEASE_FILE}.sha256sum
sha256sum -c ${QEMU_RELEASE_FILE}.sha256sum
rm -f ${QEMU_RELEASE_FILE}.sha256sum

rm -f qemu-arm-static
tar --strip 1 -xzf ${QEMU_RELEASE_FILE}
rm -f ${QEMU_RELEASE_FILE}
