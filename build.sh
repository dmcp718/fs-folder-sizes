#!/bin/bash

set -e  # Exit on error

echo "Starting build process..."

# Clean up any existing environment
echo "Cleaning up previous builds..."
rm -rf venv build dist

# Create fresh virtual environment
echo "Creating virtual environment..."
python3 -m venv venv

# Activate using full path
echo "Activating virtual environment..."
source "$(pwd)/venv/bin/activate"

# Verify activation
echo "Python path: $(which python3)"
echo "Pip path: $(which pip)"

# Install requirements
echo "Installing requirements..."
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt

# Install PyInstaller explicitly
echo "Installing PyInstaller..."
python3 -m pip install --force-reinstall pyinstaller

# Verify PyInstaller without failing
echo "Installed packages:"
python3 -m pip list

# Build the executable
echo "Building executable..."
python3 -m PyInstaller --onefile \
                      --name folder-sizes \
                      --clean \
                      folder_sizes.py

echo "Build complete! Executable is in dist/folder-sizes"
