# ToDo App Docker Instructions

## Docker Hub Repository

Docker Hub profile:

https://hub.docker.com/u/aezakmi565

Application image:

https://hub.docker.com/r/aezakmi565/todoapp

MySQL image:

https://hub.docker.com/r/aezakmi565/mysql-local


## Requirements

The project uses:

mysql-connector-python==8.2.0

It is added to requirements.txt.


# MySQL Container Setup

Create Docker volume:

```bash
docker volume create mysql-data