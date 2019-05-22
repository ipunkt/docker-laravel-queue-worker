[supervisord]
nodaemon=true
logfile=/dev/stdout
logfile_maxbytes=0

[program:laravel-horizon]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/app/artisan horizon
autostart=true
autorestart=true
stdout_events_enabled=1
redirect_stderr=true
