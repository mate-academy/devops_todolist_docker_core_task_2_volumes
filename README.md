# Django-Todolist

Django-Todolist is a todo list web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

---
CSS | [Skeleton](http://getskeleton.com/)
JS  | [jQuery](https://jquery.com/)


DockerHub link: 
```
https://hub.docker.com/repository/docker/workpolly/todoapp/tags/2.0.0/sha256-427375867e95c7b00230b1c5c6b3416613d58ea4718230dd2d155a408b09496c?tab=layers
```

## Running from GitHub

1. To clone the app navigate to your projects folder and run:

```
git clone [<repo link>](https://github.com/panik10/devops_todolist_docker_core_task_2_volumes.git)
```
2. Navigate to app folder:
```
cd todoapp
```
3. Build the mysql database with command:
```
docker build . -t mysql-local:1.0.0 -f Dockerfile.mysql
```
4. Run the sql server with:
```
docker run --name mysql_instance -p 3306:3306 -d mysql-local
```
5. With command docker network inspect find the container's IP V4 address and copy it:
```
docker network inspect bridge | grep mysql -A 4
```
6. In the settings file todolist/settings.py navigate to the line 70 and paste the IP address from previous step

7. Then navigate to the app folder and use the following command to build the image locally:
```
docker build . -t todoapp:1.0.0
```
8. To run created container use next command:
```
docker run -p 8080:8080 --name todoapp todoapp:1.0.0
```
9. Connect to the server using your browser http://127.0.0.1:8080/ 

    You can change the port by altering -p tag like "-p 80:8080" will map port 80 to your app 
