#!/bin/bash

# This script helps set up a virtual host for both Apache and Nginx

echo "Setting up virtual host for http://eight25-internship-assessment.test"

# Choose web server
echo "Select your web server:"
echo "1) Apache"
echo "2) Nginx"
read -p "Enter your choice (1 or 2): " choice

# Add entry to hosts file
echo "Adding entry to hosts file..."
echo "127.0.0.1 eight25-internship-assessment.test" | sudo tee -a /etc/hosts

# Set project path
PROJECT_PATH=$(pwd)

if [ "$choice" -eq 1 ]; then
    # Apache Configuration
    echo "Creating Apache virtual host..."
    
    VHOST_FILE="/etc/apache2/sites-available/eight25-internship-assessment.test.conf"
    
    # Create Apache virtual host file
    sudo tee "$VHOST_FILE" > /dev/null << EOF
<VirtualHost *:80>
    ServerName eight25-internship-assessment.test
    DocumentRoot $PROJECT_PATH
    
    <Directory $PROJECT_PATH>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog \${APACHE_LOG_DIR}/eight25-error.log
    CustomLog \${APACHE_LOG_DIR}/eight25-access.log combined
</VirtualHost>
EOF
    
    # Enable site and restart Apache
    sudo a2ensite eight25-internship-assessment.test.conf
    sudo systemctl restart apache2
    
    echo "Apache virtual host has been created successfully!"
    echo "You can access your site at http://eight25-internship-assessment.test"
    
elif [ "$choice" -eq 2 ]; then
    # Nginx Configuration
    echo "Creating Nginx virtual host..."
    
    VHOST_FILE="/etc/nginx/sites-available/eight25-internship-assessment.test"
    
    # Create Nginx virtual host file
    sudo tee "$VHOST_FILE" > /dev/null << EOF
server {
    listen 80;
    server_name eight25-internship-assessment.test;
    root $PROJECT_PATH;
    index index.html;
    
    location / {
        try_files \$uri \$uri/ /index.html;
    }
    
    # Additional configuration for caching static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)\$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }
    
    # Enable gzip compression
    gzip on;
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";
}
EOF
    
    # Enable site and restart Nginx
    sudo ln -s "$VHOST_FILE" /etc/nginx/sites-enabled/
    sudo systemctl restart nginx
    
    echo "Nginx virtual host has been created successfully!"
    echo "You can access your site at http://eight25-internship-assessment.test"
    
else
    echo "Invalid choice. Please run the script again and select either 1 or 2."
    exit 1
fi

# Docker setup instructions
echo ""
echo "To run with Docker (requires Docker to be installed):"
echo "1. Build the Docker image:"
echo "   docker build -t eight25-assessment ."
echo ""
echo "2. Run the container:"
echo "   docker run -d -p 3000:80 -v $(pwd):/usr/share/nginx/html --name eight25-container eight25-assessment"
echo ""
echo "3. Access the website at:"
echo "   http://localhost:3000"
