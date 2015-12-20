#!/bin/bash

# Backup Nginx
\cp -fr /etc/php.ini /home/wwwconfig/php.ini 
\cp -fr /etc/nginx/nginx.conf /home/wwwconfig/nginx/nginx.conf 
\cp -fr /etc/nginx/plugins/* /home/wwwconfig/nginx/plugins/
\cp -fr /etc/nginx/sites-enabled/* /home/wwwconfig/virtualhost/


# Backup supervisor
\cp -fr /etc/supervisord.conf /home/wwwconfig/supervisord.conf 


# Backup SSH
if [ -f "/root/.ssh/id_rsa.pub" ]; then
  \cp -fr /root/.ssh/id_rsa.pub /home/wwwconfig/ssh-key/
fi

if [ -f "/root/.ssh/id_rsa" ]; then
  \cp -fr /root/.ssh/id_rsa /home/wwwconfig/ssh-key/
fi


echo "Backup Finish"