# Docker Setup for BSOV Media Website

This project includes Docker configuration for containerizing the static HTML website.

## Files Created

1. **Dockerfile** - Configuration to build a Docker image using nginx:alpine
2. **.dockerignore** - Excludes unnecessary files from the Docker build context
3. **DOCKER_INSTRUCTIONS.md** - This file

## Building the Docker Image

```bash
docker build -t bsov-website .
```

## Running the Container

### For development/testing:
```bash
docker run -d -p 8080:80 --name bsov-website-container bsov-website
```

The website will be available at: http://localhost:8080

### For production (with restart policy):
```bash
docker run -d -p 80:80 --name bsov-website --restart unless-stopped bsov-website
```

## Docker Commands

- **Stop container**: `docker stop bsov-website-container`
- **Start container**: `docker start bsov-website-container`
- **Remove container**: `docker rm bsov-website-container`
- **Remove image**: `docker rmi bsov-website`
- **View logs**: `docker logs bsov-website-container`
- **View running containers**: `docker ps`

## Image Features

- Uses lightweight nginx:alpine base image
- Includes custom nginx configuration with:
  - Gzip compression for better performance
  - Security headers (X-Frame-Options, X-Content-Type-Options, X-XSS-Protection)
  - Cache headers for static assets (1 year)
  - HTML5 history routing support for SPA-like navigation
- Excludes unnecessary files via .dockerignore
- Serves all static files from /usr/share/nginx/html

## Deployment

The Docker image can be pushed to any container registry (Docker Hub, AWS ECR, Google Container Registry, etc.) and deployed to container orchestration platforms like Kubernetes, Docker Swarm, or AWS ECS.
