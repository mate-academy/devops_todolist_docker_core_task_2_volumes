FROM python:3.12-slim

WORKDIR /app

# Системні залежності для MySQL конектора
RUN apt-get update && apt-get install -y gcc default-libmysqlclient-dev && rm -rf /var/lib/apt/lists/*

# Скопіювати requirements і встановити
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Скопіювати код
COPY . .

EXPOSE 8000

# При запуску контейнера робимо міграції і стартуємо сервер
CMD ["bash", "-lc", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
