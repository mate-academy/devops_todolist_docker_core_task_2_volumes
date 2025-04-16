# Інструкції для запуску MySQL і Python App контейнерів.

### 1. **Підготовка Dockerfile для MySQL**

Створіть файл `Dockerfile.mysql` для налаштування бази даних MySQL за допомогою офіційного образу MySQL.

**Dockerfile.mysql:**

```dockerfile
# Використовуємо офіційний образ MySQL
FROM mysql:latest

# Встановлюємо змінні середовища для MySQL
ENV MYSQL_DATABASE=app_db
ENV MYSQL_USER=app_user
ENV MYSQL_PASSWORD=1234
ENV MYSQL_ROOT_PASSWORD=1234

# Відкриваємо порт MySQL (за замовчуванням 3306)
EXPOSE 3306
```

### 2. Building the Image of MySQL

Для створення образу MySQL з файлу Dockerfile.mysql скористайтеся командою:

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Це створить образ з тегом mysql-local:1.0.0.

### 3. Запуск контейнера MySQL з прикріпленим томом

Тепер ви можете запустити контейнер для MySQL з прикріпленим томом для зберігання даних:

```bash
docker run -d \
  --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=app_db \
  -e MYSQL_USER=app_user \
  -e MYSQL_PASSWORD=1234 \
  -v mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

Пояснення:

-v mysql-data:/var/lib/mysql: Прикріпляє том з назвою mysql-data для зберігання даних MySQL. Це дозволяє зберігати дані між перезапусками контейнера.

-p 3306:3306: Відкриває порт 3306 для доступу до MySQL з хостової машини.

### 4. Запуск контейнера Python App, що підключається до MySQL

Тепер потрібно запустити контейнер для вашого Python додатку, який буде підключатися до MySQL:

```bash
docker run -d \
  --name python-app \
  --link mysql-container:mysql \
  -p 8000:8000 \
  python-app:latest
```

Пояснення:

--link mysql-container:mysql: Це встановлює зв'язок між контейнером Python і контейнером MySQL. Ви можете використовувати mysql як хост для підключення до бази даних.

-p 8000:8000: Відкриває порт 8000 на вашій машині для доступу до вашого Python додатку через браузер.

### 5. Як отримати доступ до додатку через браузер

Після запуску контейнера Python додатку ви можете отримати доступ до нього через браузер:

```arduino
http://localhost:8000
```

### 6. Посилання на Docker Hub репозиторії

MySQL Image: https://hub.docker.com/repository/docker/danyakube/mysql-local/general

Python App Image: https://hub.docker.com/repository/docker/danyakube/todoapp/general
