#!/bin/sh

if [ -z "$QUEUE_CONNECTION" ]; then
	QUEUE_CONNECTION="redis"
fi

if [ -z "$QUEUE_NAME" ]; then
	QUEUE_NAME="default"
fi

if [ -z "$LARAVEL_HORIZON" ]; then
	LARAVEL_HORIZON=false
fi

PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-512}
sed -e "s~%%MEMORY_LIMIT%%~${PHP_MEMORY_LIMIT}m~" \
    /opt/etc/custom-php.ini.tpl > /usr/local/etc/php/conf.d/custom-php.ini

if [ "$LARAVEL_HORIZON" = false ]; then
	sed -e "s~%%QUEUE_CONNECTION%%~$QUEUE_CONNECTION~" \
		-e "s~%%QUEUE_NAME%%~$QUEUE_NAME~" \
		-e "s~%%MEMORY_LIMIT%%~$PHP_MEMORY_LIMIT~" \
		/etc/supervisor/conf.d/laravel-worker.conf.tpl > /etc/supervisor/supervisord.conf
fi

if [ "$LARAVEL_HORIZON" = true ]; then
	cp /etc/supervisor/conf.d/laravel-horizon.conf.tpl /etc/supervisor/supervisord.conf
fi

supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf
