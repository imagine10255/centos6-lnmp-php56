![Nginx1.8](https://img.shields.io/badge/nginx-1.8-brightgreen.svg) ![PHP5.6](https://img.shields.io/badge/php-5.6-brightgreen.svg)

預設3個網站 80,81,82 (含有優雅連結,Nginx快取設定) + Composer功能 並能正常運行 PHP Framework Laravel5

- 可修改 nginx 與 3個網站的設定資料

- 可搭配 [Kitematic](https://www.docker.com/docker-toolbox) 使用 ([DockerHub Link](https://hub.docker.com/r/imagine10255/centos6-lnmp-php56/))

- 目前映像檔約 1.144 GB


### How To Setting

修改網站根目錄(修改完成後重新啟動容器)

    $ vi home/config/virtualhost/sample.conf


修改NGINX設定(修改完成後重新啟動容器)

    $ vi home/config/nginx/nginx.conf

修改PHP.INI設定(修改完成後重新啟動容器)

    $ vi home/config/php.ini

修改Crontab設定(修改完成後重新啟動容器，需注意格式不可以錯誤,若有錯誤可在啟動訊息上檢視到)

    $ vi home/config/Crontab

修改Supervisor設定(修改完成後重新啟動容器，需注意格式不可以錯誤,若有錯誤可在啟動訊息上檢視到)

    $ vi home/config/supervisord.conf

- 新增進程管理

建立 home/wwwconfig/supervisord/*conf 檔案

可參考 home/wwwconfig/supervisord.conf 最底下的 sample (請注意需自行建立空的log files)

    $ supervisorctl start laravel-worker:*

備份 SSH KEY, Nginx,PHP.ini,Hosting Config

    $ sh ~/backup-to-hosting.sh

重新讀取並重新啟動 Nginx (該指令會將 home/config 設定檔覆蓋到目前的設定檔)

    $ sh ~/nginx-reload.sh

### Working Directory

- home/config/ 設定相關檔案(若有變動請重啟容器)

- home/log/    事件紀錄相關檔案

- home/root/   網站相關檔案


### Link Mariadb-Docker

https://hub.docker.com/r/library/mariadb/

Setting Password in Environment Variables [MYSQL_ROOT_PASSWORD={your password}]

or

    $ docker run --name some-mariadb -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb:tag
    
use exec enter command change zone time in taiwan

    $ cp -p /usr/share/zoneinfo/Asia/Taipei /etc/localtime

### Link Redis-Docker

https://hub.docker.com/r/library/redis/

    $ docker run -d -p 6379:6379 --name redis redis

### Link Mailcatcher-Docker

https://hub.docker.com/r/schickling/mailcatcher/

    $ docker run -d -p 1080:1080 --name mailcatcher schickling/mailcatcher

### Composer Package

Envoy 1.0.25 任務執行


    $ envoy


### How To Use Tool

enter-container.sh 進入容器


    $ sh enter-container.sh {CONTAINERID NAME}

create-container.sh 建立容器


    $ sh create-container.sh

build-container.sh 重新使用DockerFile 製作映像檔


    $ sh build-container.sh

push-images.sh 使用DockerHub上傳映像檔


    $ sh push-images.sh

delete-images.sh 刪除廢物映像檔案<none>名稱(關聯容器必須已被刪除)


    $ sh delete-images.sh



### Catalog History

2015-12-12 新增 SSH連線(密碼預設 P@ssw0rd)

2015-12-13 新增 Crontab 排程管理

2015-12-13 新增 TimeZone Asia/Taipei CST時區

2015-12-19 新增 Supervisor 進程管理

2015-12-19 升級 git-1.7.1->2.6.3

2015-12-20 新增 SSH Key 保留, Backup Config
