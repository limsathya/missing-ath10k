#!/bin/bash

# Ensure script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Update package list and install wget if not already installed
apt update
apt install -y wget

# Create necessary directories
mkdir -p /lib/firmware/ath10k/QCA9377/hw1.0/

# Change to the firmware directory
cd /lib/firmware/ath10k/QCA9377/hw1.0/

# Download the firmware files
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/cal-pci-0000:02:00.0.bin
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/ath10k/QCA9377/hw1.0/pre-cal-pci-0000:02:00.0.bin

# Reload the ath10k driver
modprobe -r ath10k_pci
modprobe ath10k_pci

# Verify firmware loading
dmesg | grep ath10k
