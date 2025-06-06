# Dockerizing Django-Todolist with MySQL and Volumes

# Project Overview:

In this task, I containerized a Django todo-list web application with MySQL database using Docker. The main focus was on creating a persistent MySQL container with attached volumes and connecting the Django app container to the MySQL container.

# Tech stack:

- Docker
- MySQL (official Docker image)
- Django (Python framework)
- Docker Hub (for image storage)

# What was done:

- Prepared a `Dockerfile.mysql` to build a custom MySQL image based on the official MySQL Docker image.
- Configured environment variables to initialize the database (`app_db`) and user (`app_user`) with password `1234`.
- Built a MySQL Docker image tagged as `mysql-local:1.0.0`.
- Created and attached Docker volumes to persist MySQL data outside of the container.
- Pushed the MySQL image to my personal Docker Hub repository.
- Ran MySQL container locally with volumes attached.
- Updated Django app database configuration to point to the running MySQL container IP.
- Built and ran the updated Django app container, connected to the MySQL database.
- Pushed the Django app image to Docker Hub with tag `todoapp:2.0.0`.
- Created `INSTRUCTION.md` with detailed steps on how to run both MySQL and Django app containers, including volume mounting and access      instructions.

