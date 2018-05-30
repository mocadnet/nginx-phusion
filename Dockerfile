FROM phusion/baseimage:latest

MAINTAINER Eduardo Pires <mocadnet@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

EXPOSE 80
EXPOSE 443

RUN apt-get -y update && \
apt-get -y install nginx net-tools && \
apt-get -y upgrade

# cert-bot requirements
RUN apt-get -y install wget python virtualenv binutils cpp make autoconf automake libtool bison python-virtualenv python-dev libpython2.7-dev python2.7-dev libpython-dev python-setuptools augeas-tools libffi-dev libssl-dev zlib1g-dev

RUN rm /etc/nginx/sites-enabled/default
ADD sites-enabled/ /etc/nginx/sites-enabled

# setup the nginx script
RUN mkdir /etc/service/nginx
COPY nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

RUN wget https://dl.eff.org/certbot-auto && \
chmod a+x certbot-auto

#RUN ./certbot-auto --nginx

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
