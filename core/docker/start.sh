#!/bin/bash

echo "Waiting for superset_init ends !"
(echo "GET / HTTP/1.1"; sleep 1) | nc -l -p 80

# Update nginx to match worker_processes to no. of cpu's
procs=$(cat /proc/cpuinfo | grep processor | wc -l)
sed -i -e "s/worker_processes  1/worker_processes $procs/" /etc/nginx/nginx.conf

# Always chown webroot for better mounting
chown -Rf nginx:nginx /usr/share/nginx/html

php artisan db:seed

# Start supervisord and services
/usr/local/bin/supervisord -n -c /etc/supervisord.conf