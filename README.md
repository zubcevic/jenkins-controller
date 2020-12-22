# jenkins-controller
Jenkins controller container image based on configuration as code

## Configuration file

The Jenkins configuration is stored in **casc.yaml**

## Running the Jenkins Controller

Example of how to run in docker:

    docker run -d --name jenkins -e JENKINS_HOST_URL="http://localhost:8080" -e JENKINS_ADMIN_USER=admin -e JENKINS_ADMIN_PASSWORD="password" -e GITHUB_USER="rene@zubcevic.com" -e GITHUB_PK="..." -p 8080:8080 -p 50000:50000 renezubcevic/jenkins-controller

## Building local

You can build a local custom version in two steps.

+ build the base image with adjusted plugins

    docker build -t renezubcevic/jenkins-casc -f Dockerfile-casc .

+ build the controller with a custom casc.yaml file and custom footer

    docker build --build-arg JENKINS_FOOTER_URL="https://www.zubcevic.com" -t renezubcevic/jenkins-controller -f Dockerfile .

## Get the Jenkins plugins installed from Groovy script console

    def pluginList = new ArrayList(Jenkins.instance.pluginManager.plugins)
        pluginList.sort {it.getShortName() }.each{
            plugin ->
                println("${plugin.getShortName()}:${plugin.getVersion()}")
        }

## Get the Jenkins plugins installed from CLI client

    curl 'localhost:8080/jnlpJars/jenkins-cli.jar' > jenkins-cli.jar
    java -jar jenkins-cli.jar -s http://admin:password@localhost:8080 groovy = < pluginEnumerator.groovy | sort > plugins-installed.txt

## Required plugins

### configuration-as-code
The most essential plugin for configuration as code to work.

### templating-engine
Used in order to test my Jenkins templating engine pipeline. Added here to see how to configure the global settings as code.

### adoptopenjdk
Used to auto install Java SDK from AdoptOpenJDK. Just required for my own sample job.
Referred to in casc.yaml as:

    tool:
      jdk:
        installations:
        - name: "JDK11"
          properties:
          - installSource:
              installers:
              - adoptOpenJdkInstaller:
                  id: "jdk-11.0.9.1+1"

## More info

+ [how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code](https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code)
+ [![Gitter](https://badges.gitter.im/jenkinsci/configuration-as-code-plugin.svg)](https://gitter.im/jenkinsci/configuration-as-code-plugin?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
+ [![Gitter](https://badges.gitter.im/jenkinsci/templating-engine-plugin.svg)](https://gitter.im/jenkinsci/templating-engine-plugin?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)