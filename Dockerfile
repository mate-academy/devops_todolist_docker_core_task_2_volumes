# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY . .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

EXPOSE 8000

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# RUN python manage.py migrate

# Run database migrations and start the Django application
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

