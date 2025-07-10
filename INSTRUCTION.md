# INSTRUCTION.md — інструкція по запуску

Щоб запустити MySQL контейнер з томом, виконай:
`docker volume create mysql_data && docker run -d --name sql -e MYSQL_DATABASE=app_db -e MYSQL_USER=app_user -e MYSQL_PASSWORD=1234 -e MYSQL_ROOT_PASSWORD=root -v mysql_data:/var/lib/mysql -p 3306:3306 litvinchukroman/mysql-local:1.0.0`
— після запуску перевір IP контейнера за допомогою 
`docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' sql` 
і підстав у `settings.py` (поле `'HOST'` замість IP), приклад: 
`DATABASES = { 'default': { 'ENGINE': 'mysql.connector.django', 'NAME': 'app_db', 'USER': 'app_user', 'PASSWORD': '1234', 'HOST': '172.17.0.2', 'PORT': '3306' } }`
. Далі побудуй образ додатку: `docker build -t todoapp:2.0.0 .` 
і запусти його: `docker run -d --name todoapp -p 8000:8000 todoapp:2.0.0`
. Після цього відкрий додаток у браузері за адресою `http://localhost:8000`.
Pull образів можна зробити командами: `docker pull litvinchukroman/mysql-local:1.0.0` та 
`docker pull litvinchukroman/todoapp:2.0.0`. Посилання на Docker Hub репозиторії:
https://hub.docker.com/r/litvinchukroman/mysql-local
Перевірка запуску: `docker ps && curl http://localhost:8000`.
Для створення Pull Request виконай: `git checkout -b feature/docker-instructions && git add INSTRUCTION.md && git commit -m "Add INSTRUCTION.md" && git push origin feature/docker-instructions`
— потім створи PR і надішли посилання на перевірку.