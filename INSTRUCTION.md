# INSTRUCTION

Запуск Django-Todolist у Docker: контейнер MySQL з підключеним томом і контейнер застосунку, який до нього під'єднується.

## Docker Hub

| Образ | Репозиторій |
|---|---|
| `mysql-local:1.0.0` | https://hub.docker.com/r/kkurama/mysql-local |
| `todoapp:2.0.0` | https://hub.docker.com/r/kkurama/todoapp |

## 1. База даних MySQL

### 1.1 Збірка образу

```bash
docker build -f Dockerfile.mysql -t mysql-local:1.0.0 .
```

Образ базується на офіційному `mysql:8.0`. Змінні `MYSQL_DATABASE=app_db`, `MYSQL_USER=app_user`, `MYSQL_PASSWORD=1234` задані в `Dockerfile.mysql` — при першому старті офіційний entrypoint створює базу і користувача автоматично.

### 1.2 Запуск контейнера з томом

```bash
docker volume create mysql_data

docker run -d \
  --name mysql-local \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  mysql-local:1.0.0
```

Том `mysql_data` змонтовано в `/var/lib/mysql` — каталог, де MySQL зберігає дані. Завдяки цьому база переживає видалення й перестворення контейнера.

Дочекатися готовності бази:

```bash
docker logs -f mysql-local
```

Чекати рядок `ready for connections`, вийти через `Ctrl+C`.

Перевірка бази й користувача:

```bash
docker exec -it mysql-local mysql -uapp_user -p1234 -e "SHOW DATABASES;"
```

У списку має бути `app_db`.

### 1.3 Публікація образу в Docker Hub

```bash
docker login
docker tag mysql-local:1.0.0 kkurama/mysql-local:1.0.0
docker push kkurama/mysql-local:1.0.0
```

## 2. Застосунок

### 2.1 IP-адреса контейнера з базою

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

Команда поверне адресу виду `172.17.0.2`.

### 2.2 Збірка образу застосунку

```bash
docker build --build-arg DB_HOST=172.17.0.2 -t todoapp:2.0.0 .
```

`172.17.0.2` замінити на адресу з кроку 2.1.

IP передається саме на етапі збірки, бо Dockerfile виконує `RUN python manage.py migrate` — міграції застосовуються до бази під час build. Без доступної бази образ не збереться.

### 2.3 Запуск

```bash
docker run -d \
  --name todoapp \
  -p 8080:8080 \
  -e DB_HOST=172.17.0.2 \
  todoapp:2.0.0
```

Перевірка логів:

```bash
docker logs -f todoapp
```

Очікуваний вивід:

```
Watching for file changes with StatReloader
Starting development server at http://0.0.0.0:8080/
Quit the server with CONTROL-C.
```

### 2.4 Публікація образу в Docker Hub

```bash
docker tag todoapp:2.0.0 kkurama/todoapp:2.0.0
docker push kkurama/todoapp:2.0.0
```

## 3. Доступ через браузер

| Адреса | Що це |
|---|---|
| http://localhost:8080/ | цільова сторінка застосунку |
| http://localhost:8080/api/ | браузерний інтерфейс REST API |
| http://localhost:8080/admin/ | панель адміністратора Django |

Створити суперкористувача для входу в адмінку:

```bash
docker exec -it todoapp python manage.py createsuperuser
```

## Скріншот запущеного застосунку

Термінал з обома контейнерами в статусі `Up` і працюючим застосунком:

https://docs.google.com/document/d/1EXDnBNW08rIOdmQQcn3roLloZ2Tgy4GCQPYg3kCbXrk/edit

## 4. Тести

```bash
docker exec -it todoapp python manage.py test
```

Django створює окрему тестову базу, тому користувач `app_user` має мати право її створювати. За замовчуванням у нього доступ лише до `app_db`, і перший запуск падає з `Access denied for user 'app_user'@'%' to database 'test_app_db'`. Видати права одноразово:

```bash
docker exec -it mysql-local mysql -uroot -proot1234 \
  -e "GRANT ALL PRIVILEGES ON *.* TO 'app_user'@'%'; FLUSH PRIVILEGES;"
```

### Відомі падіння на MySQL

Після видачі прав виконуються всі 54 тести, з них 6 падають:

```
FAIL: test_login (accounts.tests.AccountsTests)          AssertionError: '5' != '1'
FAIL: test_get_todolist (api.tests.TodoListTests)        AssertionError: 3 != 1
FAIL: test_get_todo (api.tests.TodoTests)                AssertionError: 3 != 1
FAIL: test_get_when_not_logged_in (TodoListTests)        AssertionError: 404 != 200
FAIL: test_get_when_not_logged_in (TodoTests)            AssertionError: 404 != 200
FAIL: test_get_user_if_admin (api.tests.UserTests)       AssertionError: 404 != 200
```

Причина спільна і не пов'язана з конфігурацією контейнерів. Тести написані під SQLite і очікують, що створений об'єкт матиме `id=1`. Django `TestCase` виконує кожен тест у транзакції та відкочує її; у SQLite лічильник автоінкремента при відкаті скидається, в InnoDB — ні. Документація MySQL: *"if a transaction that generated auto-increment values rolls back, those auto-increment values are lost... Such lost values are not reused"*. Тому в MySQL об'єкти отримують `id` 3, 5 і далі, а запити до `/api/todolists/1/` повертають 404.

Виправляється переписуванням тестів на реальні `id` замість жорстко заданої одиниці (`todolist.id` замість `1`) — це зміна коду тестів, а не інфраструктури, тому в межах цього завдання не виконувалась.

Джерело: https://dev.mysql.com/doc/refman/8.0/en/innodb-auto-increment-handling.html

## 5. Зупинка й прибирання

```bash
docker stop todoapp mysql-local
docker rm todoapp mysql-local
```

Том `mysql_data` лишається — дані збережені. Видалити разом з даними:

```bash
docker volume rm mysql_data
```

## Примітки

- IP контейнера MySQL змінюється при його перезапуску. Після рестарту бази треба повторити крок 2.1 і перезібрати образ застосунку з новим `--build-arg DB_HOST`.
- `DB_HOST` має значення за замовчуванням `localhost` — для запуску застосунку напряму на машині, без Docker.
- Змінні `MYSQL_*` спрацьовують лише при першій ініціалізації порожнього тому. Якщо змінити пароль у `Dockerfile.mysql`, старий том треба видалити: `docker volume rm mysql_data`.
