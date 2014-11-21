FROM phusion/passenger-ruby21:0.9.14
MAINTAINER John Gedeon <js1@gedeons.com>

EXPOSE 80

# Setup nginx x to run.
RUN rm -f /etc/service/nginx/down

# Setup script to genereate nginx configs
RUN mkdir -p /usr/local/lib/site_ruby
RUN mkdir -p /etc/my_init.d
COPY site.rb /usr/local/lib/site_ruby/site.rb
COPY env_reader.rb /etc/my_init.d/env_reader.rb
RUN chmod 755 /etc/my_init.d/env_reader.rb
COPY nginx.conf.erb /templates/nginx.conf.erb
