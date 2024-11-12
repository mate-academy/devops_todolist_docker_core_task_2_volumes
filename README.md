# Django-Todolist

## Overview
A simple to-do list web application built with Django, MySQL, and Docker.

### Docker Setup Instructions

#### Running the MySQL Container
To run the MySQL container with a volume attached, use:
```bash
docker run -d --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  vpcomtek/mysql-local:1.0.0
```
#### Running the Django Application Container
Run the Django app container:
```bash
docker run -d --name django-app -p 8080:8080 --link mysql-container:mysql-container \
  vpcomtek/todoapp:2.0.0

```
### Accessing the Application
After starting both containers, open your browser and navigate to:

> [http://0.0.0.0:8080](http://localhost:8080)


### Docker Hub Links
* [MySQL Image](https://hub.docker.com/r/vpcomtek/mysql-local)
* [Django Application Image](https://hub.docker.com/r/vpcomtek/todoapp)


### Sreenshot
> ![devops_todolist_docker_core_task_2_volumes.png](devops_todolist_docker_core_task_2_volumes.png)
