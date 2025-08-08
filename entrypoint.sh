#!/bin/sh

while ! python -c "
import sys
import socket
try:
    sock = socket.create_connection(('db', 3306), timeout=1)
    sock.close()
except Exception:
    sys.exit(1)
" ; do
    sleep 1
done

python manage.py migrate

exec python manage.py runserver 0.0.0.0:8080
