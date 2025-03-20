Link to repositor with application katkot/todoapp:2.0.0

docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
docker run -d -p 3306:3306 -v mysql:var/lib/mysql mysql-local:1.0.0

update the settings.py with 'HOST': '172.17.0.2'

docker build . -t todoapp:2.0.0
docker run -d -p 8080:8080 todoapp:2.0.0

Open http://localhost:8080/ in the browser