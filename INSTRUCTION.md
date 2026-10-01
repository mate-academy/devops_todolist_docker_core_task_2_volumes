# Інструкція з запуску Django Todo App та MySQL у Docker

Цей документ містить покрокові інструкції для збірки, налаштування та запуску бази даних MySQL та вебзастосунку TodoApp в ізольованих Docker-контейнерах із прив'язкою сховища (Volumes).

---

## Крок 1: Створення Docker-мережі та сховища

Щоб контейнери могли взаємодіяти між собою за іменами всередині мережі, виконайте:

```bash
docker network create todo_network
```

---

## Крок 2: Запуск контейнера MySQL з Volume

Запустіть контейнер MySQL із підключенням іменованого Docker Volume (`mysql_data`) для збереження даних після перезапуску та інтеграцією в спільну мережу:

```bash
docker run -d \
  --name mysql-container \
  --network todo_network \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

---

## Крок 3: Запуск контейнера Django-додатка (TodoApp)

Запустіть контейнер вебзастосунку всередині тієї самої мережі `todo_network`, прокинувши порт `8000`:

```bash
docker run -d \
  --name django-app \
  --network todo_network \
  -p 8000:8000 \
  todoapp:2.0.0
```

*Примітка: Після першого запуску застосунку застосуйте міграції бази даних:*
```bash
docker exec -it django-app python manage.py migrate
```

---

## Крок 4: Доступ до вебзастосунку у браузері

Після успішного запуску обох контейнерів та виконання міграцій ви можете отримати доступ до інтерфейсу програми та API через будь-який веббраузер за адресою:
* **http://localhost:8000**

---

## Посилання на Docker Hub Репозиторії

## Посилання на Docker Hub Репозиторії

* **MySQL Image:** [https://hub.docker.com/r/vitsheo/mysql-local](https://hub.docker.com/r/vitsheo/mysql-local)
* **App Image:** [https://hub.docker.com/r/vitsheo/todoapp](https://hub.docker.com/r/vitsheo/todoapp)

