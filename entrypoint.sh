#!/bin/bash

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the server
echo "Starting server..."
exec python manage.py runserver 0.0.0.0:8080
