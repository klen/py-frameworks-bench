FROM phusion/baseimage

MAINTAINER Kirill Klenov <horneds@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && \
    apt-get install nginx-full -y  && \
    apt-get install postgresql-9.3 -y

# Setup nginx service
RUN mkdir /etc/service/nginx
ADD deploy/nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run
RUN echo "server {listen 80; location / { echo 'Hello, World!'; echo_sleep .1; } }" > /etc/nginx/sites-available/default

# Setup postgres service
RUN mkdir /etc/service/postgres
ADD deploy/postgres.sh /etc/service/postgres/run
RUN chmod +x /etc/service/postgres/run && \
    echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
