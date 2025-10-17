ToDo App — Docker Instructions
Repository Links

ToDo: https://hub.docker.com/repository/docker/yourname/todoapp/

Mysql-local: https://hub.docker.com/repository/docker/yourname/mysql-local/


Be sure to check requirements.txt for the presence of:
mysql-connector-python==8.2.0


MySQL Configuration

Before building the images, open todolist/settings.py
and review the database configuration around line 64:

Specify parameters such as:

HOST (default: localhost)

PORT (default: 3306)

USER, PASSWORD, and NAME as needed.

These values must match the settings used in the MySQL container.

Build MySQL image:
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0

Build ToDo App image:
docker build . -f Dockerfile -t todoapp:2.0.0

Tag and Push Images
MySQL:
docker tag mysql-local:1.0.0 yourname/mysql-local:1.0.0
docker push yourname/mysql-local:1.0.0

ToDo App:
docker tag todoapp:2.0.0 yourname/todoapp:2.0.0
docker push yourname/todoapp:2.0.0

Pull Images from Docker Hub:
docker pull yourname/mysql-local:1.0.0
docker pull yourname/todoapp:2.0.0

Create Docker Network

Both containers must run on the same network for connection:

docker network create todonet

Run MySQL container:
docker run -d --name mysql-local \
  --network todonet \
  -p 3306:3306 \
  -v my-mysql-data:/var/lib/mysql \
  yourname/mysql-local:1.0.0


If you didn’t modify todolist/settings.py, keep the default port 3306.
The named volume my-mysql-data stores database data persistently.

Run ToDo App container:
docker run -d --name todoapp \
  --network todonet \
  -e DB_HOST=mysql-local \
  -p 8080:8080 \
  todoapp:2.0.0


After both containers are running, open in a browser:
http://localhost:8080/

The application inside the container starts Django with:
python manage.py runserver 0.0.0.0:8080

Database Backend

The application now uses MySQL by default.
If needed, adjust connection parameters in todolist/settings.py before building.
SQLite remains supported only for legacy builds prior to v2.0.0.



https://ibb.co/sdrvG3TS   - screenshot showing the Django server started 
