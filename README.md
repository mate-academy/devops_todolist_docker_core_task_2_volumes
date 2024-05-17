1. **I added mysql-connector-python==8.2.0 to requirements.txt**
2. **Created Dockerfile.mysql**

    ```python
    ARG MYSQL_VERSION=8.0.37-bookworm   # used argument to develop a good practice
    FROM mysql:${MYSQL_VERSION}         # base image MYSQL

    ENV MYSQL_DATABASE=app_db           # the databse to be initialized will have name app_db
    ENV MYSQL_USER=app_user             # the databse to be initialized will have user_name app_user
    ENV MYSQL_PASSWORD=1234             # the databse to be initialized will have password 1234
    ENV MYSQL_ROOT_PASSWORD=1234        # this line is here as per advise of official docker mysql documentation (https://hub.docker.com/_/mysql):
                                        ## """ 
                                        ## MYSQL_ROOT_PASSWORD -- This variable is mandatory and specifies 
                                        ## the password that will be set for the MySQL root superuser account. 
                                        ## """

    VOLUME /var/lib/mysql               # this line is not mandatory - it is here to EXPOSE for others the default location of MYSQL in a container

    EXPOSE 3306                         # this line is not mandatory - it is here to EXPOSE for others the port of container
    ```
3. **I run the command** `docker build . -t mysql-local:1.0.0 -f Dockerfile.mysql`  **, where:**

    * `docker build` is command for image creation
    * `. ` is context location
    * `-t` parameter for specifying the custom image name
    * `mysql-local:1.0.0` is image to be created name and tag (as required in the task)
    * `-f` parameter for specifyin the custom dockerfile name
    * `Dockerfile.mysql` dockerfile name
4. **I run the command** `docker run -d -p 3306:3306 --name mysql_container -v mysql_volume:/var/lib/mysql mysql-local:1.0.0`, where

    *on the attached screenshot the sequence is a bit different, but here is a proper one in order to get the database IP before building the app container
    (on the screenshot I already knew the IP to be given in advance)*

    * `docker run` is a command to create and run a container
    * `-d` parameter to run in `--detached` mode in order to continue in the current terminal avoiding the container logs stdout
    * `-p` port mapping parameter (used default MySQL port) *if not specified it will run on 33060 and our app will not see the database*
    * `--name` to specify the custom container name
    * `mysql_container` custom container name
    * `-v` parameter to specify the volume and it's corresponding data inside the container
    * `mysql_volume` in our case such docker volume not yet exists - it is to be created upon the command run
    * `:/var/lib/mysql` the default location of MYSQL in a container
    * `mysql-local:1.0.0` name and tag of the container to be created (as required in the task)
5. **I opened another terminal in order not to flood current one and run the following commands:**

    * `docker container list -a`
    * `docker container details {docker_database_container_id}`
    * noted the value of `NetworkSettings["IPAddress"]`
6. **I added code**

    ```python
    DATABASES = {
          'default': {
              'ENGINE': 'mysql.connector.django',   # ¯\_(ツ)_/¯ 
              'NAME': 'app_db',                     # reference to the initialized database name
              'USER': 'app_user',                   # reference to the initialized database login
              'PASSWORD': '1234',                   # reference to the initialized database pass
              'HOST': '172.17.0.2',                 # this ip-address we have got through the following sequence:
                                                    #   1) We have built the database container
                                                    #   2) We have started the database container
                                                    #   3) We executed command "docker container details {database_container_id}"
                                                    #   4) searched for NetworkSettings["IPAddress"]
              'PORT': '',                           # Left this empty to use the default MySQL port (3306).
          }
      }
    ```

     -> into todolist/settings.py
7. **I run the command** `docker build . -t todoapp:2.0.0 -f Dockerfile` , where:

    * `docker build` is command for image creation
    * `. ` is context location
    * `-t` parameter for specifying the custom image name
    * `todoapp:2.0.0` is image to be created name and tag (as required in the task)
    * `-f` parameter for specifyin the custom dockerfile name
    * `Dockerfile` dockerfile name
8. **I run the command** `docker run -d -p 8081:8080 --name app_container todoapp:2.0.0`, where

    * `docker run` is a command to create and run a container
    * `-d` parameter to run in `--detached` mode in order to continue in the current terminal avoiding the container logs stdout
    * `-p` port mapping parameter 8081 is for easier defing as a first container, 8080 is local container port
    * `--name` to specify the custom container name
    * `app_container` custom container name
    * `todoapp:2.0.0` name and tag of the container to be created (as required in the task)
9. **I run the command** `docker run -d -p 8082:8080 --name app_container_2 todoapp:2.0.0`, where

    * `8082`is for easier defing as a second container
    * `app_container_2` is second container name
10. **I accessed the application containers via http://127.0.0.1:8081(8082)/ to check if app is working properly with external database**
11. **You can find the images by the https://hub.docker.com/repository/docker/yegorv/mysql-local/general link**