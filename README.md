1. Pull the MySQL Image - docker pull vlad584/mysql-local
2. Launch the MySQL Container with a Volume Attached - docker run -d --name mysql-local -p 3306:3306 -v mysql-data:/var/lib/mysql mysql-local:1.0.0
3. Pull the Todo App Image - docker pull vlad584/todoapp_2.0.0
4. Launch the Todo App Container - docker run -d --name todoapp -p 8081:8080 vlad584/todoapp_2.0.0
5. Access the Application
Once both containers are running, open your browser and go to: http://localhost:8081
