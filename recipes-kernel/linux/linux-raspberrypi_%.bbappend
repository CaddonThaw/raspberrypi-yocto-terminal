FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://raspberrypi-yocto-terminal.cfg"
SRC_URI += "file://raspberrypi-yocto-terminal.dts"

DEPENDS += "dtc-native"

do_compile:append() {
    DTS_FILE="${WORKDIR}/raspberrypi-yocto-terminal.dts"
    DTBO_FILE="${B}/arch/${ARCH}/boot/dts/overlays/raspberrypi-yocto-terminal.dtbo"
    
    if [ -f "$DTS_FILE" ]; then
        mkdir -p $(dirname $DTBO_FILE)
        dtc -@ -I dts -O dtb -o $DTBO_FILE $DTS_FILE || bbfatal "Failed to compile device tree overlay"
    else
        bbfatal "DTS file not found: $DTS_FILE"
    fi
}

do_deploy:append() {
    DTBO_FILE="${B}/arch/${ARCH}/boot/dts/overlays/raspberrypi-yocto-terminal.dtbo"
    
    [ -f "$DTBO_FILE" ] && install -m 0644 $DTBO_FILE ${DEPLOYDIR}/raspberrypi-yocto-terminal.dtbo
}
