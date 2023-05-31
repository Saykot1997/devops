#!/bin/bash

# Update system packages
sudo apt update

# Install snapd package manager
sudo apt install snapd -y

# Install certbot via snap
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot

# Set up SSL certificate with Nginx and Let's Encrypt
read -p "Enter your domain name: " domain
read -p "Enter your email address: " email

sudo certbot --nginx -d $domain -m $email
