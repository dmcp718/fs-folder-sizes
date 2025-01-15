#!/bin/bash

# Clean previous builds
rm -rf build dist

# Build executable
pyinstaller --clean --onefile --name folder-sizes folder_sizes.py

echo "Build complete. Executable is in dist/folder-sizes"
