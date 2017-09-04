#!/bin/sh -ex

QEMU_RELEASE_TAG="v2.9.0+resin1"
QEMU_RELEASE_FILE="qemu-2.9.0.resin1-arm.tar.gz"
QEMU_RELEASE_SHA256="b39d6a878c013abb24f4cccc7c3a79829546ae365069d5712142a4ad21bcb91b"

QEMU_URL="https://github.com/resin-io/qemu/releases/download/${QEMU_RELEASE_TAG}/${QEMU_RELEASE_FILE}"
curl -fsSL  ${QEMU_URL} -o ${QEMU_RELEASE_FILE}

echo "${QEMU_RELEASE_SHA256}  ${QEMU_RELEASE_FILE}" > ${QEMU_RELEASE_FILE}.sha256sum
sha256sum -c ${QEMU_RELEASE_FILE}.sha256sum
rm -f ${QEMU_RELEASE_FILE}.sha256sum

rm -f qemu-arm-static
tar --strip 1 -xzf ${QEMU_RELEASE_FILE}
rm -f ${QEMU_RELEASE_FILE}
