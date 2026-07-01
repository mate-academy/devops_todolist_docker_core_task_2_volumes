ARG PYTHON_VERSION=3.10

# ---------- BUILD STAGE ----------
FROM python:${PYTHON_VERSION} AS builder

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --prefix=/install -r requirements.txt

COPY . .


# ---------- RUN STAGE ----------
FROM python:${PYTHON_VERSION}-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Копируем зависимости
COPY --from=builder /install /usr/local

# Копируем код (включая init.sql)
COPY . .

# Устанавливаем MySQL Server и выполняем миграцию
# Устанавливаем MySQL Server и выполняем миграцию
RUN apt-get update && \
    apt-get install -y default-mysql-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    (mysqld_safe --skip-networking &) && \
    sleep 10 && \
    mysql -u root < init.sql && \
    mysqladmin --socket=/var/run/mysqld/mysqld.sock shutdown

EXPOSE 8080

ENTRYPOINT ["python", "app.py"]