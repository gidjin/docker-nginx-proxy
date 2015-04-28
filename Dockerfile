FROM gidjin/nginx:latest
MAINTAINER John Gedeon <js1@gedeons.com>

COPY nginx.toml /etc/confd/conf.d/
COPY nginx.conf.tmpl /etc/confd/templates/
COPY start-up.sh /usr/local/bin/start-up.sh
RUN chmod 755 /usr/local/bin/start-up.sh

# Setup nginx and confd to run.
CMD ["start-up.sh"]
