# INSTRUCTION.md

## 1. Створення мережі Docker (один раз)
```powershell
docker network create todo-net

docker run -d `
  --name mysql-local `
  --network todo-net `
  -v ${env:USERPROFILE}\mysql-data:/var/lib/mysql `
  -e MYSQL_ROOT_PASSWORD=rootpass `
  -e MYSQL_DATABASE=app_db `
  -e MYSQL_USER=app_user `
  -e MYSQL_PASSWORD=1234 `
  -p 3306:3306 `
  olexandrkv/mysql-local-public:1.0.0


docker run -d `
  --name todoapp `
  --network todo-net `
  -e DB_HOST=mysql-local `
  -p 8000:8080 `
  olexandrkv/todoapp-public:2.0.0

https://hub.docker.com/r/olexandrkv/todoapp-public
https://hub.docker.com/r/olexandrkv/mysql-local-public

Відкрийте браузер і перейдіть за адресою:
http://localhost:8000