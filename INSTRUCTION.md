To run todoapp you should make 2 steps:

## 1. Run mysql in Docker
You can download mysql image from repository https://hub.docker.com/repository/docker/yurakhilko/mysql-local/general. Download image with 1.0.0 tag.

To run a container execute `docker run  -d -p 3306:3306 --name mysql-local -v mysql-local:/var/lib/mysql mysql-local:1.0.0`

## 2.Run todoapp in Docker
You can download todoapp image from repository https://hub.docker.com/repository/docker/yurakhilko/todoapp/general. Download image with 2.0.0 tag.

To run a container execute `docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0`

Now you can browse the todoapp on the [landing page](http://127.0.0.1:8080/).