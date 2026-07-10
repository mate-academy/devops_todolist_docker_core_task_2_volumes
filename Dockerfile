FROM python:3.8-slim as  builder

WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:3.8-slim as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Run database migrations and start the Django application
ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8080"]
