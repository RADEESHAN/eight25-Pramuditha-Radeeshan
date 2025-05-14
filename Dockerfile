FROM nginx:alpine

# Copy website files to Nginx server
COPY . /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
