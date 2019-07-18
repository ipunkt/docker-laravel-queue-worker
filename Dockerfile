FROM php:7.3-alpine

LABEL maintainer="ipunkt Business Solutions <info@ipunkt.biz>" \
		version.image="v4.4" \
		version.php=$PHP_VERSION \
		description="A supervisor configured to run with laravel artisan queue:work or artisan horizon command"

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default
ENV LARAVEL_HORIZON=false

RUN apk add --no-cache coreutils sqlite-dev libxml2-dev curl-dev gmp-dev icu-dev libpng-dev jpeg-dev freetype-dev autoconf imagemagick-dev gcc libc-dev libzip-dev rabbitmq-c-dev make libtool \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/freetype2 --with-jpeg-dir=/usr/include \
	&& docker-php-ext-install -j$(nproc) bcmath pdo pdo_mysql pdo_sqlite mbstring json xml zip curl gmp intl gd soap sockets pcntl \
	&& pecl install imagick \
	&& pecl install amqp \
	&& docker-php-ext-enable imagick

ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd

RUN chmod +x /usr/local/bin/confd \
	&& apk add --no-cache sqlite libxml2 curl gmp icu libpng jpeg freetype libzip imagemagick gcc ssmtp rabbitmq-c \
	# Fix alpine iconv problems part 1
	# See https://github.com/docker-library/php/issues/240
	&& apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community gnu-libiconv \
	&& docker-php-ext-enable bcmath pdo pdo_mysql pdo_sqlite mbstring json xml zip curl gmp intl gd imagick soap amqp sockets

# Install pdo if you want to use database queue and install supervisor
RUN apk add --update supervisor && rm -rf /tmp/* /var/cache/apk/*

# Define working directory
WORKDIR /etc/supervisor/conf.d

# Use local configuration
COPY laravel-worker.conf.tpl /etc/supervisor/conf.d/laravel-worker.conf.tpl
COPY laravel-horizon.conf.tpl /etc/supervisor/conf.d/laravel-horizon.conf.tpl
COPY custom-php.ini.tpl /opt/etc/custom-php.ini.tpl
COPY supervisord-watchdog.py /opt/supervisord-watchdog.py

# Copy scripts
COPY init.sh /usr/local/bin/init.sh

VOLUME /var/www/app

# Run supervisor
ENTRYPOINT ["/bin/sh", "/usr/local/bin/init.sh"]
