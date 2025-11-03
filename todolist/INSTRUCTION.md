# Інструкція по Запуску Проєкту

Ця інструкція описує, як запустити додаток Todo App та необхідну для нього базу даних MySQL за допомогою Docker.

## 1. Запуск Бази Даних (MySQL)

1.  Переконайтеся, що Docker запущено.
2.  Виконайте команду в терміналі, щоб завантажити та запустити контейнер MySQL. Ця команда автоматично створить volume `mysql_data` для постійного зберігання даних.

    ```bash
    docker run -d --name my-sql-db -p 3306:3306 \
      -v mysql_data:/var/lib/mysql \
      YOUR_DOCKERHUB_USERNAME/mysql-local:1.0.0
    ```

## 2. Запуск Додатку (Todo App)

**Важливо:** Цей образ додатку був зібраний з IP-адресою, яка може не працювати на вашій машині. Для коректної роботи додаток слід збирати локально, попередньо дізнавшись IP-адресу контейнера `my-sql-db` (через `docker network inspect bridge`).

1.  Для запуску попередньо зібраного образу виконайте:

    ```bash
    docker run -d --name my-todo-app -p 8080:8080 \
      YOUR_DOCKERHUB_USERNAME/todoapp:2.0.0
    ```

## 3. Доступ до Додатку

Після успішного запуску обох контейнерів, ви можете отримати доступ до веб-додатку.

* Відкрийте ваш браузер і перейдіть за адресою: **[http://localhost:8080](http://localhost:8080)**

## 4. Посилання на Репозиторії Docker Hub

* **Образ MySQL:** [https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/mysql-local](https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/mysql-local)
* **Образ Додатку:** [https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/todoapp](https://hub.docker.com/r/YOUR_DOCKERHUB_USERNAME/todoapp)