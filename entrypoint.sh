#!/bin/bash

# Function to wait for MySQL to be ready
wait_for_mysql() {
    echo "Waiting for MySQL to be ready..."
    while ! python -c "import mysql.connector; mysql.connector.connect(host='mysql-todolist', user='app_user', password='1234', database='app_db')" 2>/dev/null; do
        echo "MySQL is unavailable - sleeping"
        sleep 1
    done
    echo "MySQL is up - executing command"
}

# Wait for MySQL
wait_for_mysql

# Run migrations
python manage.py migrate

# Start the application
python manage.py runserver 0.0.0.0:8080 