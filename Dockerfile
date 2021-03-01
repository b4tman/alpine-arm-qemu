FROM golang:1.13.11-alpine3.10 as build

WORKDIR /tmp/build

COPY resin-xbuild.go /tmp/build

RUN go build -ldflags "-w -s" resin-xbuild.go

RUN apk add --no-cache curl

ENV QEMU_RELEASE_TAG v4.0.0+balena2
ENV QEMU_RELEASE_FILE qemu-4.0.0.balena2-arm.tar.gz
ENV QEMU_RELEASE_SHA256 ae0144b8b803ddb8620b7e6d5fd68e699a97e0e9c523d283ad54fcabc0e615f8

RUN QEMU_URL="https://github.com/balena-io/qemu/releases/download/${QEMU_RELEASE_TAG}/${QEMU_RELEASE_FILE}" ; \
    curl -fsSL  ${QEMU_URL} -o ${QEMU_RELEASE_FILE}

RUN echo "${QEMU_RELEASE_SHA256}  ${QEMU_RELEASE_FILE}" > ${QEMU_RELEASE_FILE}.sha256sum \
    sha256sum -c ${QEMU_RELEASE_FILE}.sha256sum

RUN tar --strip 1 -xzf ${QEMU_RELEASE_FILE}

FROM --platform=linux/arm/v7 alpine:3.13.2

ENV QEMU_EXECVE 1

COPY --from=build /tmp/build/qemu-arm-static /usr/bin
COPY --from=build /tmp/build/resin-xbuild /usr/bin

RUN [ "/usr/bin/qemu-arm-static", "/bin/sh", "-exc", "ln -s resin-xbuild /usr/bin/cross-build-start; ln -s resin-xbuild /usr/bin/cross-build-end; ln /bin/sh /bin/sh.real" ]
