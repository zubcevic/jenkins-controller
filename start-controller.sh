#!/bin/bash

export SSH_PK=$(cat ~/.ssh/id_rsa)

#Remove any running Jenkins
docker rm -f jenkins

#Build base image from scratch with latest versions of plugins! (Could have breaking changes)
#docker build -t renezubcevic/jenkins-casc -f Dockerfile-casc .
#docker push renezubcevic/jenkins-casc

#Build image with configuration as code
#docker build --build-arg JENKINS_FOOTER_URL="https://www.zubcevic.com" -t renezubcevic/jenkins-controller -f Dockerfile .
#docker push renezubcevic/jenkins-controller

#Run the image
docker run -d --name jenkins -e VAULT_ADDR="http://host.docker.internal:8200" -e JENKINS_VAULT_TOKEN="${VAULT_TOKEN}" -e JENKINS_OPTS="--httpPort=8081" -e JENKINS_HOST_URL="http://127.0.0.1:8081" -e JENKINS_ADMIN_USER=admin -e JENKINS_ADMIN_PASSWORD="password" -e GITHUB_USER="rene@zubcevic.com" -e JENKINS_ADMIN_EMAIL="rene@zubcevic.com" -p 8080:8081 -p 50000:50000 renezubcevic/jenkins-controller:latest

#Export and compare the versions of the plugins in the image
#curl 'localhost:8080/jnlpJars/jenkins-cli.jar' > jenkins-cli.jar
#java -jar jenkins-cli.jar -s http://admin:password@localhost:8080 groovy = < pluginEnumerator.groovy | sort > plugins-installed.txt

#Import the sample job
#JENKINS_CRUMB=$(curl --cookie-jar tmpCookie 'http://admin:password@127.0.0.1:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
#curl --cookie tmpCookie -X POST 'http://admin:password@127.0.0.1:8080/createItem?name=TestMB' -d @jobconfig.xml -H "$JENKINS_CRUMB" -H "Content-Type: text/xml"

#Run the sample job
#curl --cookie tmpCookie -X POST 'http://admin:password@127.0.0.1:8080/job/TestMB/job/develop/build?delay=0' -H "$JENKINS_CRUMB"