#!/bin/bash

# Install ESP32 development environment for Rust
# Uses esp-rs (Rust on ESP) toolchain

echo "Installing ESP32 Rust development environment..."


# Needs Rust installed as a prerequisite
# You can install Rust following the next commented instructions:
# Install Rust
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Add Rust to PATH (only needed if not already in shell)
#source $HOME/.cargo/env


# Install required dependencies
sudo apt-get install -y gcc build-essential pkg-config libudev-dev \
    libusb-1.0-0 libssl-dev

# Ensure Rust is installed (should be via mise)
if ! command -v rustc &> /dev/null; then
    echo "Error: Rust not found. Please install Rust first using mise."
    exit 1
fi

# Install espup (ESP Rust toolchain installer)
echo "Installing espup..."
cargo install espup

# Install ESP Rust toolchain for all ESP32 chips
echo "Installing ESP Rust toolchain (this may take a while)..."
espup install

# Install cargo-espflash for flashing ESP32 devices
echo "Installing cargo-espflash..."
cargo install cargo-espflash
cargo install espflash --locked

# Install espmonitor for serial monitoring
echo "Installing espmonitor..."
cargo install espmonitor

# Install ldproxy (needed for linking)
echo "Installing ldproxy..."
cargo install ldproxy

# Install esp-generate for project templates
echo "Installing esp-generate..."
cargo install esp-generate --locked
cargo install cargo-generate

# Install esp-config for ESP configuration management
echo "Installing esp-config..."
cargo install esp-config --features=tui --locked

# Add udev rules for ESP32 USB access
sudo usermod -a -G dialout $USER

# Add Xtensa target for ESP32S2
# rustup target add xtensa-esp32s2-none-elf

# Add alias to .bashrc to setup ESP Rust environment
# if ! grep -q "alias esp_rust_env=" "$HOME/.bashrc" 2>/dev/null; then
#     echo "" >> "$HOME/.bashrc"
#     echo "# ESP32 Rust environment setup" >> "$HOME/.bashrc"
#     echo "alias esp_rust_env='. \$HOME/export-esp-rs.sh'" >> "$HOME/.bashrc"
# fi

echo ""
echo "ESP32 Rust development environment installed successfully!"
echo ""
echo "To use ESP Rust in a terminal session, run:"
echo "  esp_rust_env"
echo ""
echo "Create a new ESP32 Rust project with:"
echo "  cargo generate esp-rs/esp-idf-template cargo"
echo "  # or for no_std projects:"
echo "  cargo generate esp-rs/esp-template"
echo ""
echo "Build and flash with:"
echo "  cargo build"
echo "  cargo espflash flash --monitor"
echo ""
echo "Useful cargo-espflash commands:"
echo "  cargo espflash board-info    # Show connected board info"
echo "  cargo espflash save-image    # Save binary image"
echo "  espmonitor /dev/ttyUSB0      # Monitor serial output"
echo ""
echo "Note: You may need to log out and log back in for USB permissions to take effect."
echo ""
echo "Resources:"
echo "  - ESP-RS Book: https://esp-rs.github.io/book/"
echo "  - Templates: https://github.com/esp-rs"
