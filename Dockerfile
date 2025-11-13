ARG PY_BASE=3.11-slim

# --- build stage ---
FROM python:${PY_BASE} AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip \
 && pip wheel --wheel-dir=/wheels -r requirements.txt

# --- run stage ---
FROM python:${PY_BASE}
ENV PYTHONUNBUFFERED=1
WORKDIR /app

COPY --from=build /wheels /wheels
RUN pip install --no-index --find-links=/wheels /wheels/*

COPY . .

# entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["docker-entrypoint.sh"]
