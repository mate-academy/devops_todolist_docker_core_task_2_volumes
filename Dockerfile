# Stage 1: Build Stage
ARG PYTHON_VERSION=3.9.6
FROM python:${PYTHON_VERSION} AS builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION}-slim AS run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --no-cache-dir -r requirements.txt


# Run database migrations and start the Django application
ENTRYPOINT ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8080"]
