#!/bin/bash

# Update and install required packages
apt-get update -y
apt-get install -y python3 python3-pip python3-venv git

# Set application directory
APP_DIR="/home/ubuntu/fintrack"

# Create application directory and fix permissions
mkdir -p "$APP_DIR"
chown ubuntu:ubuntu "$APP_DIR"

# Clone the repository
git clone https://github.com/sramesh137/fintrack.git "$APP_DIR"

# Change to app directory
cd "$APP_DIR"

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Start the Flask app
gunicorn app:app --bind 0.0.0.0:5001 --workers 4 --daemon

# Log deployment status
echo "Flask app is running on port 5001" > /home/ubuntu/deployment.log
