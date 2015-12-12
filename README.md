# centos6-lnmp-php56 & use tools

PHP5.6 + Nginx1.8

預設3個網站 80,81,82 (含有優雅連結,Nginx快取設定) + Composer功能 並能正常運行 PHP Framework Laravel5

可修改 nginx 與 3個網站的設定資料(例如:重新指定網站跟目錄)

目前映像檔約 980.9 MB

[DockerHub lnmp-mini Link](https://hub.docker.com/r/imagine10255/lnmp-mini/)

2015.12.12 新增SSH連線(密碼預設 P@ssw0rd)

## how to use

- enter-container.sh 進入容器

> $ sh enter-container.sh {CONTAINERID NAME}

- create-container.sh 建立容器

> $ sh create-container.sh

- build-container.sh 重新使用DockerFile 製作映像檔

> $ sh build-container.sh

- push-images.sh 使用DockerHub上傳映像檔

> $ sh push-images.sh

- delete-images.sh 刪除廢物映像檔案<none>名稱(關聯容器必須已被刪除)

> $ sh delete-images.sh


## Working Directory

- home/wwwconfig/ 設定相關檔案(若有變動請重啟容器)
- home/wwwlog/    事件紀錄相關檔案
- home/wwwroot/   網站相關檔案


## Link Mariadb-Docker

https://hub.docker.com/r/library/mariadb/

Setting Password in Environment Variables [MYSQL_ROOT_PASSWORD={your password}]

or

> $ docker run --name some-mariadb -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb:tag


## Composer Package

- Envoy 1.0.25 任務執行

> $ envoy
