# Docker Instructions

Docker Hub repository: https://hub.docker.com/r/bodya4243/todoapp

## Build the Image

From the project root, build the image:

```bash
docker build -t todoapp:1.0.0 .
```

If you want to override the Python base image version:

```bash
docker build --build-arg PYTHON_VERSION=3.11-slim -t todoapp:1.0.0 .
```

## Run the Container

Run the app container and publish port 8080:

```bash
docker run --name todoapp -p 8080:8080 todoapp:1.0.0
```

If a container named `todoapp` already exists:

```bash
docker rm -f todoapp
docker run --name todoapp -p 8080:8080 todoapp:1.0.0
```

## Pull From Docker Hub

Pull the published image:

```bash
docker pull bodya4243/todoapp:1.0.0
```

Run the published image:

```bash
docker run --name todoapp -p 8080:8080 bodya4243/todoapp:1.0.0
```

## Access in a Browser

Open the app:

```text
http://localhost:8080/
```

Open the API:

```text
http://localhost:8080/api/
```
