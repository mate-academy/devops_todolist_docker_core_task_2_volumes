# Django-Todolist

Django-Todolist is a todo list web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.

---
CSS | [Skeleton](http://getskeleton.com/)
JS  | [jQuery](https://jquery.com/)

## Explore
Try it out by installing the  requirements. (Works only with Python >= 3.8, due to Django 4)

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
1. Prepare a Dockerfile to run a MySQL database, based on the official MySQL Image, name file `Dockerfile.mysql`
2. Dockerfile should contain ENV variables to initialize the app_db database
3. Dockerfile should contain ENV variables to initialize app_user with password `1234`
4. Build mysql image with a name and tag mysql-local:1.0.0
5. You should be able to successfully run a container with MySQL with Volumes Attached
6. Push mysql-local:1.0.0 to your personal docker hub into mysql-local repository
7. Run mysql-local:1.0.0 on your machine
8. Update the Python app db config with an IP of a running MySQL server container (without it, the app container won’t build)
9. Build and run your updated app
10. Take a screenshot of a terminal with a successfully started application
11. Push the Image with a name and tag: todoapp:2.0.0 to your Docker Hub repository
12. Create the `INSTRUCTION.md` file
13. Update `INSTRUCTION.md` with instructions on how to run MySQL container with a volume attached
14. Update `INSTRUCTION.md` with instructions on how to run an App container which will connect to a MySQL db container.
15. `INSTRUCTION.md` should contain a link to your personal docker hub repository win an app image
16. `INSTRUCTION.md` should contain instructions on how to access the application via a browser.
17. Create PR with your changes and attach it for validation on a platform



## How to run MySQL container 

```
docker pull bohdanfsd/mysql-local
docker run  -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```

## To start app

```
docker pull bohdanfsd/todoapp
docker run -p 8080:8080 --name todoapp todoapp:2.0.0
```

## Check server

```
 http://0.0.0.0:8080/
 ```