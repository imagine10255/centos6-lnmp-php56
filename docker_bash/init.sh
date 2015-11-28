#!/bin/bash
# Cover profile
\cp -fr /home/wwwconfig/php.ini /etc/php.ini
\cp -fr /home/wwwconfig/nginx/nginx.conf /etc/nginx/nginx.conf
\cp -fr /home/wwwconfig/nginx/plugins/*.conf /etc/nginx/plugins/
\cp -fr /home/wwwconfig/virtualhost/*.conf /etc/nginx/sites-enabled/

# Start PHP-FPM
/etc/rc.d/init.d/php-fpm start

# Start Nginx
/etc/rc.d/init.d/nginx start

# 檢查服務未啟動時執行
for SERVICE in nginx php-fpm
do
  if ps ax | grep -v grep | grep $SERVICE > /dev/null
  then
     #echo "service $SERVICE runing";
  else
     service $SERVICE start;
  fi
done

# 清空初始執行設定資料
cat /dev/null > /opt/bash/init.sh