# Simple static site image using NGINX
FROM nginx:stable-alpine

# Copy your website files into NGINX's default web root
COPY web/ /usr/share/nginx/html

# NGINX listens on 80 inside the container
EXPOSE 80
