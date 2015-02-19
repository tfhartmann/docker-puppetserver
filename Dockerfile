# Install Puppet Server
FROM centos:centos6
MAINTAINER Tim Hartmann <tfhartmann@gmail.com>

RUN yum install epel-release -y
RUN yum install http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm -y
RUN yum install puppetserver -y

ADD conf/puppetserver /etc/sysconfig/puppetserver

#env   HUBOT_HIPCHAT_JID [asdfID]@chat.hipchat.com
#env   HUBOT_HIPCHAT_PASSWORD [your-password]
#env   HUBOT_AUTH_ADMIN [your name]

ENV PUPPETSERVER_JAVA_ARGS="-Xms512m -Xmx512m"


# Expose Puppet Master port
EXPOSE 8140

# Run Puppet Server
CMD /usr/bin/puppetserver foreground

