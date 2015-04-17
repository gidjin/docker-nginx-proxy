FROM debian:jessie
MAINTAINER John Gedeon <js1@gedeons.com>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
    apt-get -y install apt-utils &&\
    apt-get -y upgrade &&\
    apt-get -y install nginx-light ruby git golang &&\
    gem install bundler

ENV HOME=/root
ENV GOPATH=/root/gopath
ENV PATH=/root/gopath/bin:$PATH
RUN go get github.com/tools/godep
RUN go get github.com/kelseyhightower/confd
RUN bash -c "cd /root/gopath/src/github.com/kelseyhightower/confd && ./build && ./install"


# update config
# EXPOSE 80
# 
# # Setup nginx x to run.
# RUN service nginx start
# 
# # Setup script to genereate nginx configs
# RUN mkdir -p /usr/local/lib/site_ruby
# RUN mkdir -p /usr/local/bin
# RUN mkdir -p /usr/local/templates
# COPY site.rb /usr/local/lib/site_ruby/site.rb
# COPY env_reader.rb /usr/local/bin/env_reader.rb
# RUN chmod 755 /usr/local/bin/env_reader.rb
# COPY nginx.conf.erb /usr/local/templates/nginx.conf.erb
