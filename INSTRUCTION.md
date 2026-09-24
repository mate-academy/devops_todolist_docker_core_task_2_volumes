## Docker repository:

https://hub.docker.com/repository/docker/sancho1605/todoapp/general - todoapp repo
https://hub.docker.com/repository/docker/sancho1605/mysql-local/general - mysql repo
https://drive.google.com/file/d/10AQg2wJSntPTOJUkyCR51evroG-oMrAc/view?usp=sharing - screepshot


## 1. Open terminal in the working directory


## 2. Run the command to create local network

`
docker network create mynetwork
`

## 3. Run the command to build mysql image

`
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
`

## 4. Run command to run mysql container

`
docker run -d --name mysql-container --network mynetwork -v mysql-data:/var/lib/mysql mysql-local:1.0.0

`

## 5. Run the command to build todoapp image

`
docker build -t todoapp:2.0.0 .
`

## 6. Run command to run todoapp container

`
docker run -d --name django-app --network mynetwork -p 8000:8000 todoapp:2.0.0

`

## 7. Open in browser: http://localhost:8000

