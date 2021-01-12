# Jenkins image built with Source To Image

This readme will show how to build a Jenkins Controller from an openshift base image with source to image.

## Install source-to-image on MacOS

    brew install source-to-image

## Build a new image from local directory s2i

    cd s2i
    s2i build . openshift/jenkins-2-centos7 renezubcevic/jenkins-s2i
    docker run --name jenkins-s2i -d -e JENKINS_PASSWORD=password -p 8080:8081 -p 50000:50000 renezubcevic/jenkins-s2i
    
