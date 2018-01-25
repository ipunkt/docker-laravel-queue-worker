FROM php:7.2-alpine

LABEL maintainer="ipunkt Business Solutions <info@ipunkt.biz>" \
		version.image="v2.0" \
		version.php=$PHP_VERSION \
		description="A supervisor configured to run with laravel artisan queue:work or artisan horizon command"

ENV PYTHON_VERSION=2.7.13-r1
ENV PY_PIP_VERSION=9.0.1-r1
ENV SUPERVISOR_VERSION=3.3.3

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default
ENV LARAVEL_HORIZON=false

# Install pdo if you want to use database queue
RUN docker-php-ext-install pdo pdo_mysql pcntl posix

# Install supervisor
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION
RUN pip install supervisor==$SUPERVISOR_VERSION

# Define working directory
WORKDIR /etc/supervisor/conf.d

# Use local configuration
COPY laravel-worker.conf.tpl /etc/supervisor/conf.d/laravel-worker.conf.tpl
COPY laravel-horizon.conf.tpl /etc/supervisor/conf.d/laravel-horizon.conf.tpl

# Copy scripts
COPY init.sh /usr/local/bin/init.sh

VOLUME /var/www/app

# Run supervisor
ENTRYPOINT ["/bin/sh", "/usr/local/bin/init.sh"]
