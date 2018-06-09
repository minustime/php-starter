# PHP Container

Boilerplate setup to run an Apache + PHP project

_not suitable for production_

## Requirements

Docker

## Setup

1. Drop your PHP project in the `www` folder
2. Update `docker/apache/vhost.conf` to your project needs
3. Run the docker container `$ make up`

To bring down the container, run: `$ make down`

## Test

1. Your site should be available at `http://localhost:8080`

