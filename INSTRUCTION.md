Links to Docker hub:
[profile](https://hub.docker.com/repository/docker/lateexairu/)
[todoapp](https://hub.docker.com/repository/docker/lateexairu/todoapp/general)
[mysql-local](https://hub.docker.com/repository/docker/lateexairu/mysql-local/general)

### To run MySQL container with a volume attached

- run mysql-local with -v flag:

```bash
docker run -d -p 3306:3306 --name mysql-local -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```

### To run an App container with connection to a MySQL db container

- find mysql container ip address with:

```bash
# check if bridge is listed
docker network list

# find Containers section with name "mysql-local" and copy IPv4Address value
docker  network  inspect  bridge
```

- in todolist/settings.py paste ip addredd into HOST value

```python
DATABASES  =  {
	'default':  {
		'ENGINE':  'mysql.connector.django',
		'NAME':  'app_db',
		'USER':  'app_user',
		'PASSWORD':  '1234',
		'HOST':  '[ip_address]',  # You can use a different host in your MySQL server is on a remote machine.
		'PORT':  '',
	}
}
```

- run app with:

```bash
docker run -d -p 8080:8080 --name todoapp todoapp:2.0.0
```

### To open in brower

- in browser address line open localhost on port 8080.
  [localhost:8080](http://localhost:8080/)
