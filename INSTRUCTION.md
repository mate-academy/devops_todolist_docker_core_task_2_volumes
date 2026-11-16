# Django-Todolist Docker Instructions 🐳

Цей документ містить покрокові інструкції щодо запуску бази даних MySQL із використанням Docker Volumes та розгортання Django-додатку, який підключається до неї.

---

## 📋 Передумови
Перед запуском переконайтеся, що на вашому комп'ютері встановлено **Docker**.

---

## 1. Запуск контейнера MySQL із прикріпленим Volume 🗄️

Для забезпечення збереження даних бази даних ми використовуємо локальний Docker Volume та спеціальний Dockerfile.

1. **Створіть Docker volume для даних:**
   ```bash
   docker volume create mysql_data_vol
Зберіть образ MySQL:
Bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
Запустіть контейнер MySQL із підключеним волумом:
Bash
docker run -d --name mysql-container -v mysql_data_vol:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0

2. Запуск контейнера додатка (Django App) ⚙️
Додаток підключається до запущеного контейнера MySQL.
Отримайте IP-адресу запущеного контейнера MySQL:
Bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container
(Отриману IP-адресу необхідно вписати у файл todolist/settings.py в поле 'HOST')
Зберіть Docker-образ додатка:
Bash
docker build -t todoapp:2.0.0 .
Запустіть контейнер додатка:
Bash
docker run -d -p 8000:8000 todoapp:2.0.0

3. Docker Hub Repository ☁️
Зібраний та протестований образ додатка опубліковано у публічному репозиторії Docker Hub:
Посилання на репозиторій: Docker Hub - todoapp
Тег образу: zor1kk88/todoapp:2.0.0
Ви можете завантажити його безпосередньо командою:
Bash
docker pull zor1kk88/todoapp:2.0.0

4. Доступ до застосунку через браузер 🌐
Після успішного запуску контейнера додатку відкрийте вебпереглядач та перейдіть за адресою:
👉 http://localhost:8000