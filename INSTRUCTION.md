# TodoList Application - Прості інструкції

## Q: Як створити том для MySQL?

**A:** Спочатку створіть том:
```bash
docker volume create my-mysql-data
```

## Q: Як зібрати образи MySQL та додатку?

**A:** Зберіть обидва образи з правильними тегами:

```bash
# Зібрати MySQL образ
docker build -t <username>/mysql-local:1.0.0 -f Dockerfile.mysql .

# Зібрати образ додатку
docker build -t <username>/todoapp:2.0.0 .
```

## Q: Як опублікувати образи на Docker Hub?

**A:**
```bash
# Push MySQL образ
docker push <username>/mysql-local:1.0.0

# Push образ додатку
docker push <username>/todoapp:2.0.0
```

## Q: Як завантажити готові образи з Docker Hub?

**A:**
```bash
# Завантажити MySQL образ
docker pull <username>/mysql-local:1.0.0

# Завантажити образ додатку
docker pull <username>/todoapp:2.0.0
```

## Q: Як створити мережу для контейнерів?

**A:**
```bash
docker network create todonet
```

## Q: Як запустити MySQL контейнер з об'ємом?

**A:**
```bash
docker run -d --network todonet --name my-mysql -v my-mysql-data:/var/lib/mysql <username>/mysql-local:1.0.0
```

## Q: Як запустити додаток, який підключається до MySQL?

**A:**
```bash
docker run -d --network todonet --name todoapp -p 8000:8000 -e MYSQL_HOST=my-mysql <username>/todoapp:2.0.0
```

## Q: Як відкрити додаток у браузері?

**A:** Перейдіть за адресою: **http://localhost:8000**

## Q: Як перевірити, що все працює?

**A:** 
```bash
docker ps
docker logs my-mysql
docker logs todoapp
```

## Q: Що робити, якщо збирали локально без імені користувача?

**A:** Використайте docker tag:
```bash
docker tag mysql-local:1.0.0 <username>/mysql-local:1.0.0
docker tag todoapp:2.0.0 <username>/todoapp:2.0.0
```

## Q: Як зупинити все?

**A:**
```bash
docker stop todoapp my-mysql
docker rm todoapp my-mysql
docker network rm todonet
```

## Q: Що робити, якщо не працює?

**A:** 
1. Перевірте статус: `docker ps`
2. Подивіться логи: `docker logs todoapp`
3. Переконайтеся, що MySQL запущений: `docker logs my-mysql`
4. Перевірте мережу: `docker network ls`