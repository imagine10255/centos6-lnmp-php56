#!/bin/bash

WEBSITE80_PATH="/home/wwwroot/website80/"
     LOGS_PATH="/home/wwwlogs/"
     CONF_PATH="/home/wwwconfig/"


# Create base dir
mkdir -p $WEBSITE80_PATH
mkdir -p $LOGS_PATH
mkdir -p $CONF_PATH


# Copy default website80 files
if [ "`ls -A $WEBSITE80_PATH`" = "" ]; then
  \cp -fr /opt/docker/wwwroot/website80/* $WEBSITE80_PATH
fi


# Copy default log files
if [ "`ls -A $LOGS_PATH`" = "" ]; then
  \cp -fr  /opt/docker/wwwlogs/* $LOGS_PATH
fi


# Copy default config files
if [ "`ls -A $CONF_PATH`" = "" ]; then
  \cp -fr /opt/docker/wwwconfig/* $CONF_PATH
fi


# Cover profile
\cp -fr /home/wwwconfig/php.ini /etc/php.ini
\cp -fr /home/wwwconfig/nginx/nginx.conf /etc/nginx/nginx.conf
\cp -fr /home/wwwconfig/nginx/plugins/*.conf /etc/nginx/plugins/
\cp -fr /home/wwwconfig/virtualhost/*.conf /etc/nginx/sites-enabled/


# Check Service to start
for SERVICE in nginx php-fpm
do
  if ps ax | grep -v grep | grep $SERVICE > /dev/null
  then
     #echo "service $SERVICE runing";
     break;
  else
     service $SERVICE start;
  fi
done

