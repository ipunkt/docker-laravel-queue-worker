# Laravel Queue Worker

A docker image for working with queues being monitored by supervisor as recommended by laravel.

## Environment Configuration

Running with redis you can configure your `QUEUE_CONNECTION` environment variable to match your redis link. In our case the link is called `redis` so the default value will be `redis`.

The default queue name in laravel is called `default`. So we configured the `QUEUE_NAME` environment variable to this value.

If you want to use [Laravel Horizon](https://laravel.com/docs/5.5/horizon) then you have to set the environment `LARAVEL_HORIZON` to `true`. By default it is `false`.


## Docker Images

| php | docker image |
| --- | ------------ |
| 7.0 | ipunktbs/laravel-queue-worker:php7.0-v1.0 |
| 7.1 | ipunktbs/laravel-queue-worker:php7.1-v2.0 |
| 7.2 | ipunktbs/laravel-queue-worker:php7.2-v3.0 |
