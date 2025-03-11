1. To run MySQL container use command:<br>
`Docker run --name <container-name> -d -v <volume-name>:/var/lib/mysql gasterlab/mysql-local:1.0.0`<br>
`--name <container-name>` - change this<br>
`-d` - is detached from current terminal<br>
`-v` - change to your volume name. And after ':' it sets db folder data for a volume<br>
last argument - image name to create from
2. Run python app using command:<br>
`Docker run --name <container-name> -p <host-port>:8080 -d gasterlab/todoapp:2.0.0`<br>
`--name <container-name>` - change this<br>
`-d` - is detached from current terminal<br>
`-p <host-port>` - change your host port to your needs<br>
This command will run python app and automatically connect to the mysql database
3. [Link to todoapp docker repository](https://hub.docker.com/repository/docker/gasterlab/todoapp/)
4. [Link to mysql-local docker repository](https://hub.docker.com/repository/docker/gasterlab/mysql-local/)
5. Use <host-ip>:<host-port> to connect to the website where:<br>
`<host-ip>` - can be your `localhost` or public IP, or cloud IP<br>
`<host-port>` - is your port when you created todoapp container with mapped ports
