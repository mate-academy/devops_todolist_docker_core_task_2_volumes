# Django-Todolist Instructions

This guide explains how to set up and run the Django-Todolist application with a MySQL database using Docker.

## Prerequisites
- Docker and Docker Hub account
- Python >= 3.8
- Git

## Running the MySQL Container
1. **Pull the MySQL image**:
   ```bash
   docker pull rootdebian/mysql-local:1.0.0
   docker pull rootdebian/todoapp:2.0.0

This creates a persistent volume mysql-data and sets up the database app_db with user app_user and password 1234.

Running the Application Container
Pull the application image:

docker pull rootdebian/todoapp:2.0.0

Get the MySQL container IP:

docker inspect mysql-container | grep IPAddress

Note the IP (e.g., 172.17.0.2).

Update todolist/settings.py:
Replace the HOST in the DATABASES section with the MySQL container's IP:
python

'HOST': '172.17.0.2',  # Use your MySQL container IP

Run the application container:

docker run -d --name todoapp-container -p 8000:8000 rootdebian/todoapp:2.0.0

Accessing the Application
Open a browser and navigate to: http://localhost:8000/

Explore the landing page or API at: http://localhost:8000/api/

Docker Hub Repository
Application image: https://hub.docker.com/r/rootdebian/todoapp

MySQL image: https://hub.docker.com/r/rootdebian/mysql-local

