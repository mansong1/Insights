FROM centos:centos7
LABEL maintainer="Martin Ansong" \
      name="InsightsUI"

WORKDIR /opt
# /dev/urandom is used as random source, which is prefectly safe
# according to http://www.2uo.de/myths-about-urandom/
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y upgrade && \ 
    yum install -y wget unzip java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security && \
    yum clean all

RUN mkdir /usr/INSIGHTS_HOME
ENV INSIGHTS_HOME /usr/INSIGHTS_HOME

COPY PlatformService.war /opt/PlatformService.war
COPY PlatformUI3.zip /opt/PlatformUI3.zip

WORKDIR /opt/

# Change wget to install apache properly
RUN unzip PlatformUI3.zip && rm -rf PlatformUI3.zip && \
    wget https://infra.cogdevops.com:8443/repository/docroot/insights_install/installationScripts/latest/RHEL/tomcat/apache-tomcat.tar.gz && \
    tar -zxvf apache-tomcat.tar.gz && rm -rf apache-tomcat.tar.gz

WORKDIR /opt/apache-tomcat
RUN cp -r /opt/app /opt/apache-tomcat/webapps/ && cp /opt/PlatformService.war /opt/apache-tomcat/webapps/ && \
    rm -rf /opt/PlatformService.war /opt/app && chmod -R 755 /opt/apache-tomcat/

WORKDIR /
CMD ["/opt/apache-tomcat/bin/startup.sh"]