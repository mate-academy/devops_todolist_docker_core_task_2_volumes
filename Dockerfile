# Шар 1: builder
FROM python:3.11 AS builder

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

# Шар 2: final
FROM python:3.11 AS final

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
