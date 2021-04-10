#!/bin/sh
check_service() {
	for var in "$@"; do
		if [ $(/usr/bin/pgrep $var | wc -l) == 0 ]; then
			exit 1
		fi
	done
}

telegraf &
pure-ftpd -P $(cat ip.txt) &

sleep 5

while true; do
	check_service telegraf pure-ftpd
	sleep 2
done
