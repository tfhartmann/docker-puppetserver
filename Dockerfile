# Install Puppet Server
FROM centos:centos7
MAINTAINER Tim Hartmann <tfhartmann@gmail.com>

RUN yum install epel-release -y && yum install http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm -y && yum install puppetserver -y

ADD conf/puppetserver /etc/sysconfig/puppetserver

ENV PUPPETSERVER_JAVA_ARGS="-Xms512m -Xmx512m"

# Expose Puppet Master port
EXPOSE 8140

# Run Puppet Server
CMD [ "/usr/bin/puppetserver", "foreground" ]

