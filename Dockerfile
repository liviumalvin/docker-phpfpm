FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y php5-fpm


#disable cgi.fix_pathinfo
RUN sed --silent -i.backup 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/i' /etc/php5/fpm/php.ini && cat /etc/php5/fpm/php.ini
RUN service php5-fpm reload


RUN apt-get install -y  make php5-dev php5-mysql php5-curl php5-gd php5-imap php5-tidy php5-json php5-mcrypt php5-redis php5-mongo php5-mysql php5-ldap
RUN apt-get -y install php5-memcache php5-xcache libpcre3-dev

RUN pecl install oauth
RUN echo "extension=oauth.so" > /etc/php5/fpm/conf.d/oauth.ini
RUN service php5-fpm restart

#enable mcrypt
RUN php5enmod mcrypt && service php5-fpm restart

#EXPOSE 9000

#run FPM
#CMD ["php5-fpm", "-F"]