#!/bin/sh

if [ -z "$QUEUE_CONNECTION" ]; then
	QUEUE_CONNECTION="redis"
fi

if [ -z "$QUEUE_NAME" ]; then
	QUEUE_NAME="default"
fi

sed -e "s~%%QUEUE_CONNECTION%%~$QUEUE_CONNECTION~" \
	-e "s~%%QUEUE_NAME%%~$QUEUE_NAME~" \
	/etc/supervisor/conf.d/laravel-worker.conf.tpl > /etc/supervisor/supervisord.conf

supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
