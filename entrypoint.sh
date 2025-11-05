#!/bin/bash
set -e

echo "Waiting for database..."
python manage.py migrate

echo "Starting server..."
python manage.py runserver 0.0.0.0:8080

