#!/bin/bash

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

# Install Node.js LTS
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Nginx
sudo apt-get install -y nginx

# Configure Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install PM2
sudo npm install pm2@latest -g

# Print installation summary
echo "Node.js, Nginx, and PM2 have been installed successfully!"

# Add update and upgrade script
cat > /usr/local/bin/update_server << EOL
#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y
EOL

# Set execute permissions on update script
sudo chmod +x /usr/local/bin/update_server

# Print completion message
echo "The update_server script has been added to /usr/local/bin."
echo "You can now run 'update_server' to update and upgrade your system."

# Configure firewall to allow SSH, HTTP, HTTPS, and Nginx Full traffic
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

# Print firewall status
echo "Firewall has been configured to allow SSH, HTTP, HTTPS, and Nginx Full traffic."
sudo ufw status

# Print completion message
echo "Setup is complete. Your server is now ready for use!"
