## how to run MySQL container with a volume attached


# if builded and run locally
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
docker run -d -p 3306:3306 -v mysql-dev:/var/lib/mysql --name my-sql-server mysql-local:1.0.0

# remote run
docker run -d -p 3306:3306 -v mysql-dev:/var/lib/mysql --name my-sql-server sydor101/mysql-local:1.0.0

## how to run an App container which will connect to a MySQL db container
1. Run the MySQL db container
2. docker network inspect bridge
3. Look for the IPv4Address in my-sql-server container section
4. Copy paste it into todolist/settings.py, example

DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': 'PASTE IP HERE',
        'PORT': '',  # Leave this empty to use the default MySQL port (3306).
    }
}
# local run
docker build -t todoapp:2.0.0 .
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
# remote run
docker run -d -p 8080:8080 --name todoapp sydor101/todoapp:2.0.0

# Warning, each time you restart the container you need to do those steps again

## link to the personal docker hub repository with an app image
https://hub.docker.com/r/sydor101/todoapp
## how to access the application via a browser
localhost:8080
