@echo off
echo Setting up virtual host for http://eight25-internship-assessment.test

echo Adding entry to hosts file...
echo 127.0.0.1 eight25-internship-assessment.test >> %WINDIR%\System32\drivers\etc\hosts

echo.
echo ==============================================
echo Apache Configuration Instructions:
echo ==============================================
echo 1. Create a file named "eight25-internship-assessment.conf" in your Apache's conf/extra directory
echo    with the following content:
echo.
echo ^<VirtualHost *:80^>
echo     ServerName eight25-internship-assessment.test
echo     DocumentRoot "%CD%"
echo     ^<Directory "%CD%"^>
echo         Options Indexes FollowSymLinks
echo         AllowOverride All
echo         Require all granted
echo     ^</Directory^>
echo     ErrorLog ${APACHE_LOG_DIR}/eight25-error.log
echo     CustomLog ${APACHE_LOG_DIR}/eight25-access.log combined
echo ^</VirtualHost^>
echo.
echo 2. Add the following line to your Apache's httpd.conf file:
echo    Include conf/extra/eight25-internship-assessment.conf
echo.
echo 3. Restart Apache
echo.
echo.
echo ==============================================
echo Nginx Configuration Instructions:
echo ==============================================
echo 1. Create a file named "eight25-internship-assessment" in your Nginx's sites-available directory
echo    with the following content:
echo.
echo server {
echo     listen 80;
echo     server_name eight25-internship-assessment.test;
echo     root "%CD:\=/%";
echo     index index.html;
echo.    
echo     location / {
echo         try_files $uri $uri/ /index.html;
echo     }
echo.    
echo     location ~* \.(jpg^|jpeg^|png^|gif^|ico^|css^|js)$ {
echo         expires 30d;
echo         add_header Cache-Control "public, no-transform";
echo     }
echo.    
echo     gzip on;
echo     gzip_comp_level 6;
echo     gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
echo.    
echo     add_header X-Frame-Options "SAMEORIGIN";
echo     add_header X-XSS-Protection "1; mode=block";
echo     add_header X-Content-Type-Options "nosniff";
echo }
echo.
echo 2. Create a symbolic link to enable the site:
echo    ln -s /path/to/nginx/sites-available/eight25-internship-assessment /path/to/nginx/sites-enabled/
echo.
echo 3. Restart Nginx
echo.
echo.
echo ==============================================
echo Docker Setup Instructions:
echo ==============================================
echo 1. Build the Docker image:
echo    docker build -t eight25-assessment .
echo.
echo 2. Run the container:
echo    docker run -d -p 3000:80 -v "%CD%":/usr/share/nginx/html --name eight25-container eight25-assessment
echo.
echo 3. Access the website at:
echo    http://localhost:3000

pause
