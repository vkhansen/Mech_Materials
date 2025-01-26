#!/bin/bash
# Check for Python installation
if ! command -v python3 &> /dev/null
then
    echo "Python is not installed. Please install Python 3.8 or later from https://www.python.org/."
    exit
fi

# Upgrade pip
echo "Upgrading pip..."
python3 -m pip install --upgrade pip

# Install Jupyter Lab
echo "Installing Jupyter Lab..."
pip3 install jupyterlab

# Install dependencies
echo "Installing required dependencies..."
pip3 install numpy pandas matplotlib scipy

# Start Jupyter Lab
echo "Starting Jupyter Lab..."
jupyter lab
