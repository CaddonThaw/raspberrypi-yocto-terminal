# Set root password for core-image-minimal
# This bbappend adds SSH access with default password "417"

# Function to set root password
set_root_passwd() {
    echo 'root:417' | chpasswd -R ${IMAGE_ROOTFS}
}

# Add the function to the post-process commands
ROOTFS_POSTPROCESS_COMMAND:append = " set_root_passwd; "

IMAGE_INSTALL:append = " \
	kernel-modules \
	sudo wget curl nano tmux vim git \
	minicom iproute2 net-tools i2c-tools spidev-test evtest\
  "