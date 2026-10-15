## Link to docker hub todoapp repository
https://hub.docker.com/repository/docker/vasylsmol88/todoapp/general

## How to run MySql container with a volume attached:
1. Build mysql image using command docker build -t mysql-local:1.0.0 .
2. Run docker command docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=1234 -v app-data:/var/lib/mysql mysql-local:1.0.0

## How to run todoapp via connection to mysql db
1. Update settings.py file by pasting this section into DB:
DATABASES = {
        'default': {
            'ENGINE': 'mysql.connector.django',
            'NAME': 'app_db',
            'USER': 'app_user',
            'PASSWORD': '1234',
            'HOST': '172.17.0.2',  # You can use a different host in your MySQL server is on a remote machine.
            'PORT': '',  # Leave this empty to use the default MySQL port (3306).
        }
    }
2. You need to paste database ip into 'HOST' key
3. To find database ip you need to run docker network inspect bridge
and look for mysql container and take the IPv4 value
4. Run todoapp container by using docker run -d -p 8080:8080 --name myapp todoapp:2.0.0

## How to access application via browser:
1. In any browser enter URL http://localhost:8080