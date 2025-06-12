https://hub.docker.com/repositories/dimak20

1) Create not anonymous volume
```bash
docker volume create mysql_mate_data
```
2) Build a Dockerfile.mysql Image
```shell
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
```
3) Run MySQL container
```shell
docker run -d -p 3306 -v mysql_mate_data:/var/lib/mysql --name mysql mysql-local:1.0.0
```
4) Inspect bridge network driver to investigate db host
```shell
docker network inspect bridge
```
5) Update DB config in django settings module
```python
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.mysql",
        "NAME": "app_db",
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': '172.17.0.2', #host from network inspection
        'PORT': '3306',
    }
}
```
6) Build an Image for django app
```shell
docker build . -f Dockerfile -t todoapp:2.0.0
```
7) Create and run the container
```shell
dockre run -d -p 8000:8000 --name todoapp todoapp:2.0.0
```
8) Access django app with localhost:8000