# INSTRUCTION.md
Цей файл пояснює, як зібрати/запустити MySQL контейнер з томом, як зібрати/запушити образи в Docker Hub (репо midandnight) і як запустити App контейнер, який підключається до MySQL.
--- 
Загальні параметри
- DB name: app_db
- DB user: app_user
- DB password: 1234
- Docker Hub username: midandnight
- MySQL image name/tag локально: mysql-local:1.0.0
- App image name/tag локально: todoapp:2.0.0
- Папка для скріншота в репо: ./screenshots/app_started.png


1) Підготовка
- Створи мережу (рекомендується):
  docker network create todonet


2) Збірка і пуш MySQL образу
- Збірка з файлу Dockerfile.mysql:
  docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .


- Протегай і запуш в Docker Hub:
  docker tag mysql-local:1.0.0 midandnight/mysql-local:1.0.0
  docker push midandnight/mysql-local:1.0.0


- Посилання на теги:
  https://hub.docker.com/r/midandnight/mysql-local/tags


3) Запуск MySQL контейнера з томом
- Запусти контейнер (створить named volume mysql-data):
  docker run -d \
    --name mysql-local \
    --network todonet \
    -v mysql-data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=1234 \
    -e MYSQL_DATABASE=app_db \
    -e MYSQL_USER=app_user \
    -e MYSQL_PASSWORD=1234 \
    mysql-local:1.0.0


- Перевір логи, щоб дочекатися, поки MySQL підніметься:
  docker logs -f mysql-local


- Отримати IP контейнера (якщо необхідно):
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local


4) Додай залежність в requirements.txt (якщо ще не додано)
- У requirements.txt має бути рядок:
  mysql-connector-python==8.2.0
(це потрібно, щоб Django міг використовувати mysql.connector)


5) Налаштування todolist/settings.py (консистентність HOST)
- Рекомендую робити конфіг DB через змінну оточення, щоб однаково працювало локально і в контейнері.
  Приклад (суть — прочитати DB_HOST з ENV і мати дефолт 'localhost'):

import os
DB_HOST = os.environ.get('DB_HOST', 'localhost')
DATABASES = {
'default': {
'ENGINE': 'mysql.connector.django',
'NAME': 'app_db',
'USER': 'app_user',
'PASSWORD': '1234',
'HOST': DB_HOST,
'PORT': '',
}
}
- Якщо ти запускаєш Django на хості (не в контейнері), то можна залишити 'localhost' як HOST і підключитись до MySQL через проброс порту (див. нижче).
- Якщо запускаєш Django в контейнері — передавай DB_HOST=mysql-local (ім'я контейнера у тій же docker network).


6) Збірка і пуш App образу
- Локальна збірка:
docker build -t todoapp:2.0.0 .


- Тег і пуш в Docker Hub:
docker tag todoapp:2.0.0 midandnight/todoapp:2.0.0
docker push midandnight/todoapp:2.0.0


- Посилання на теги:
https://hub.docker.com/r/midandnight/todoapp/tags
Docker Hub репо (загальна сторінка):
https://hub.docker.com/r/midandnight/todoapp


7) Запуск App контейнера (варіант з Docker network — рекомендую)
- Запуск, передаючи DB_HOST як ім'я контейнера mysql-local:
docker run -d \
  --name todoapp \
  --network todonet \
  -e DB_HOST=mysql-local \
  -p 8000:8080 \
  midandnight/todoapp:2.0.0


- Якщо в контейнері внутрішній порт інший (наприклад 8000), скоригуй -p локальний:внутрішній та матч entrypoint.


- Альтернатива — якщо запускаєш Django на хості:
- Потрібно пробросити порт MySQL з контейнера на хост (наприклад 3306), або підключатись через localhost, якщо контейнер проброшений:
  docker run -d --name mysql-local -p 3306:3306 ... mysql-local:1.0.0
- Потім в settings.py використовувати HOST='localhost' (цей варіант менш бажаний для production, але підходить для локальної перевірки).


8) Міграції і перевірка логів
- Виконай міграції (inside container):
docker exec -it todoapp python manage.py migrate


- Перегляд логів:
docker logs -f todoapp


9) Доступ у браузері
- Якщо пробросив порт як у прикладі (-p 8000:8080), відкрий:
http://localhost:8000

