#!/bin/bash

CONTAINERID="${1}";

if [ "$CONTAINERID" == "" ]; then
echo "please keyin {Container-id or Name}";
echo "ex: sh enter-docker.sh laravel5";
exit;
fi

docker exec -it $CONTAINERID bash
