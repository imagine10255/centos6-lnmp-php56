#!/bin/bash

CONTAINER="${1}";

if [ "$CONTAINER" == "" ]; then
echo "please enter container new-name";
echo "ex: sh install-container.sh app-lnmp-php56";
exit;
fi

# create docker-container
docker run -idt \
--name "$CONTAINER" \
-p 80:80 \
-p 81:81 \
-p 82:82 \
-p 8080:8080 \
-p 3306:3306 \
-v /home/config:/home/config \
-v /home/logs:/home/logs \
-v /home/website:/home/website \
imagine10255/centos6-lnmp-php56:latest

# enter docker-container
sh ./enter-container.sh $CONTAINER
