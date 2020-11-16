FROM centos:centos7
LABEL maintainer="Martin Ansong" \
      Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40


RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y upgrade && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

# Simple startup script to avoid some issues observed with container restart
ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]