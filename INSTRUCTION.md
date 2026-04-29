# Run MySQL container

In Dockerfile.mysql you can describe your values of ENV variables 

1. docker build . -f Dockerfile.mysql -t my-mysql:latest
2. docker run -d -p 3306:3306 -v mysql-data: /var/lib/mysql --name my-mysql my-mysql:latest

# How to run TodoApp container which will connect to a MySQL db container.

1. Check IP our MySQL db container with command: docker inspect name-of-container. In block network -> bridge we find our IP. 
2. In settings.py in block DATABASES, key HOST we pass our IP db container.
3. In terminal: docker build . -t todoapp:latest
4. docker run -d -p 8080:8080 --name todoapp todoapp:latest

# DockerHub - https://hub.docker.com/u/vanyas627

# How to run the application 

1. pip install -r requirements.txt
2. python manage.py migrate
3. python manage.py runserver 