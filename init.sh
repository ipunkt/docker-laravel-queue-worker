#!/bin/sh

if [ -z "$CONNECTION" ]; then
	CONNECTION="default"
fi

if [ -Z "$QUEUE" ]; then
	QUEUE="default"
fi

sed -e "s~%%CONNECTION%%~$CONNECTION~" \
	-e "s~%%QUEUE%%~$QUEUE~" \
	/etc/supervisor/conf.d/laravel-worker.conf.tpl > /etc/supervisor/supervisord.conf

rm /etc/supervisor/conf.d/laravel-worker.conf.tpl

supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
