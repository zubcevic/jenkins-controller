#!/bin/bash

docker stack deploy --compose-file docker-compose.yml openldap

#docker stack rm openldap
