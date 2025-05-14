# Virtual Host Setup for eight25-internship-assessment.test

## Apache Virtual Host Configuration

To create a virtual host for the domain `http://eight25-internship-assessment.test` in Apache:

1. Create a new configuration file (e.g., `/etc/apache2/sites-available/eight25-internship-assessment.test.conf`):

```apache
<VirtualHost *:80>
    ServerName eight25-internship-assessment.test
    DocumentRoot /path/to/project
    
    <Directory /path/to/project>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    ErrorLog ${APACHE_LOG_DIR}/eight25-error.log
    CustomLog ${APACHE_LOG_DIR}/eight25-access.log combined
</VirtualHost>
```

2. Enable the site and restart Apache:

```bash
sudo a2ensite eight25-internship-assessment.test.conf
sudo systemctl restart apache2
```

3. Add an entry to your hosts file (`/etc/hosts`):

```
127.0.0.1 eight25-internship-assessment.test
```

## Nginx Virtual Host Configuration

To create a virtual host for the domain `http://eight25-internship-assessment.test` in Nginx:

1. Create a new configuration file (e.g., `/etc/nginx/sites-available/eight25-internship-assessment.test`):

```nginx
server {
    listen 80;
    server_name eight25-internship-assessment.test;
    root /path/to/project;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Additional configuration for caching static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
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
```

2. Enable the site and restart Nginx:

```bash
sudo ln -s /etc/nginx/sites-available/eight25-internship-assessment.test /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

3. Add an entry to your hosts file (`/etc/hosts`):

```
127.0.0.1 eight25-internship-assessment.test
```

## Docker Setup (Optional)

The provided Dockerfile will:
1. Use Nginx as the web server
2. Expose port 80 (to be mapped to port 3000 on the host)
3. Configure a volume to sync website files from the host to the container

To run the website in Docker:

1. Build the Docker image:
```bash
docker build -t eight25-assessment .
```

2. Run the container:
```bash
docker run -d -p 3000:80 -v $(pwd):/usr/share/nginx/html --name eight25-container eight25-assessment
```

3. Access the website at:
```
http://localhost:3000
```
