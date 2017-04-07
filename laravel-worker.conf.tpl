[supervisord]
nodaemon=true

[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/app/artisan queue:work %%CONNECTION%% --queue=%%QUEUE%%
autostart=true
autorestart=true
numprocs=1
startretries=3000
