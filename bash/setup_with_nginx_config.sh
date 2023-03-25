#!/bin/bash

# Update and upgrade system
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y

# Add Node.js repository
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Install Node.js, Nginx, and PM2
sudo apt-get install -y nodejs nginx
sudo npm install -g pm2

# Add update and upgrade script
cat > /usr/local/bin/update_server << EOL
#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y
EOL

# Set execute permissions on update script
sudo chmod +x /usr/local/bin/update_server

# Configure firewall
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

# Configure Nginx
sudo cat > /etc/nginx/sites-available/default << EOL
server {
    listen 80;
    server_name your_domain.com;

    location /api {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOL

# Reload Nginx to apply changes
sudo systemctl reload nginx

# Print completion message
echo "Node.js, Nginx, and PM2 have been installed."
echo "The update_server script has been added to /usr/local/bin."
echo "You can now run 'update_server' to update and upgrade your system."
