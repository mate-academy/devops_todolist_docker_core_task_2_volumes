Update README.md with instructions on how to run MySQL container with a volume attached:
docker build . -f Dockerfile.mysql -t mysql-local:1.0.0
docker run  -d -p 3306:3306 --name mysql-local -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
Update README.md with instructions on how to run an App container which will connect to a MySQL db container:
docker build . -t todoapp:2.0.0
docker run -d -p 8081:8080 --name todoapp todoapp:2.0.0
README.md should contain a link to your personal docker hub repository win an app image
https://hub.docker.com/r/salaxambar/mysql-local
https://hub.docker.com/r/salaxambar/todoapp2
README.md should contain instructions on how to access the application via a browser:
run http://localhost:8081/ at your browser