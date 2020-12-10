FROM jenkins-casc:latest
ARG PROXY_HOST=
ARG PROXY_PORT=
ARG JENKINS_FOOTER_URL=
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false -Dhudson.footerURL=${JENKINS_FOOTER_URL} -Dhttp.proxyPort=${PROXY_PORT} -Dhttps.proxyHost=${PROXY_HOST} -Dhttps.proxyPort=${PROXY_PORT}
ENV https_proxy=${PROXY_HOST}:${PROXY_PORT}
ENV http_proxy=${PROXY_HOST}:${PROXY_PORT}
ENV CASC_JENKINS_CONFIG /home/jenkins/casc.yaml
USER root
COPY casc.yaml /home/jenkins/casc.yaml
RUN  chmod 777 /tmp; chown jenkins:jenkins /home/jenkins/casc.yaml && chmod 755 /home/jenkins/casc.yaml
USER jenkins
