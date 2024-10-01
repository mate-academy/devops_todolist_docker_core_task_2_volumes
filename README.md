# Django ToDo list

This Django-based ToDo List web application offers essential features commonly found in modern web apps, including user authentication (accounts/login), a RESTful API, and an interactive user interface.

![ToDo logo](https://i.ibb.co/YDdCcZR/2.png)

## Setup

1. Link to Docker image with app (2.0.0 tag)

    **[Docker Hub: dastex/todo-app](https://hub.docker.com/r/dastex/todo-app)**

2. Link to MySQL image with a volume attached locally

    **[Docker Hub: dastex/mysql-local](https://hub.docker.com/r/dastex/mysql-local)**

3. Pull the MySQL image with a volume attached locally:
```bash
docker pull dastex/mysql-local
```
4. You need pull App image locally
```bash
docker pull dastex/todo-app:2.0.0
```
5. You need run a MySQL container
```bash
docker run -d -p 3306:3306 -v my-mysql-data:/var/lib/mysql dastex/mysql-local
```
6. You need run App container
```bash
docker run -d -p 8080:8080 dastex/todo-app:2.0.0
```
7. Open application in browser

    [http://localhost:8080/](http://localhost:8080/)
