How to run TODO app

1) Create mysql container using command
`docker run -d -p 3306:3306 whatmodeprog/mysql-local:1.0.0 `
2) Create todoapp container using command
`docker run -d -p 8080:8080 whatmodeprog/todoapp:2.0.0`
3) Open web browser and go to http://0.0.0.0:8080/

Docker Hub repository: https://hub.docker.com/repositories/whatmodeprog