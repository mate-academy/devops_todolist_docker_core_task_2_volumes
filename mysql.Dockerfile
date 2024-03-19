FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=1234
ENV MYSQL_DATABASE=app_db
ENV MYSQL_USER=app_user
ENV MYSQL_PASSWORD=1234

EXPOSE 3306

VOLUME /var/lib/mysql

COPY init.sql /docker-entrypoint-initdb.d/
