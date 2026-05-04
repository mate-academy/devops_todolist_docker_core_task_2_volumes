# Інструкція з розгортання TodoList у Docker з MySQL

## Docker Hub репозиторії

- MySQL образ: `<твій-dockerhub-юзернейм>/mysql:1.0.0`
- TodoApp образ: `<твій-dockerhub-юзернейм>/todoapp:2.0.0`

---

## Крок 1: Запуск MySQL контейнера

Завантажте образ та запустіть MySQL контейнер з постійним сховищем даних:

```bash
docker pull <твій-dockerhub-юзернейм>/mysql:1.0.0

docker run -d \
  --name mysql-local \
  -v mysql_data:/var/lib/mysql \
  -p 3306:3306 \
  <твій-dockerhub-юзернейм>/mysql:1.0.0
```

---

## Крок 2: Отримання IP-адреси MySQL контейнера

Виконайте команду, щоб дізнатися IP-адресу запущеного контейнера:

```bash
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql-local
```

Збережіть отриману IP-адресу — вона знадобиться на наступному кроці.

---

## Крок 3: Оновлення налаштувань підключення до бази даних

Відкрийте файл `todolist/settings.py` та замініть значення `HOST` на IP-адресу, отриману у попередньому кроці:

```python
DATABASES = {
    "default": {
        "ENGINE": "mysql.connector.django",
        "NAME": "app_db",
        "USER": "app_user",
        "PASSWORD": "1234",
        "HOST": "<IP-адреса з кроку 2>",
        "PORT": "",
    }
}
```

---

## Крок 4: Запуск TodoApp контейнера

Завантажте образ та запустіть застосунок:

```bash
docker pull <твій-dockerhub-юзернейм>/todoapp:2.0.0

docker run -d \
  --name todoapp \
  -p 8080:8080 \
  <твій-dockerhub-юзернейм>/todoapp:2.0.0
```

---

## Крок 5: Перевірка роботи застосунку

Відкрийте браузер та перейдіть за посиланнями:

- Головна сторінка: [http://localhost:8080](http://localhost:8080)
- API endpoint: [http://localhost:8080/api/](http://localhost:8080/api/)
