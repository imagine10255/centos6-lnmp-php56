#!/bin/bash

WEBSITE80_PATH="/home/website/default"
     LOGS_PATH="/home/logs"
     CONF_PATH="/home/config"
     SSH_PATH="/root/.ssh"


# Check Service to start
function service_start()
{
    for SERVICE in nginx php-fpm sshd
    do
      if ! (ps ax | grep -v grep | grep $SERVICE > /dev/null)
      then
         service $SERVICE start;
      fi
    done
}


# Check Supervisor to start
function service_supervisor()
{
    if ps ax | grep -v grep | grep /etc/supervisord.conf > /dev/null
    then
        RESULT="TRUE"
    else
        #echo "starting...";
        supervisord -c /etc/supervisord.conf;
    fi
}



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
\cp -fr ${CONF_PATH}/php-fpm/php.ini /etc/php.ini
\cp -fr ${CONF_PATH}/php-fpm/www.conf /etc/php-fpm.d/www.conf 
\cp -fr ${CONF_PATH}/nginx/nginx.conf /etc/nginx/nginx.conf
\cp -fr ${CONF_PATH}/nginx/sites-include/*.conf /etc/nginx/sites-include/
rm -rf /etc/nginx/sites-enabled/*
\cp -fr ${CONF_PATH}/nginx/sites-enabled/*.conf /etc/nginx/sites-enabled/


# Cover profile ssh key
if [ -f "${CONF_PATH}/ssh-key/id_rsa.pub" ]; then
  \cp -fr ${CONF_PATH}/ssh-key/id_rsa.pub /root/.ssh/
fi

if [ -f "${CONF_PATH}/ssh-key/id_rsa" ]; then
  \cp -fr ${CONF_PATH}/ssh-key/id_rsa /root/.ssh/
  chmod 400 /root/.ssh/id_rsa
fi

# Setting SSH Password By ENV
#echo "${SSH_PASSWORD}" | passwd "root" --stdin

# Cover profile supervisor
\cp -fr ${CONF_PATH}/supervisord.conf /etc/supervisord.conf

service_start
