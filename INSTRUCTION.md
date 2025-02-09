# INSTRUCTION.md

## Запуск MySQL-контейнера

1. **Зібрати Docker-образ MySQL**:
   ```sh
   docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
 
   ```

2. **Запустити контейнер MySQL**:
   ```sh
   docker run -d -p 3306:3306 --name mysql-local -v my_sql:/var/lib/mysql mysql-local:1.0.0
   ```

3. **Перевірити, чи контейнер працює**:
   ```sh
   docker ps
   ```
   У списку має з’явитися `mysql-local`.

4. **Отримати IP-адресу MySQL-контейнера**:
   ```sh
   docker network inspect bridge
   "Name": "mysql-local",
                "EndpointID": "78455d6e233994b427634fca8cfe16eee6102ffb336036569af64f59ad89550c",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""

   Запам’ятайте отриману IP-адресу для налаштувань Django.

---

## Запуск Django-контейнера

1. **Оновити налаштування бази даних у `todolist/settings.py`**:
   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'mysql.connector.django',
           'NAME': 'app_db',
           'USER': 'app_user',
           'PASSWORD': '1234',
           'HOST': '172.17.0.2',
           'PORT': '3306',
       }
   }
   ```
   

2. **Зібрати Docker-образ для Django**:
   ```sh
   docker build -t todoapp:2.0.0 .
   ```

3. **Запустити Django-контейнер**:
   ```sh
   docker run -d -p 8081:8080 --name todoapp todoapp:2.0.0
   ```

4. **Переконатися, що контейнер запущено**:
   ```sh
   docker ps
   ```
   У списку має бути `todoapp`.

---

## Доступ до застосунку через браузер

Після запуску контейнера відкрийте браузер і перейдіть за посиланням:
```
http://localhost:8001
```
Ви маєте побачити головну сторінку Django-Todolist.

---

# Інструкція для завантаження образів у Docker Hub

## 1️ Авторизація в Docker Hub
Перед завантаженням образів потрібно увійти в Docker Hub:
```sh
docker login
```
Після виконання команди введіть свої облікові дані Docker Hub.

---

## 2️. Перевірка наявних образів
Щоб перевірити, які образи є у вашій системі, виконайте команду:
```sh
docker images
```
Очікуваний результат:
```
REPOSITORY         TAG       IMAGE ID       CREATED          SIZE
mysql-local        1.0.0     abc123def456   10 minutes ago   300MB
todoapp           2.0.0     def456ghi789   5 minutes ago    400MB
```

---

## 3️. Додавання тегів для Docker Hub
Замість `your_dockerhub_username` вкажіть свій реальний обліковий запис у Docker Hub.
```sh
docker tag mysql-local:1.0.0 your_dockerhub_username/mysql-local:1.0.0
docker tag todoapp:2.0.0 your_dockerhub_username/todoapp:2.0.0
```

---

## 4️. Переконатися, що теги додані правильно
Щоб перевірити, чи все налаштовано вірно, виконайте команду:
```sh
 docker images
```
Очікуваний результат:
```
REPOSITORY                  TAG       IMAGE ID       CREATED         SIZE
mysql-local                 1.0.0     abc123def456   10 minutes ago  300MB
todoapp                     2.0.0     def456ghi789   5 minutes ago   400MB
your_dockerhub_username/mysql-local  1.0.0     abc123def456   10 minutes ago  300MB
your_dockerhub_username/todoapp      2.0.0     def456ghi789   5 minutes ago   400MB
```

---

## 5️. Завантаження образів у Docker Hub
```sh
docker push your_dockerhub_username/mysql-local:1.0.0
docker push your_dockerhub_username/todoapp:2.0.0
```

---

## 6️. Перевірка завантажених образів
Перейдіть у свій обліковий запис на **[Docker Hub](https://hub.docker.com/)** та перевірте, чи з’явилися там образи `mysql-local:1.0.0` і `todoapp:2.0.0`.







