#!/bin/bash

WEBSITE80_PATH="/home/wwwroot/website80/"
     LOGS_PATH="/home/wwwlogs/"
     CONF_PATH="/home/wwwconfig/"

mkdir -p $WEBSITE80_PATH
mkdir -p $LOGS_PATH
mkdir -p $CONF_PATH

if [ "`ls -A $WEBSITE80_PATH`" = "" ]; then
  \cp -fr /home/docker/wwwroot/website80/* $WEBSITE80_PATH
fi

if [ "`ls -A $LOGS_PATH`" = "" ]; then
  \cp -fr  /home/docker/wwwlogs/* $LOGS_PATH
fi

if [ "`ls -A $CONF_PATH`" = "" ]; then
  \cp -fr /home/docker/wwwconfig/* $CONF_PATH
fi


# Cover profile
\cp -fr /home/wwwconfig/php.ini /etc/php.ini
\cp -fr /home/wwwconfig/nginx/nginx.conf /etc/nginx/nginx.conf
\cp -fr /home/wwwconfig/nginx/plugins/*.conf /etc/nginx/plugins/
\cp -fr /home/wwwconfig/virtualhost/*.conf /etc/nginx/sites-enabled/

# 檢查服務未啟動時執行
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

# 清空初始執行設定資料
cat /dev/null > /home/docker_bash/init-bashrc.sh