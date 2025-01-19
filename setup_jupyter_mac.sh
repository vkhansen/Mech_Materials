#!/bin/bash

# Check for Python installation
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Please install Python 3.8 or later from https://www.python.org/."
    exit 1
fi

# Check for pip installation
if ! python3 -m ensurepip --upgrade &> /dev/null; then
    echo "Pip is not installed or not functional. Attempting to install pip..."
    python3 -m ensurepip --upgrade
fi

# Upgrade pip
echo "Upgrading pip..."
python3 -m pip install --upgrade pip

# Install required Python libraries
echo "Installing required dependencies..."
python3 -m pip install -r requirements.txt

# Install Jupyter Lab
echo "Installing Jupyter Lab..."
python3 -m pip install jupyterlab

# Verify installation success
if ! command -v jupyter &> /dev/null; then
    echo "Jupyter Lab installation failed. Please check your environment."
    exit 1
fi

# Launch Jupyter Lab
echo "Starting Jupyter Lab..."
jupyter lab
