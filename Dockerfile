# Dockerfile
FROM python:3.8

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

# НЕ виконуємо migrate тут:(
