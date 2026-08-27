## Docker Hub Repositories
* App Image: [https://hub.docker.com/r/baga56789/todoapp](https://hub.docker.com/r/baga56789/todoapp)
* MySQL Image: [https://hub.docker.com/r/baga56789/mysql-local](https://hub.docker.com/r/baga56789/mysql-local)

## 1. Build and Push MySQL Image
`docker build -f Dockerfile.mysql -t baga56789/mysql-local:1.0.0 .`
`docker push baga56789/mysql-local:1.0.0`

## 2. Run MySQL Container with Volume
`docker run -d --name my_db -p 3306:3306 -v mysql-data:/var/lib/mysql baga56789/mysql-local:1.0.0`

## 3. Build and Push App Image
`docker build -t baga56789/todoapp:2.0.0 .`
`docker push baga56789/todoapp:2.0.0`

## 4. Run App Container 
Find your MySQL container IP: `docker network inspect bridge`
Run the app passing the IP as an environment variable (replace <MYSQL_IP> with your actual IP, e.g., 172.17.0.2):
`docker run -d --name my_app -p 8080:8080 -e DB_HOST=<MYSQL_IP> baga56789/todoapp:2.0.0`

## 5. Access the Application
Open your web browser and navigate to: [http://localhost:8080](http://localhost:8080)
