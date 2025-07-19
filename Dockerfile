# 🏗 Build stage
FROM python:3.11-slim AS build

WORKDIR /app

# Копіюємо requirements і встановлюємо залежності
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --prefix=/install -r requirements.txt

# Копіюємо решту проєкту
COPY . .

# 🚀 Run stage (фінальний)
FROM python:3.11-slim

WORKDIR /app

# Копіюємо встановлені залежності з build stage
COPY --from=build /install /usr/local

# Копіюємо код
COPY --from=build /app /app

# Запускаємо застосунок
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]
