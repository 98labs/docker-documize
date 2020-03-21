# docker-documize

## Build a Docker image from the source

1.0 Download the source
```
git clone git@github.com:98labs/docker-documize.git &&  cd docker-documize
```

2.0 Build the Docker image
```
docker build -t 98labs/documize:3.7.0 -t 98labs/documize:latest .
```

## Run the container via docker-compose

1.0 Create host volume for your PostgreSQL database
```
mkdir -p ~/srv/documize/postgresql/data/
```

2.0 Setup the configuration file

2.1 Edit the configuration file with the correct database info
```
vi config.conf
```
Here's a sample content of the configuration file:
```
[http]
port = 3000
#forcesslport = 433
#cert = "selfcert/cert.pem"
#key = "selfcert/key.pem"

[database]
type = "postgresql"
connection = "host=db port=5432 sslmode=disable user=documize password=Ur*Xtr0ng*Passw0rd dbname=documizedb"

# https://docs.documize.com/s/VzO9ZqMOCgABGyfW/installation-guides/d/V16L08ucxwABhZF6/installation-guide
# If you do not provide a salt, Documize will generate a random secret and display what it is.
# Copy the secret and use on subsequent Documize server restarts.
# salt = "tsu3Acndky8cdTNx3"

[install]
location = "selfhost"
```


2.2 Edit docker-compose.yml
Inspect the docker-compose.yml file.
```
version: "3.7"
services:

  db:
    container_name: documizedb
    image: postgres:9-alpine
    environment:
      POSTGRES_DB: documizedb
      POSTGRES_PASSWORD: Ur*Xtr0ng*Passw0rd
      POSTGRES_USER: documize
    volumes:
      - ~/srv/documize/postgresql/data/:/var/lib/postgresql/data/

  documize:
    container_name: documize
    image: 98labs/documize:3.7.0
    depends_on:
      - db
    volumes:
      - ~/srv/documize/config.conf:/app/config.conf
    ports:
      - "3000:3000"
```

Specify the location of the configuration file. In the example above, the configuration is mounted from
```
~/srv/documize/config.conf
```
Make sure the configuration file is available at the correct location.

3.0 Start the service
```
docker-compose up
```
If you want to run the application as a background process, run
```
docker-compose up -d
```

## Cleanup

Stop the service
```
docker-compose down
```
