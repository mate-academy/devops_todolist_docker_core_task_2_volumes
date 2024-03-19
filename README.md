# Django-Todolist

Django-Todolist is a todolist web application with the most basic features of most web apps, i.e. accounts/login, API and (somewhat) interactive UI.


MySQL Local Image: https://hub.docker.com/repository/docker/cthusq/my_sql/general

To run MySQL container with a volume attached:

docker build -f mysql.Dockerfile . -t mysql-local:1.0.0
docker run --name mysql-container -v mysql-volume:/var/lib/mysql -d mysql-local:1.0.0


Django App Image: https://hub.docker.com/repository/docker/cthusq/jango_app/general

To run an App container which will connect to a MySQL db container:

docker build . -t django_app:1.0.0
docker run -d -p 8082:8080 --name django_container django_app:1.0.0

To open app in browser -> http://localhost:8082

