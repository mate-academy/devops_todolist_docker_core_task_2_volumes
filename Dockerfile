# Stage 1: Build Stage
ARG PYTHON_VERSION=3.9
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Run database migrations and start the Django application
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]
