#!/bin/bash
set -e

echo "🗂️  Running database migrations..."
python manage.py migrate

echo "🚀 Starting Django server..."
exec python manage.py runserver 0.0.0.0:8000
