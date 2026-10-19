# Run the Todo application with MySQL

App image repository: [lyutikmm/todoapp on Docker Hub](https://hub.docker.com/r/lyutikmm/todoapp).

Images used:

- `lyutikmm/mysql-local:1.0.0`
- `lyutikmm/todoapp:2.0.0`

## Prerequisites

- Docker is installed and running with Linux containers enabled.
- Ports `3306` and `8080` are available on localhost.
- Run commands from this repository's root directory if building images locally.
- The images must be published to Docker Hub before pulling them. For a private repository, run `docker login -u lyutikmm` first.

On Windows, if `docker` is not recognized and Docker Desktop is installed in your local Programs directory, add its CLI directory to the current PowerShell session:

```powershell
$env:Path = "$env:LOCALAPPDATA\Programs\DockerDesktop\resources\bin;$env:Path"
```

## 1. Download the images

```powershell
docker pull lyutikmm/mysql-local:1.0.0
docker pull lyutikmm/todoapp:2.0.0
```

## 2. Start MySQL with a persistent volume

```powershell
docker volume create mysql_data
docker run -d --name mysql-local --network bridge -p 127.0.0.1:3306:3306 --mount type=volume,source=mysql_data,target=/var/lib/mysql lyutikmm/mysql-local:1.0.0
```

The named volume `mysql_data` stores database files at `/var/lib/mysql`. Reuse this volume when recreating the database container to retain its data.

On the first startup with an empty volume, the image creates:

- Database: `app_db`
- User: `app_user`
- Password: `1234`
- Root password: `1234`

An existing database volume retains its previous database and credentials; initialization variables do not reset them.

Check the logs and wait for the final MySQL server to report `ready for connections` on port `3306`:

```powershell
docker logs --tail 40 mysql-local
```

If a container named `mysql-local` already exists, use `docker start mysql-local` instead of creating it again. Check that it uses the expected volume:

```powershell
docker inspect mysql-local --format '{{json .Mounts}}'
```

## 3. Check the database IP and connection

Both containers use Docker's default `bridge` network. Check the MySQL container's IP:

```powershell
docker inspect mysql-local --format '{{.NetworkSettings.Networks.bridge.IPAddress}}'
```

The current app configuration in `todolist/settings.py` expects:

```python
'HOST': '172.17.0.2',
```

Use only the IP address, without `/16`. Docker may assign a different IP after a container is recreated. If the address differs, update `HOST` in `todolist/settings.py`, then build the app image from the repository root:

```powershell
docker build -f Dockerfile -t lyutikmm/todoapp:2.0.0 .
```

MySQL must be ready before this build because the current Dockerfile runs `python manage.py migrate` during the build. Rebuild the image after changing settings; an existing image keeps its original configuration.

Verify that the database and user are available:

```powershell
docker exec -it mysql-local mysql -uapp_user -p -D app_db -e 'SELECT DATABASE(), CURRENT_USER();'
```

Enter `1234` at the password prompt. The result should contain `app_db` and `app_user@%`.

## 4. Apply migrations and start the app

Apply migrations to the current database, including when using a fresh volume with the downloaded app image:

```powershell
docker run --rm --network bridge --entrypoint python lyutikmm/todoapp:2.0.0 manage.py migrate
```

After migrations finish successfully, start the app:

```powershell
docker run -d --name todoapp --network bridge -p 127.0.0.1:8080:8080 lyutikmm/todoapp:2.0.0
```

The app connects to MySQL at the configured container IP on port `3306` using `app_db`, `app_user`, and password `1234`.

If the app container already exists and its image/configuration is still current, use `docker start todoapp` instead of creating it again. A rebuilt image requires recreating the app container to use the new image.

Check the running containers and application logs:

```powershell
docker ps
docker logs -f todoapp
```

Press `Ctrl+C` to stop following logs; this leaves the container running.

## 5. Open the application

Open [http://localhost:8080](http://localhost:8080) in your browser.

The API is available at [http://localhost:8080/api/](http://localhost:8080/api/).
