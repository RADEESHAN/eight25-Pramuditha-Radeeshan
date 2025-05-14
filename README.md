# Eight25 Internship Assessment

This project is an implementation of a web interface based on a Figma design provided for the Eight25 internship assessment.

## Overview

The website is a responsive landing page with several sections:
- Navigation header with menu
- Logos section with company logos and centered content
- Hero section with text and image
- Testimonial section
- Call-to-action (CTA) section
- Footer

## Features

- **Responsive Design**: Works on devices of all sizes from mobile to large desktop screens
- **Modern UI**: Follows current web design trends with gradients, shadows, and animations
- **Animation Effects**: 
  - Fade-in animations on scroll
  - Float animations for logos with random delay
  - Pulse animations for buttons
  - Hover effects for interactive elements
  - Shimmer effects for text
- **Clean Code**: Well-structured HTML, CSS, and JavaScript with separation of concerns
- **Docker Support**: Includes Docker configuration and docker-compose for easy container deployment
- **Accessibility**: Semantic HTML and proper ARIA attributes for better accessibility

## Technologies Used

- HTML5
- CSS3 (with modern features like flexbox, CSS animations, and gradients)
- JavaScript (ES6+) for interactive elements and animations
- Docker and docker-compose for containerized deployment

## Setup and Running

### Local Development

To run this project locally:

1. Clone the repository.
2. Open `index.html` in your browser.

### Virtual Host Setup

You can set up a virtual host for local development using the provided script:

```bash
chmod +x setup-vhost.sh
./setup-vhost.sh
```

Follow the prompts to set up either an Apache or Nginx virtual host.

### Docker Setup

To run the project using Docker:

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

## Virtual Host Configuration

### Apache

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

### Nginx

```nginx
server {
    listen 80;
    server_name eight25-internship-assessment.test;
    root /path/to/project;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }
    
    gzip on;
    gzip_comp_level 6;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
    
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";
}
```

## Design Choices

- **Typography**: Used Inter font family for clean, modern appearance
- **Colors**: Followed Figma design with vibrant gradients and contrasting elements
- **Animation**: Added subtle animations for better UX without overwhelming users
- **Accessibility**: Ensured readable contrast and proper element hierarchy

## Author

Pramuditha Radeeshan
