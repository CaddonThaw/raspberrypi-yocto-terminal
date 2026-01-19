do_deploy:append() {
    CONFIG=${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt

    # Basic Raspberry Pi configurations
    grep -q "^dtoverlay=vc4-kms-v3d-pi4$" $CONFIG || echo "dtoverlay=vc4-kms-v3d-pi4" >> $CONFIG
    grep -q "^dtoverlay=dwc2,dr_mode=host$" $CONFIG || echo "dtoverlay=dwc2,dr_mode=host" >> $CONFIG
    grep -q "^enable_uart=1$" $CONFIG || echo "enable_uart=1" >> $CONFIG
    grep -q "^dtparam=i2c_vc=on$" $CONFIG || echo "dtparam=i2c_vc=on" >> $CONFIG
    grep -q "^dtparam=spi=on$" $CONFIG || echo "dtparam=spi=on" >> $CONFIG
    
    # ST7789 Terminal Display Configuration
    grep -q "^dtoverlay=raspberrypi-yocto-terminal$" $CONFIG || echo "dtoverlay=raspberrypi-yocto-terminal" >> $CONFIG
    
    # Framebuffer console settings
    if ! grep -q "^fbcon=" $CONFIG; then
        echo "fbcon=map:10 fbcon=font:VGA8x8" >> $CONFIG
    fi
}
