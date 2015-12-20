#!/bin/bash

# Backup Nginx
\cp -fr /etc/php.ini /home/wwwconfig/php.ini 
\cp -fr /etc/nginx/nginx.conf /home/wwwconfig/nginx/nginx.conf 
\cp -fr /etc/nginx/plugins/* /home/wwwconfig/nginx/plugins/
\cp -fr /etc/nginx/sites-enabled/* /home/wwwconfig/virtualhost/


# Backup supervisor
\cp -fr /etc/supervisord.conf /home/wwwconfig/supervisord.conf 


# Backup SSH
\cp -fr ~/.ssh/* /home/wwwconfig/ssh-key/


echo "Backup Finish"