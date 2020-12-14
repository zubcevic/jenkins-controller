# jenkins-controller
Jenkins controller container image based on configuration as code

## Configuration file

The Jenkins configuration is stored in **casc.yaml**

## Running the Jenkins Controller

Example of how to run in docker:

    docker run -d --name jenkins -e JENKINS_HOST_URL="http://localhost:8080" -e JENKINS_ADMIN_USER=admin -e JENKINS_ADMIN_PASSWORD="password" -p 8080:8080 -p 50000:50000 renezubcevic/jenkins-controller

## Building local

You can build a local custom version in two steps.

+ build the base image with adjusted plugins

    docker build -t renezubcevic/jenkins-casc -f Dockerfile-casc .

+ build the controller with a custom casc.yaml file and custom footer

    docker build --build-arg JENKINS_FOOTER_URL="https://www.zubcevic.com" -t renezubcevic/jenkins-controller -f Dockerfile .

