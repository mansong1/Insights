FROM centos:centos7
LABEL maintainer="Martin Ansong"
LABEL name="PlatformEngine"

WORKDIR /opt

# /dev/urandom is used as random source, which is prefectly safe
# according to http://www.2uo.de/myths-about-urandom/
RUN yum -y update && \
    yum -y upgrade && \ 
    yum install -y wget unzip java-1.8.0-openjdk java-1.8.0-openjdk-devel && \
    echo "securerandom.source=file:/dev/urandom" >> /usr/lib/jvm/jre/lib/security/java.security && \
    yum clean all

RUN mkdir /usr/INSIGHTS_HOME /opt/insightsengine/

ENV JAVA_HOME /etc/alternatives/jre
ENV INSIGHTS_HOME /usr/INSIGHTS_HOME

WORKDIR /opt/insightsengine/
COPY PlatformEngine.jar /opt/insightsengine/PlatformEngine.jar
RUN chmod -R 755 /opt/insightsengine/

WORKDIR /
ENTRYPOINT [ "/usr/bin/java", "-jar", "/opt/insightsengine/PlatformEngine.jar"]