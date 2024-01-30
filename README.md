# Django-Todolist

Django-Todolist is a todolist web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

---
CSS | [Skeleton](http://getskeleton.com/)
JS  | [jQuery](https://jquery.com/)


### Screenshot of a terminal with successfully started application

![img9](https://s3.amazonaws.com/i.snag.gy/QviDyT.jpg)

## Explore
Try it out by installing the requirements. (Works only with python >= 3.8, due to Django 4)

    pip install -r requirements.txt

Create a database schema:

    python manage.py migrate

And then start the server (default: http://localhost:8000)

    python manage.py runserver


Now you can browse the [API](http://localhost:8000/api/)
or start on the [landing page](http://localhost:8000/)

## Task
#### Prerequisites
- Fork this repository
- Open requirements.txt
- Add mysql-connector-python==8.2.0
- Open file todolist/settings.py
- Go to line DATABASES on line 64
- Update it with this code:

    ```
    DATABASES = {
        'default': {
            'ENGINE': 'mysql.connector.django',
            'NAME': 'app_db',
            'USER': 'app_user',
            'PASSWORD': '1234',
            'HOST': 'localhost',  # You can use a different host in your MySQL server is on a remote machine.
            'PORT': '',  # Leave this empty to use the default MySQL port (3306).
        }
    }

    ```


## Using Docker

### 1) Getting a container for database
A Docker file is already included in the repository, but you can also download a ready image from [Docker Hub](https://hub.docker.com/r/oksanamiazina/mysql-local):

```
docker pull oksanamiazina/mysql-local:1.0.0
```

Or you can just build a container from the provided one:
```
docker build . -f Dockerfile.mysql -t <name_of_your_db_image>
```

### 2) Running a container for database (first time)
Firstly, you need to create the `.env` file (you can take the provided .env.example as a base).

*Optional:* Then, you can define your own credentials there. But, in this case, in the following steps you should build your own Image for the front-end.

After that, run new container:
```
docker run -d --env-file=.env --name <name_of_your_container> -v <name_of_your_volume>:/var/lib/mysql oksanamiazina/mysql-local:1.0.0

#OR
docker run -d --env-file=.env --name <name_of_your_container> -v <name_of_your_volume>:/var/lib/mysql <name_of_your_db_image>
```

> How to run the container the next time, see point [#6 (Stopping and restarting containers)](#restartContainers)

### 3) Getting an IP address for database
```
docker network inspect bridge
```
Find the **ip address** of your database container here, and if it is different from the one provided in `.env.example`, update your `.env` file. And also, in this case, in the following steps you should compile your own Image for the front-end.

```
#.env
DB_HOST=<ip_address_of_db_container>
```


### 4) Getting a container for front-end
A Docker file is already included in the repository, but you can also download a ready image from [Docker Hub](https://hub.docker.com/r/oksanamiazina/todoapp):

```
docker pull oksanamiazina/todoapp:2.0.0
```

Or you can just build a container from the provided one:
```
docker build -t <name_of_your_image> .
```

### 5) Running a container for front-end (first time)

```
docker run -d -p 8080:8080 --name <name_of_your_container> oksanamiazina/todoapp:2.0.0

# OR
docker run -d -p 8080:8080 --name <name_of_your_container> <name_of_your_image>
```
After a moment, the web front-end will appear at http://localhost:8080.

> How to run the container the next time, see point [#6 (Stopping and restarting containers)](#restartContainers)

#### How to change the port
To change the port for local development, you can specify the required port as the first argument for the parameter `-p`. For example, let's change it to `3000`:
```
docker run -d -p 3000:8080 --name <name_of_your_container> <name_of_your_image>
```
So that, the new link will be http://localhost:3000.

#### Docker Environment Variables

- **PYTHON_VERSION** - Python base image version (default is set to **3.8**)

```
docker run -e PYTHON_VERSION=<version_of_python> -p 8080:8080 --name <name_of_your_container> <name_of_your_image>
```

### <a name="restartContainers"></a> 6) Stopping and restarting containers
Once the containers have been created, they can be stopped and restarted very easily with the same settings:
```
docker stop <name_of_your_container>
docker start <name_of_your_container>
```

If you forget the name of the containers, you can always view the list of all created containers:
```
docker ps -a
```


#### Requirements
1. Prepare a Dockerfile to run a MySQL database, based on official MySQL Image
2. Dockerfile should contain ENV variables to initialize app_db database
3. Dockerfile should contain ENV variables to initialize app_user with password 1234
4. Build mysql image with a name and tag mysql-local:1.0.0
5. You should be able successfully run a container with MySQL with a Volumes Attached
6. Push mysql-local:1.0.0 to your personal docker hub into mysql-local repository
7. Run mysql-local:1.0.0 onn your machine
8. Update the python app db config with an IP of a running MySQL server container (without it, the app container won’t build)
9. Build and run your updated app
10. Take a screenshot of a terminal with successfully started application
11. Push Image with a name and tag: todoapp:2.0.0 to yout Docker Hub repository
12. Update README.md with instructions on how to run MySQL container with a volume attached
13. Update README.md with instructions on how to run an App container which will connect to a MySQL db container.
14. README.md should contain a link to your personal docker hub repository win an app image
15. README.md should contain instructions on how to access the application via a browser.
16. Create PR with your changes and attach it for validation on a platform
