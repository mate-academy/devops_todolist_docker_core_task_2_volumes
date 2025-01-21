# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Установка утилиты wait-for-it
RUN apt-get update && apt-get install -y wait-for-it

# Команда запуска
CMD ["sh", "-c", "wait-for-it mysql-container:3306 -- python manage.py migrate && python manage.py runserver 0.0.0.0:8080"]
