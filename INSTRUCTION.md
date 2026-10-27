Instructions:

Run MySQL with a volume:
docker run -d -p 3306:3306 --name my_sql_db -v mysql_data:/var/lib/mysql user2134567432/mysql-local:1.0.0
MySQL Docker Hub: https://hub.docker.com/r/user2134567432/mysql-local

Run the App:
docker run -d -p 8080:8080 --name todoapp user2134567432/todoapp:2.0.0
Ensure the app is configured to connect to the MySQL container.

Docker Hub:
Repository: https://hub.docker.com/r/user2134567432/todoapp

Access the App:
Open http://localhost:8080 in your browser.