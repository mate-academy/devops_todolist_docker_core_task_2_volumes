# INSTRUCTION.md

## 1. Як запускати контейнер MySQL

Щоб запустити контейнер MySQL, виконайте наступну команду в терміналі:

docker run -d --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
  -e MYSQL_DATABASE=${MYSQL_DATABASE} \
  -e MYSQL_USER=${MYSQL_USER} \
  -e MYSQL_PASSWORD=${MYSQL_PASSWORD} \
  -v mysql_data:/var/lib/mysql -p 3306:3306 mysql-local:1.0.0

# Ця команда:

Створює контейнер з ім'ям mysql-container.
Встановлює пароль для користувача root як rootpassword.
Створює базу даних app_db та користувача app_user з паролем 1234.
Прив'язує том mysql_data для зберігання даних.
Відкриває порт 3306 для доступу до MySQL.

# Щоб перевірити, чи працює контейнер, скористайтесь командою:

docker ps

# 2. Як запускати додаток і підключати до бази даних
Переконайтесь, що контейнер MySQL працює (як описано вище).
Оновіть налаштування підключення до MySQL в файлі settings.py вашого проєкту Django:

DATABASES = {
    'default': {
        'ENGINE': 'mysql.connector.django',
        'NAME': 'app_db',
        'USER': 'app_user',
        'PASSWORD': '1234',
        'HOST': 'localhost',  # Змінити на IP контейнера MySQL пізніше.
        'PORT': '',  # Залишити порожнім для стандартного порту MySQL (3306).
    }
}

# Отримайте IP контейнера MySQL, використовуючи команду:

docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-container

# Оновіть параметр HOST в settings.py на отриманий IP-адрес:
python


# 'HOST': 'IP_КОНТЕЙНЕРА',  # Замість 'IP_КОНТЕЙНЕРА' вставте отриману адресу.
# Запустіть додаток:

docker run -d --name todoapp-container --link mysql-container:mysql -p 8000:8000 todoapp:2.0.0

Ваш додаток тепер має підключитись до бази даних MySQL через зазначений контейнер.

# 3. Посилання на Docker Hub репозиторій

Docker Hub mysql - [docker pull yur11lesyk/mysql-local:1.0.0](https://hub.docker.com/r/yur11lesyk/mysql-local)  
DOcker Hub repo - [docker pull yur11lesyk/todoapp](https://hub.docker.com/r/yur11lesyk/todoapp)

# Замість yourusername та yourrepository вкажіть ваші власні дані.

Цей файл містить інструкції щодо запуску контейнера MySQL, налаштування підключення додатка до бази даних і посилання на Docker Hub репозиторії для подальшої роботи з вашим проєктом.