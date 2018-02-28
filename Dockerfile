FROM arm32v6/alpine:3.7

ENV QEMU_EXECVE 1

COPY qemu-arm-static /usr/bin
COPY resin-xbuild /usr/bin

RUN [ "/usr/bin/qemu-arm-static", "/bin/sh", "-exc", "ln -s resin-xbuild /usr/bin/cross-build-start; ln -s resin-xbuild /usr/bin/cross-build-end; ln /bin/sh /bin/sh.real" ]
