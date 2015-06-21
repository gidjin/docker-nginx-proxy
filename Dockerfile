FROM nginx:latest
MAINTAINER John Gedeon <js1@gedeons.com>

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
#     apt-get -y upgrade &&\
    apt-get -y install git golang wget

USER root
ENV HOME=/root
WORKDIR /root
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.9.0/confd-0.9.0-linux-amd64
RUN mv confd-0.9.0-linux-amd64 /usr/local/bin/confd && chmod 755 /usr/local/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}

RUN apt-get clean &&\
    rm -rf /tmp/* /var/tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

COPY nginx.toml /etc/confd/conf.d/
COPY nginx.conf.tmpl /etc/confd/templates/
COPY start-up.sh /usr/local/bin/start-up.sh
RUN chmod 755 /usr/local/bin/start-up.sh

CMD ["start-up.sh"]
