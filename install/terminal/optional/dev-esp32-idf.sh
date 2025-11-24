#!/bin/bash

# Install ESP32 development environment (ESP-IDF)
# ESP-IDF is the official development framework for Espressif SoCs

echo "Installing ESP32 development environment..."

# Install required dependencies
sudo apt-get install -y git wget flex bison gperf \
    cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

# Create directory for ESP-IDF
ESP_IDF_DIR="$HOME/esp"
mkdir -p "$ESP_IDF_DIR"

# Clone ESP-IDF repository (v5.3 - latest stable)
if [ ! -d "$ESP_IDF_DIR/esp-idf" ]; then
    echo "Cloning ESP-IDF repository..."
    git clone -b v5.3 --recursive https://github.com/espressif/esp-idf.git "$ESP_IDF_DIR/esp-idf"
else
    echo "ESP-IDF already exists, updating..."
    cd "$ESP_IDF_DIR/esp-idf"
    git pull
    git submodule update --init --recursive
fi

# Run ESP-IDF installation script
cd "$ESP_IDF_DIR/esp-idf"
./install.sh esp32,esp32s2,esp32s3,esp32c3,esp32c6,esp32h2

# Add ESP-IDF export alias to .bashrc
BASH_RC="$HOME/.bashrc"
if ! grep -q "alias get_idf=" "$BASH_RC" 2>/dev/null; then
    echo "" >> "$BASH_RC"
    echo "# ESP-IDF environment setup" >> "$BASH_RC"
    echo "alias get_idf='. $ESP_IDF_DIR/esp-idf/export.sh'" >> "$BASH_RC"
fi

# Add udev rules for ESP32 USB access
sudo usermod -a -G dialout $USER

echo ""
echo "ESP32 development environment installed successfully!"
echo ""
echo "To use ESP-IDF in a terminal session, run:"
echo "  get_idf"
echo ""
echo "Then you can use commands like:"
echo "  idf.py create-project myproject"
echo "  idf.py build"
echo "  idf.py flash"
echo "  idf.py monitor"
echo ""
echo "Note: You may need to log out and log back in for USB permissions to take effect."
