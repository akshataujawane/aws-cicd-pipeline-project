#!/bin/bash
set -e

echo "Starting deployment..."

# Install Apache only if not installed
if ! command -v apache2 >/dev/null 2>&1; then
  apt-get update -y
  apt-get install apache2 -y
fi

systemctl enable apache2
systemctl restart apache2

echo "Deployment successful"
