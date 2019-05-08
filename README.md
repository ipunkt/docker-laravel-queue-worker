# Laravel Queue Worker

A docker image for working with queues being monitored by supervisor as recommended by laravel.

## Environment Configuration

Running with redis you can configure your `QUEUE_CONNECTION` environment variable to match your redis link. In our case the link is called `redis` so the default value will be `redis`.

The default queue name in laravel is called `default`. So we configured the `QUEUE_NAME` environment variable to this value.

If you want to use [Laravel Horizon](https://laravel.com/docs/horizon) then you have to set the environment `LARAVEL_HORIZON` to `true`. By default it is `false`.

Since version v4.1 is it possible to modify the php memory limit. The environment variable `PHP_MEMORY_LIMIT` is by default set to `512` (MB). For unlimited memory usage just set it to `-1`. The queue worker command will also be called with the memory limit given to this value to be consistent.

For Laravel Horizon you have to configure your memory limit in your `horizon.php` configuration. The default php memory limit has to set within the container by setting `PHP_MEMORY_LIMIT` as well.


## Docker Images

| php | docker image |
| --- | ------------ |
| 7.0 | ipunktbs/laravel-queue-worker:php7.0-v1.0 |
| 7.1 | ipunktbs/laravel-queue-worker:php7.1-v2.0 |
| 7.2 | ipunktbs/laravel-queue-worker:php7.2-v3.0 |
| 7.3 | ipunktbs/laravel-queue-worker:php7.3-v4.0 - deprecated |
| 7.3 | ipunktbs/laravel-queue-worker:php7.3-v4.1 - recommended |
