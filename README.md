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
            'ENGINE': 'mysql.connector.django',
            'NAME': 'app_db',
            'USER': 'app_user',
            'PASSWORD': '1234',
            'HOST': 'localhost',  # You can use a different host in your MySQL server is on a remote machine.
            'PORT': '',  # Leave this empty to use the default MySQL port (3306).
        }
    }

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

# Todo App Deployment Instructions

## Running MySQL Container with Volume

## MySQL Container Setup

To run the MySQL container with persistent storage, you need to create a volume and then run the container with that volume attached.

## MySQL Container Setup

To run the MySQL container with persistent storage, you need to create a volume and then run the container with that volume attached.

### Step 1: Create a Volume

This command creates a new Docker volume named `mysql-data`:


    docker volume create mysql-data

2 To run the MySQL container with a volume attached, use the following commands:

    docker run --name mysql-container -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=1234 -d mysql-local:1.0.0

### Step 2: Run MySQL Container
Use this command to start the MySQL container with the volume attached:

    docker run --name mysql-container \
        -v mysql-data:/var/lib/mysql \
        -e MYSQL_ROOT_PASSWORD=1234 \
        -e MYSQL_DATABASE=app_db \
        -e MYSQL_USER=app_user \
        -e MYSQL_PASSWORD=1234 \
        -p 3306:3306 \
        -d mysql-local:1.0.0

Make sure to replace mysql:5.7 with the tag you have used for your MySQL image if it's different.

### Step 3: Push to Docker Hub (Optional)
If you need to push the image to Docker Hub, tag it first with your username and then push:

    docker tag mysql:5.7 yourusername/mysql-local:1.0.0
    docker push yourusername/mysql-local:1.0.0

Replace yourusername with your actual Docker Hub username and mysql:5.7 with your image name and tag.


## App Container Setup

To run the application with a connection to the MySQL container, follow these steps:

### Step 1: Build the App Image

First, you need to build the image for your application using the Dockerfile in your project directory:


    docker build -t yourusername/todoapp:2.0.0 .
Replace yourusername with your Docker Hub username.

### Step 2: Run the App Container
After building the image, run the container using the following command:

    docker run --name todoapp-container --link mysql-container:mysql -p 8000:8000 -d yourusername/todoapp:2.0.0

This command does the following:

- name todoapp-container assigns the name todoapp-container to your Docker container.
- link mysql-container:mysql links your application container to the MySQL container. This allows the app to access the database using the hostname mysql.
- -p 8000:8000 maps port 8000 of the container to port 8000 on the host machine.
- -d runs the container in detached mode, which means it runs in the background.
- yourusername/todoapp:2.0.0 is the name and tag of your image.

Make sure the MySQL container is running before you start the app container.

### Step 3: Access the App
After the container starts, you can access the application by navigating to http://localhost:8000 in your web browser.



# link for docker repository
https://hub.docker.com/repository/docker/volry/todoapp
