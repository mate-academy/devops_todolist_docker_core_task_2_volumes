FROM mysql:latest

# Set environment variables for MySQL initialization
ENV MYSQL_DATABASE=app_db \
    MYSQL_USER=app_user \
    MYSQL_PASSWORD=1234 \
    MYSQL_ROOT_PASSWORD=1234

# Expose the MySQL port
EXPOSE 3306

# Create a volume for data persistence
VOLUME /var/lib/mysql

# Set the working directory
WORKDIR /usr/src/app

# Define the entry point
ENTRYPOINT ["docker-entrypoint.sh"]

# CMD to start MySQL server
CMD ["mysqld"]
