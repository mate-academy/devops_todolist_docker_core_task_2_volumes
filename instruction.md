For run MySQL container:
docker run  -d -p 3306:3306 --name my-mysql -v mysql-data:/var/lib/mysql mysql-local:1.0.0

For run App container:
docker run -p 8080:8080 --name app app:1.0

Download image:
https://hub.docker.com/r/dmytro1970/todoapp:2.0.0


For brauser:
http://127.0.0.1:8080