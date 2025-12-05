# Use official nginx alpine image for small size
FROM nginx:alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy all static files (HTML, CSS, images, etc.)
COPY . .

# Create a custom nginx configuration to handle SPA routing if needed
# For a static site, the default nginx config is sufficient
# But we'll create a custom one to ensure proper MIME types and caching
RUN echo 'server {\
    listen 80;\
    server_name localhost;\
    root /usr/share/nginx/html;\
    index index.html;\
    \
    # Enable gzip compression\
    gzip on;\
    gzip_vary on;\
    gzip_min_length 1024;\
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;\
    \
    # Security headers\
    add_header X-Frame-Options "SAMEORIGIN" always;\
    add_header X-Content-Type-Options "nosniff" always;\
    add_header X-XSS-Protection "1; mode=block" always;\
    \
    # Cache static assets\
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {\
        expires 1y;\
        add_header Cache-Control "public, immutable";\
    }\
    \
    # Handle HTML5 history routing for SPA (if needed)\
    location / {\
        try_files $uri $uri/ /index.html;\
    }\
    \
    # Custom error pages\
    error_page 404 /404.html;\
    error_page 500 502 503 504 /50x.html;\
}' > /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
