#!/bin/bash

WEBSITE80_PATH="/home/website/default/"
     LOGS_PATH="/home/logs/"
     CONF_PATH="/home/config/"
     SSH_PATH="/root/.ssh/"


# Create base dir
mkdir -p $WEBSITE80_PATH
mkdir -p $LOGS_PATH
mkdir -p $CONF_PATH
mkdir -p $SSH_PATH


# Copy default website80 files
if [ "`ls -A $WEBSITE80_PATH`" = "" ]; then
  \cp -fr /opt/docker/website/default/* $WEBSITE80_PATH
fi


# Copy default log files
if [ "`ls -A $LOGS_PATH`" = "" ]; then
  \cp -fr  /opt/docker/logs/* $LOGS_PATH
fi


# Copy default config files
if [ "`ls -A $CONF_PATH`" = "" ]; then
  \cp -fr /opt/docker/config/* $CONF_PATH
fi


# Cover profile nginx
\cp -fr ${CONF_PATH}php.ini /etc/php.ini
\cp -fr ${CONF_PATH}nginx/nginx.conf /etc/nginx/nginx.conf
\cp -fr ${CONF_PATH}nginx/plugins/*.conf /etc/nginx/plugins/
rm -rf /etc/nginx/sites-enabled/*
\cp -fr ${CONF_PATH}virtualhost/*.conf /etc/nginx/sites-enabled/


# Cover profile ssh key
if [ -f "${CONF_PATH}ssh-key/id_rsa.pub" ]; then
  \cp -fr ${CONF_PATH}ssh-key/id_rsa.pub /root/.ssh/
fi

if [ -f "${CONF_PATH}ssh-key/id_rsa" ]; then
  \cp -fr ${CONF_PATH}ssh-key/id_rsa /root/.ssh/
  chmod 400 /root/.ssh/id_rsa
fi


# Cover profile supervisor
\cp -fr ${CONF_PATH}supervisord.conf /etc/supervisord.conf


# Cover profile crontab
crontab ${CONF_PATH}crontab


# Check Service to start
for SERVICE in nginx php-fpm sshd crond
do
  if ps ax | grep -v grep | grep $SERVICE > /dev/null
  then
     #echo "service $SERVICE runing";
     break;
  else
     service $SERVICE start;
  fi
done


# Check Supervisor to start
if ps ax | grep -v grep | grep /etc/supervisord.conf > /dev/null
then
     RESULT="TRUE"
else
     #echo "starting...";
     supervisord -c /etc/supervisord.conf;
fi

