[Working app](https://i.imgur.com/kRPmWd3.png)

# Performs next steps to run TODO app on your local machine:

- ## pull images from DockerHub
  - [todoapp](https://hub.docker.com/repository/docker/olzhu95/todoapp/general)
      ```bash
        docker pull olzhu95/todoapp:2.0.0
      ```
  - [mysql-local](https://hub.docker.com/repository/docker/olzhu95/mysql-local/general)
    ```bash
        docker pull olzhu95/mysql-local:1.0.0
      ```
- ## run containers
  - ### run your mysql container
    ```bash
      docker run -d -p 3306:3306 --name mysql -v mysql-web-app:/var/lib/mysql olzhu95/mysql-local:1.0.0
    ```
  - ### get the mysql container ip and keep it to use later
    ```bash
      docker docker network inspect bridge
    ```
    you will get [such output](https://i.imgur.com/VLVGo5n.png)
    !!! keep the ip address !!!
  - ### run your todoapp container
  ```bash
      docker run -p 8080:8080 -d --name todo-app -e MYSQL_CONTAINER_IP=<mysql-container-ip> olzhu95/todoapp:2.0.0
  ```
  `<mysql-container-ip>` - is mysql ip that you saved in the previous step
    
- ## access application on your browser via `http://127.0.0.1:8080/`
