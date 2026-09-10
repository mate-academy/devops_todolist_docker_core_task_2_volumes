# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} AS builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} AS run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

# IP address of the running MySQL container, passed at build time:
#   docker build --build-arg DB_HOST=172.17.0.2 -t todoapp:2.0.0 .
ARG DB_HOST=localhost
ENV DB_HOST=${DB_HOST}

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN python manage.py migrate

# Run database migrations and start the Django application
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8080"]
