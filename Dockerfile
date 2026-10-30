ARG PYTHON_VERSION=3.11

# Build stage
FROM python:${PYTHON_VERSION}-slim AS builder

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Run stage
FROM python:${PYTHON_VERSION}-slim AS runner

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /install /usr/local

COPY . .

EXPOSE 8080

CMD ["sh", "-c", "python manage.py migrate --noinput && python manage.py runserver 0.0.0.0:8080"]
