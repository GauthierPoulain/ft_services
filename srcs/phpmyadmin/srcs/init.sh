#!/bin/sh
check_service() {
	for var in "$@"; do
		if [ $(/usr/bin/pgrep $var | wc -l) == 0 ]; then
			exit 1
		fi
	done
}

telegraf &
rc-service php-fpm7 start
rc-service nginx start

sleep 5

while true; do
	check_service nginx php-fpm telegraf
	sleep 2
done
