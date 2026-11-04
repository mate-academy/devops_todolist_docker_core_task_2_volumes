#!/bin/sh

set -e

echo "Applying database migrations..."
python manage.py migrate

echo "Starting Django applications..."
exec python manage.py runserver 0.0.0.0:8080