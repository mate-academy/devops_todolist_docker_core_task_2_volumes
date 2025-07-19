# ✅ Django ToDo App з MySQL (Docker)

Цей проєкт розгортає Django-застосунок з підключенням до MySQL бази даних через два окремі Docker-образи.

---

## 🐳 Образи в Docker Hub

- MySQL: [`vitalysemeniv/mysql-local:1.0.0`](https://hub.docker.com/r/vitalysemeniv/mysql-local)
- Django: [`vitalysemeniv/todoapp:2.0.2`](https://hub.docker.com/r/vitalysemeniv/todoapp)

---

## 🔨 1. Build Docker-образи (опціонально, якщо немає Docker Hub)

### MySQL

```bash
docker build -t mysql-local:1.0.0 -f Dockerfile.mysql .
