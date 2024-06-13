#!/bin/sh

set -e

python manage.py migrate

# run commands in this file to ensure that starting server will be as main proccess(PID 1) 
exec python manage.py runserver 0.0.0.0:8080