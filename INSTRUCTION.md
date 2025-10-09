# TodoList Application - Прості інструкції

## Q: Як запустити MySQL контейнер з об'ємом?

**A:** Виконайте цю команду:

```bash
docker run -d -p 3306:3306 --name my-mysql -v my-mysql-data:/var/lib/mysql mysql-local:1.0.0
```

## Q: Як перевірити, що MySQL працює?

**A:** 
```bash
docker ps
docker logs my-mysql
```

## Q: Як запустити додаток, який підключається до MySQL?

**A:** Спочатку знайдіть IP MySQL контейнера:
```bash
docker inspect my-mysql | grep IPAddress
```

Потім запустіть додаток:
```bash
docker run -d --name todolist-app -p 8080:8080 --link my-mysql:mysql todolist-app:latest
```

## Q: Як зібрати образ додатку?

**A:**
```bash
docker build -t todolist-app:latest .
```

## Q: Де знайти готовий образ на Docker Hub?

**A:** https://hub.docker.com/r/[ВАШЕ_ІМ'Я]/todolist-app

Або встановити:
```bash
docker pull [ВАШЕ_ІМ'Я]/todolist-app:latest
```

## Q: Як відкрити додаток у браузері?

**A:** Перейдіть за адресою: **http://localhost:8080**

## Q: Як зупинити все?

**A:**
```bash
docker stop todolist-app my-mysql
docker rm todolist-app my-mysql
```

## Q: Що робити, якщо не працює?

**A:** 
1. Перевірте статус: `docker ps`
2. Подивіться логи: `docker logs todolist-app`
3. Переконайтеся, що MySQL запущений: `docker logs my-mysql`