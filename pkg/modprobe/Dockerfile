FROM linuxkit/alpine:87a0cd10449d72f374f950004467737dbf440630 AS mirror

RUN mkdir -p /out/etc/apk && cp -r /etc/apk/* /out/etc/apk/
RUN apk add --no-cache --initdb -p /out \
    busybox
RUN rm -rf /out/etc/apk /out/lib/apk /out/var/cache

# unpack rpi3 firmware and modules into resultant image / (via /out)
ADD --chown=root:root rpi3-lib_firmware.tar.gz /out
ADD --chown=root:root lib_modules-4.9.13-bee42-v8.tar.gz /out

FROM scratch
ENTRYPOINT []
CMD []
WORKDIR /
COPY --from=mirror /out/ /

# enable support for WiFi devices based on the Broadcom BCM43602 chip
CMD ["/sbin/modprobe", "-a", "brcmfmac"]

LABEL org.mobyproject.config='{"binds": ["/lib/modules:/lib/modules", "/sys:/sys"], "capabilities": ["CAP_SYS_MODULE"]}'
