### Docker hub repository with an app image and sql image
https://hub.docker.com/repository/docker/urapikh/todoapp/general
https://hub.docker.com/repository/docker/urapikh/mysql-local/general

### To run MySQL container with a volume attached use this additional option in docker cli
```-v mysql-data:/var/lib/mysql```

This is full command

```docker run -d -p 3306:3306 --name mysql-container -v mysql-data:/var/lib/mysql mysql-local:1.0.0```

### Run python app
1. Find IP of mysql container

   ```docker network inspect bridge```

2. Replace HOST IP with mysql IP  in settings.py line 70
3. Build container

   ```docker build -f Dockerfile . -t todoapp:2.0.0```

4. Run container

   ```docker run -d -p 8080:8080 --name app3 todoapp:2.0.0```

Access the application via a browser http://0.0.0.0:8080/