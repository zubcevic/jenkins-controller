#!/bin/bash

export SSH_PK=$(cat ~/.ssh/id_rsa)

docker rm -f jenkins
#docker build --build-arg JENKINS_FOOTER_URL="https://www.zubcevic.com" -t renezubcevic/jenkins-controller:latest -f Dockerfile .

docker run -d --name jenkins -v /var/run/docker.sock:/var/run/docker.sock -e JENKINS_HOST_URL="http://localhost:8080" -e JENKINS_ADMIN_USER=admin -e JENKINS_ADMIN_PASSWORD="password" -e GITHUB_USER="rene@zubcevic.com" -e JENKINS_ADMIN_EMAIL="rene@zubcevic.com" -e GITHUB_PK="${SSH_PK}" -p 8080:8080 -p 50000:50000 renezubcevic/jenkins-controller:latest
