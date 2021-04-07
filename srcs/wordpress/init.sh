rc-service php-fpm7 start
rc-service nginx start
tail -f /var/log/nginx/access.log -f /var/log/nginx/error.log