# Інструкція із запуску додатка Django-Todolist у Docker

Цей посібник містить покрокові інструкції щодо розгортання та налаштування вебдодатка Django-Todolist із використанням бази даних MySQL у контейнерах Docker.

---

## 1. Створюємо мережу

```bash
docker network create todo-network
```

## 2. Запуск контейнера MySQL з прив'язкою тома (Volume)

Для збереження даних використовується Docker Volume. Оскільки змінні оточення (пароль, назва БД) вже прописані всередині Dockerfile.mysql, команда запуску виглядає наступним чином:

**Команда для запуску бази даних:**

```bash
docker run -d \
  --name mysql-server \
  --network todo-network \
  --network-alias db \
  -v todo_mysql_data:/var/lib/mysql \
  mysql-local:1.0.0
```
* **--name:** назва контейнера для зручного керування.
* **-v:** шлях до локальної папки на вашому хості (todo_mysql_data) для синхронізації з даними MySQL всередині контейнера.

## 3. Запуск контейнера з додатком
Образ додатка доступний у Docker Hub:

**Команда запуску:**

```Bash
docker run -d \
  --name my-todo-app \
  --network todo-network \
  -p 8081:8000 \
  zeroootwo/todoapp:2.0.0
  ```
## 4. Виконання міграцій
Після запуску обох контейнерів необхідно створити структуру таблиць у базі даних:

```Bash
docker exec -it my-todo-app python manage.py migrate
```
## 5. Доступ до додатка
Після успішного виконання всіх кроків додаток буде доступний у браузері за адресою:
http://localhost:8081/

**Docker Hub Repository [https://hub.docker.com/r/zeroootwo/todoapp](https://hub.docker.com/r/zeroootwo/todoapp)**