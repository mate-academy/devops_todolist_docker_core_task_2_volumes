# Django-Todolist

Django-Todolist is a todolist web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

---
CSS | [Skeleton](http://getskeleton.com/)
JS  | [jQuery](https://jquery.com/)

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
            'ENGINE': mysql.connector.django',
            'NAME': 'app_db',
            'USER': 'app_user',
            'PASSWORD': '1234',
            'HOST': 'localhost',  # You can use a different host in your MySQL server is on a remote machine.
            'PORT': '',  # Leave this empty to use the default MySQL port (3306).
        }
    }

    ```
#### Requirements
1. Prepare a Dockerfile to run a MySQL database, based on the official MySQL Image, name it Dockerfile.mysql
2. Dockerfile should contain ENV variіables to initialize app_db databaseDockerfile should contain ENV variables to initialize app_user with password 1234
3. Build MySQL image and tag mysql-local:1.0.0
4. You should be able to run a container with MySQL with a Volume Attached successfully
5. You should be able to successfully run a Django App in a container that will connect to a MySQL db container that is already started
6. Push mysql-local:1.0.0 to your personal docker hub into mysql-local repository
7. Build and push your updated app Image with a name and tag: todoapp:2.0.0
8. Update README.md with instructions on how to build and run MySQL container with a volume attached
9. Update README.md with instructions on how to build and run an App container which will connect to a MySQL db container.
10. README.md should contain a link to your docker hub repository with mysql image
11. README.md should contain a link to your docker hub repository with todoapp image
12. Create Pull Request with your changes and attach it for validation on a platform

## Task 2 result
- ### Docker commands:
    - Create network:\
    `docker network create -d bridge mynetdocker`
    - Build app image:\
    `build --tag yurakolam/todoapp:2.0.0 --build-arg VERSION=3.9 --file ./Dockerfile .`
    - Build database image:\
    `docker build --tag yurakolam/mysql-local:1.0.0 --file ./Dockerfile.mysql .`\
    - Run database container:\
    `docker run -d -p 3306:3306 -v mysql:/var/lib/mysql --network=mynet --hostname=database --name mysql yurakolam/mysql-local:1.0.0`
    - Run app container:\
    `docker run -d  -p 8080:8080 --network=mynet --name todoapp yurakolam/todoapp:2.0.0`
- ### DockerHub links:
    - [Database image](https://hub.docker.com/layers/yurakolam/mysql-local/1.0.0/images/sha256-beffdcf66b55f6e8bcdb4bb45f737973af82c750aa15742b996dbc185dfe73c7?context=repo)
    - [App image](https://hub.docker.com/layers/yurakolam/todoapp/2.0.0/images/sha256-1c1bc8f368098eccea631e187c4ccde02ccd8a5e860255919db071b96fc778e7?context=repo)
    