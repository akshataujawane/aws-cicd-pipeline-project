#!/bin/bash

echo "Starting deployment..."

sudo apt update -y
sudo apt install apache2 -y

sudo systemctl restart apache2

echo "Deployment successful"
