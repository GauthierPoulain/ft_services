rc-service php-fpm7 start
rc-service nginx start

while [ $(/usr/bin/pgrep nginx | wc -l) -gt 0 ]; do
	if [ $(/usr/bin/pgrep php-fpm | wc -l) -gt 0 ]; then
		sleep 2
	else
		exit 1
	fi
done
