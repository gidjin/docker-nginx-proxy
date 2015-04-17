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
# ENV ETCD_ENDPOINT="$(ifconfig docker0 | awk '/\<inet\>/ { print $2}'):4001"
RUN go get github.com/tools/godep
RUN go get github.com/kelseyhightower/confd
RUN bash -c "cd /root/gopath/src/github.com/kelseyhightower/confd && ./build && ./install && mkdir -p /etc/confd/{conf.d,templates}"
COPY nginx_app_proxy.toml /etc/confd/conf.d/
COPY nginx_app_proxy.conf.tmpl /etc/confd/templates/
# RUN confd -onetime -backend etcd -node 10.1.42.1:4001

RUN apt-get clean &&\
    rm -rf /tmp/* /var/tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

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
