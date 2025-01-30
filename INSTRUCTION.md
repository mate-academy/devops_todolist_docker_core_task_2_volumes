# Інструкція з розгортання

## Запуск MySQL контейнера
1. Завантажте образ: docker pull zhlobinskakateryna/mysql-local:1.0.0
2. Запустіть MySQL контейнер: docker run -e MYSQL_ROOT_PASSWORD=1234 -e MYSQL_PASSWORD=1234 -d --name mysql-container -p 3306:3306 -v mysql-data:/var/lib/mysql zhlobinskakateryna/mysql-local:1.0.0 
** Примітка - вкажіть MYSQL_ROOT_PASSWORD та MYSQL_PASSWORD, заначені в команді наведені для прикладу**

## Запуск App-застосунку
1. Завантажте образ: docker pull zhlobinskakateryna/todoapp:2.0.0
2. Запустіть застосунок: docker run -d --name todoapp -p 8000:8000 zhlobinskakateryna/todoapp:2.0.0
3. Відкрийте у браузері: http://localhost:8000