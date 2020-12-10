#!/bin/bash

#docker build . -f Dockerfile-casc -t jenkins-casc
#docker build . -f Dockerfile -t jenkins-controller  --build-arg JENKINS_FOOTER_URL=https://www.zubcevic.com
docker run -d -p 8080:8080 -e JENKINS_HOME_URL=http://localhost:8080 -e JENKINS_ADMIN_USER=admin -e JENKINS_ADMIN_PASSWORD=admin --name jenkins jenkins-controller
