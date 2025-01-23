INSTRUCTION.md

Step 1: Run MySQL Container with a Volume Attached
	1.	Pull the MySQL Docker image from the repository:

docker pull vladdemchuk1999/mysql-local:1.0.0


	2.	Run the MySQL container with a volume attached to persist database data:

docker run -p 3306:3306 -v mysql-local-data:/var/lib/mysql --name my-mysql vladdemchuk1999/mysql-local:1.0.0

	•	-p 3306:3306: Maps port 3306 on the host to port 3306 in the container for database access.
	•	-v mysql-local-data:/var/lib/mysql: Attaches a named volume (mysql-local-data) to persist database data.
	•	--name my-mysql: Names the container my-mysql.

Step 2: Run App Container and Connect it to MySQL
	1.	Pull the ToDo App Docker image from the repository:

docker pull vladdemchuk1999/todoapp:2.0.0


	2.	Run the ToDo App container:

docker run -p 8080:8080 --name my-todoapp vladdemchuk1999/todoapp:2.0.0

	•	-p 8080:8080: Maps port 8080 on the host to port 8080 in the container for app access.
	•	--name my-todoapp: Names the container my-todoapp.

Step 3: Access the Application
	1.	Open your browser.
	2.	Navigate to the following URL:

http://localhost:8080

The application should load, and you can start using the ToDo app.

Step 4: Verify MySQL Container Connection
	•	Ensure the app is correctly connected to the MySQL database by checking application logs or debugging connectivity if necessary.

Docker Hub Repositories
	•	[MySQL Image](https://hub.docker.com/repository/docker/vladdemchuk1999/mysql-local/general)
	•	[ToDo App Image](https://hub.docker.com/repository/docker/vladdemchuk1999/todoapp/general)
