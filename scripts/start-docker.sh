#!/bin/bash

docker-compose -f production.yml build
docker-compose -f production.yml run --rm django python manage.py migrate
docker-compose -f production.yml up -d
