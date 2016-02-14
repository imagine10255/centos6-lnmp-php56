#!/bin/bash

# Cover profile nginx
\cp -fr /home/config/php.ini /etc/php.ini
\cp -fr /home/config/nginx/nginx.conf /etc/nginx/nginx.conf
\cp -fr /home/config/nginx/sites-include/*.conf /etc/nginx/sites-include/
\cp -fr /home/config/nginx/sites-enabled/*.conf /etc/nginx/sites-enabled/


# Check Service to start
for SERVICE in nginx php-fpm
do
     service $SERVICE restart;
done