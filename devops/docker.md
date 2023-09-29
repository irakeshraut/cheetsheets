# Docker Cheatsheet

## Basic Commands

### Build an image**:

```
docker build -t image-name:tag .
```

Build a Docker image using the Dockerfile in the current directory.

### Run a container:

```
docker run image-name:tag
```

Start a new container from the specified image.

### List running containers:

```
docker ps
```

Shows all running containers.

### List all containers:

```
docker ps -a
```

Shows all containers, both running and stopped.

### Stop a container:

```
docker stop container-id/container-name
```

Stops a running container.

### Remove a container:

```
docker rm container-id/container-name
```

Removes a container.

### List images:

```
docker images
```

Shows all images available locally.

### Remove an image:

```
docker rmi image-name:tag
```

Removes a Docker image.

### Pull an image:

```
docker pull image-name:tag
```

Pulls an image from a registry (like Docker Hub).

## Advanced Commands

### Run in detached mode:

```
docker run -d image-name:tag
```

Runs a container in the background.

### Assign a name to a container:

```
docker run --name container-name image-name:tag
```


### Map ports:

```
docker run -p host-port:container-port image-name:tag
```

Maps a port from the host to the container.

### Set environment variables:

```
docker run -e VAR_NAME=value image-name:tag
```


### Volume mapping:

```
docker run -v host-path:container-path image-name:tag
```

Maps a volume (or directory) from the host to the container.

### Execute command in a running container(Interactive Mode):

```
docker exec -it container-id/container-name command
```

Executes a command inside a running container.

### See logs of a container:

```
docker logs container-id/container-name
```

Displays the logs of a specified container.

### Copy files from/to a container:

```
docker cp container-id/container-name:container-path host-path
```

Copies files between the host and a container.

## Docker Compose Commands

### Start services:

```
docker-compose up
```

Starts the services defined in docker-compose.yml.

### Start services in detached mode:

```
docker-compose up -d
```

Starts services in the background.

### Stop services:

```
docker-compose down
```

Stops the services defined in docker-compose.yml.

### Build services:

```
docker-compose build
```

Builds the images for the services defined in docker-compose.yml.

### View logs:

```
docker-compose logs service-name
```

View logs of a specific service.

## Housekeeping

### Remove all stopped containers:

```
docker container prune
```

Cleans up stopped containers.

### Remove unused images:

```
docker image prune
```

Cleans up unused images.

### Remove unused networks:

```
docker network prune
```

Cleans up unused networks.

### Remove all unused objects:

```
docker system prune
```

Cleans up stopped containers, unused networks, and dangling images.