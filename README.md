# docker-documize

## Build a Docker image from the source

1.0 Download the source
```
git clone git@github.com:98labs/docker-documize.git &&  cd docker-documize
```

1.1 Copy a sample configuration file from config-example.conf 
```
mv config-example.conf config.conf
```

1.2 Build the Docker image
```
docker build -t organization/documize .
```

## Run the container via docker-compose

1.0 Create host volume for your PostgreSQL database
```
mkdir -p ~/srv/documize/postgresql/data/
```

2.0 Setup the configuration file

2.1 Edit the configuration file with the database info
```
vi config.conf
```

2.2 Edit docker-compose.yml

Specify the location of config.conf. In the docker-compose example, the configuration is mounted from
```
~/srv/documize/config.conf
```

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
