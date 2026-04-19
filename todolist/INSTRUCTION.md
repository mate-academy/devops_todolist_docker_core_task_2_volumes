# Інструкція із запуску додатка Django-Todolist у Docker

Цей посібник містить покрокові інструкції щодо розгортання та налаштування вебдодатка Django-Todolist із використанням бази даних MySQL у контейнерах Docker.

---

## 1. Запуск контейнера MySQL з прив'язкою тома (Volume)

Для збереження даних використовується Docker Volume. Оскільки змінні оточення (пароль, назва БД) вже прописані всередині Dockerfile.mysql, команда запуску виглядає наступним чином:

**Команда для запуску бази даних:**

```bash
docker run -d \
  --name mysql-server \
  -v /home/kitty/mysql:/var/lib/mysql \
  mysql-local:1.0.0
```
* **--name:** назва контейнера для зручного керування.
* **-v:** шлях до локальної папки на вашому хості (/home/kitty/mysql) для синхронізації з даними MySQL всередині контейнера.

## 3. Налаштування додатка
Перед збіркою образу додатка переконайтеся, що у файлі todolist/settings.py у секції DATABASES вказано правильну IP-адресу запущеного контейнера MySQL. Дізнатися її можна командою:
```bash
docker inspect mysql-server | grep IPAddress
```
## 4. Запуск контейнера з додатком
Образ додатка доступний у [Docker Hub](https://hub.docker.com/r/zeroootwo/todoapp)

**Команда запуску:**

```Bash
docker run -d \
  -p 8081:8080 \
  --name my-todo-app \
  zeroootwo/todoapp:2.0.0
  ```
## 5. Виконання міграцій
Після запуску обох контейнерів необхідно створити структуру таблиць у базі даних:

```Bash
docker exec -it my-todo-app python manage.py migrate
```
## 6. Доступ до додатка
Після успішного виконання всіх кроків додаток буде доступний у браузері за адресою:
http://localhost:8081/

**[Docker Hub Repository zeroootwo](https://hub.docker.com/u/zeroootwo)**