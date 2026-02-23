Docker HUB repositories to pull: https://hub.docker.com/r/bohn13/todoapp/tags, https://hub.docker.com/r/bohn13/mysql-local/tags

At first, you shall pull two images from docker hub: mysql-local:1.0.0 image and todoapp:2.0.0

At second, after pulling, you must build and launch mysql-local container where all data will be stored, instruction for this:
1. Pull the docker image as mentioned above from repository with volume command.
2. If you want to change the information as password/username etc., you can proceed to the Dockerfile.mysql and there edit it. After, you need to build the image using build command. Example: "docker build . -t mysql-local:1.0.0"
3. Run the image via "docker run -d -p 3306:3306 --name mysql_data -v mysql-data-volume:/var/lib/mysql bohn13/mysql-local:1.0.0"
4. After starting, you can check out if everything works okay using command "docker logs {name of container}". If everything is okay, then proceed.
5. Now you need to get the container IpV4 to connect it with the app. Use command "docker inspect bridge". There find the part named "Container". Find a field called "Ipv4" and copy only address without the "/16" part. Example: "172.17.0.2".
6. After the copying, go to the todoapp file todolist/settings.py. Find there a field called 'HOST' and place there the ip address we copied. Save the file.
7. When you've done all of these instructions, you can proceed to launching the main todoapp image.

At third, you must launch todoapp container:
1. Pull the docker image called todoapp:2.0.0 from the repo.
2. Run the image via "docker run -d -p 8080:8080 bohn13/todoapp:2.0.0 --name todoapp" command;
3. You can check out in logs if it works properly using "docker logs todoapp" command. If everything is okay, you can proceed. If no, check if you've done everything according to this instruction.
4. You can launch the app using your local ipaddress such as "http://127.0.0.1:8080/". # How you can access the website.
5. Enjoy the website!

Note: Migrations are performed during build time because the project uses SQLite.