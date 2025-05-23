You can find the Docker image of this application here:
https://hub.docker.com/r/dspyrydonov/todoapp
And image with MySQL db here:
https://hub.docker.com/r/dspyrydonov/mysql-local

For building and running the container with bd you should do this:
1. Pull container to your local machine via `docker pull dspyrydonov/mysql-local`
2. Run container via `docker run -d -p 3306:3306 -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0`

For building and running the container you should do this:
1. Pull container to your local machine via `docker pull dspyrydonov/todoapp:1.0.0`
2. Run container via `docker run -d -p 8080:8080 todoapp:1.0.0`

You can open the application on: http://localhost:8080