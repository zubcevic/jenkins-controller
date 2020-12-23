# Container scan of Jenkins image

This scan can be done on a machine which has the jenkins controller image which is described in the main README.md.

## Start Clair vulnerability database as docker container

    docker run -p 5432:5432 -d --name db arminc/clair-db:latest

## Start Clair application as docker container with a link to the docker database

    docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan:latest

## Download the local clair scanner 
In the example the native local clair scanner for Intel based MacOS.

    curl -L https://github.com/arminc/clair-scanner/releases/download/v12/clair-scanner_darwin_amd64 -o clair-scanner
    chmod u+x clair-scanner

## Scan the existing image

    ./clair-scanner -w whitelist.yaml --ip host.docker.internal --clair="http://127.0.0.1:6060" -t High --reportAll=false jenkins-casc:latest

host.docker.internal can also be replaced by an IP address of the host machine that is reachable from inside the clair container.


