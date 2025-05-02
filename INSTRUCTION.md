# Project Instructions


## Docker Hub Links

- MySQL Image: https://hub.docker.com/repository/docker/lambdda/mysql-local/tags/1.0.0/sha256-4f7a22ab6549c54dd07c6b7871efebc1d435d8bd3b71078f3ae9ebb4a7fde2ff

- Django App: https://hub.docker.com/repository/docker/lambdda/todoapp/tags/2.0.0/sha256:2cd34ccf20a706a3cac6f7a954184ef7c61fa0123bae451a717045dd924c2269


## Step 1: Running MySQL container

```bash
docker run -d --name my-mysql \

  -v my-mysql-data:/var/lib/mysql \

  -p 3306:3306 \

  lambdda/mysql-local:1.0.0
```

- Initializes a **MySQL database named `app_db`**
- Creates a **user `app_user`** with password `1234`
- Sets **root password** to `1234`


## Step 2: Run the Django app container

Make sure the Django app is configured to connect to the MySQL container using its IP address.

Example `settings.py`:
```bash
DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.2',  # Use 'docker inspect' to get this IP
        'PORT': '3306',
    }
}
```

Then run:
```bash
docker run -d --name todoapp -p 8080:8080 lambdda/todoapp:2.0.0
```
  

## Step 3: Apply django migrations:
  
```bash
docker exec -it todoapp python manage.py migrate
```
  

## Step 4: Access the app in a browser

Visit: http://localhost:8080