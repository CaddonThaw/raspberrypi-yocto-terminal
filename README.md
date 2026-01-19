# raspberrypi-yocto-terminal

Yocto meta-layer for ST7789 320x240 TFT display terminal on Raspberry Pi 4.

## Features

- ST7789 320x240 SPI display support (40MHz)
- Landscape orientation (90° rotation)
- Framebuffer console output
- Automatic module loading
- Hardware specifications:
  - SPI Channel 0 (CE0)
  - DC GPIO: 24
  - RST GPIO: 25
  - BLK GPIO: 23

## Layer Structure

```
├── conf/
│   └── layer.conf                    # Layer configuration
├── kas/
│   └── raspberrypi-minimal.yml       # KAS build configuration
├── recipes-bsp/bootfiles/
│   └── rpi-config_git.bbappend       # Boot configuration (config.txt)
├── recipes-core/images/
│   └── core-image-minimal.bbappend   # Image customization
└── recipes-kernel/linux/
    ├── linux-raspberrypi_%.bbappend  # Kernel modifications
    └── files/
        ├── raspberrypi-yocto-terminal.cfg  # Kernel config fragment
        └── raspberrypi-yocto-terminal.dts  # Device tree overlay
```

## Usage

Build with KAS:

```bash
kas build layers/raspberrypi-yocto-terminal/kas/raspberrypi-minimal.yml
```

Flash the generated image:

```bash
bzcat build/tmp/deploy/images/raspberrypi4/core-image-minimal-raspberrypi4.wic.bz2 | \
    sudo dd of=/dev/sdX bs=4M status=progress conv=fsync
```

## Verification

On the device:

```bash
# Check framebuffer device
ls /dev/fb0

# View kernel messages
dmesg | grep fb_st7789v

# Test display
cat /dev/urandom > /dev/fb0
```

## Configuration

The display configuration is in `recipes-kernel/linux/files/raspberrypi-yocto-terminal.dts`:

- Resolution: 320x240
- SPI speed: 40 MHz
- Rotation: 90°
- FPS: 60

## Dependencies

- meta-raspberrypi (scarthgap)
- meta-mender (optional, for OTA updates)

## License

Yocto Project compatible
