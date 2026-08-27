
## Docker Hub Repositories
* App Image: [https://hub.docker.com/r/baga56789/todoapp](https://hub.docker.com/r/baga56789/todoapp)
* MySQL Image: [https://hub.docker.com/r/baga56789/mysql-local](https://hub.docker.com/r/baga56789/mysql-local)


To start the database container with a persistent volume attached, run:
`docker run -d --name my_db -p 3307:3306 -v db_data:/var/lib/mysql baga56789/mysql-local:1.0.0`


First, ensure you have updated the `HOST` in `settings.py` with the IP address of your running MySQL container (check via `docker network inspect bridge`). Then run:
`docker run -d --name my_app -p 8080:8080 baga56789/todoapp:2.0.0`


Once the app container is running, open your web browser and navigate to:
[http://localhost:8080](http://localhost:8080)
