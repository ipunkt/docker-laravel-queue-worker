# Laravel Queue Worker

A docker image for working with queues being monitored by supervisor as recommended by laravel.

## Environment Configuration

Running with redis you can configure your `QUEUE_CONNECTION` environment variable to match your redis link. In our case the link is called `redis` so the default value will be `redis`.

The default queue name in laravel is called `default`. So we configured the `QUEUE_NAME` environment variable to this value.

If you want to use [Laravel Horizon](https://laravel.com/docs/5.5/horizon) then you have to set the environment `LARAVEL_HORIZON` to `true`. By default it is `false`.