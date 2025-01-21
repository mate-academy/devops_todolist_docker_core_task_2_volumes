To start the mysql docker container with run
docker run -d -p 3306:3306 --name my-mysql -v my-sql-data:/var/lib/mysql mysql-local:1.0.0;2C;2C;2C

To start the application you need to set a correct ip of the sql server in line 70 of the settings.py file. 
To find the ip run docker network inspect bridge and found the ip of the my-sql container

run the command  docker run -p 8080:8080 --name app todoapp:2.0.0 to start a app container.

To access the application please type http://127.0.0.1:8080