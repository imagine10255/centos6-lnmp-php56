# dockerfile-lnmp-min

PHP5.6 + Nginx1.8

預設3個網站 80,81,82 (含有優雅連結,Nginx快取設定) + Composer功能

可修改 nginx 與 3個網站的設定資料(例如:重新指定網站跟目錄)

目前映像檔約 965.6 MB



## how to use

- enter-container.sh 進入容器

> $ sh enter-container.sh {CONTAINERID NAME}

- create-container.sh 建立容器

> $ sh create-container.sh

- build-container.sh 重新使用DockerFile 製作映像檔

> $ sh build-container.sh

- push-images.sh 使用DockerHub上傳映像檔

> $ sh push-images.sh
