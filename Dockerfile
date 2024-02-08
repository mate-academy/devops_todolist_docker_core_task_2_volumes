# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}-alpine as builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION}-alpine as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

# This RUN need to build correctly on my local machine
RUN apk update \
    && apk add mariadb-dev \
    && apk add --no-cache mariadb-connector-c-dev \
    && apk add --no-cache musl-dev python3-dev \
    && apk add --no-cache gcc \
    && apk add --no-cache libc-dev \
    && apk add --no-cache mariadb-connector-c

# This RUN need to build correctly on my local machine
RUN echo "ulimit -s unlimited" >> /etc/profile.d/ulimit.sh

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN python manage.py migrate

# Run database migrations and start the Django application
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8080"]