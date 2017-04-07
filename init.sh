#!/bin/sh

if [ -z "$CONNECTION" ]; then
	echo "Missing environment variable: CONNECTION"
	exit 1
fi

if [ -Z "$QUEUE" ]; then
	QUEUE="default"
fi

sed -e "s~%%CONNECTION%%~$CONNECTION~" \
	-e "s~%%QUEUE%%~$QUEUE~" \
	/etc/supervisor/conf.d/laravel-worker.conf.tpl > /etc/supervisor/supervisord.conf

rm /etc/supervisor/conf.d/laravel-worker.conf.tpl

# Debugging purpose
#cat /etc/supervisor/supervisord.conf

supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf

