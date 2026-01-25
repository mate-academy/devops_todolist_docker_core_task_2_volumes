**Create Docker network:** docker network create todo-network

**Build MySQL image:** docker build -f Dockerfile.mysql -t antonclouds/mysql-local:1.0.0 . Available on Docker Hub: https://hub.docker.com/r/antonclouds/mysql-local

**Start MySQL container:** docker run -d --name mysql-local --network todo-network -v mysql_data:/var/lib/mysql -p 3306:3306 antonclouds/mysql-local:1.0.0

**Build app image:** docker build -t antonclouds/todoapp:2.0.0 . Available on Docker Hub: https://hub.docker.com/r/antonclouds/todoapp

**Run app container:** docker run -d --name todoapp --network todo-network -p 8080:8080 antonclouds/todoapp:2.0.0

**Link to the app:** http://localhost:8080/

