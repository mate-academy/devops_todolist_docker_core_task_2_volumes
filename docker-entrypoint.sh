#!/usr/bin/env bash
set -e

# Ждём MySQL (простейший способ)
echo "Waiting for MySQL at ${DB_HOST:-localhost}:3306 ..."
# 30 попыток, раз в 1 сек — можно заменить на wait-for-it/netcat
for i in {1..30}; do
  if python - <<'PY'
import socket, os
host = os.environ.get("DB_HOST","127.0.0.1")
s = socket.socket(); s.settimeout(1)
try:
    s.connect((host, 3306)); print("OK")
    s.close(); raise SystemExit(0)
except Exception:
    raise SystemExit(1)
PY
  then
    break
  fi
  sleep 1
done

# Миграции (теперь на старте, а не в build)
python manage.py migrate --noinput

# Старт Django
exec python manage.py runserver 0.0.0.0:8080
