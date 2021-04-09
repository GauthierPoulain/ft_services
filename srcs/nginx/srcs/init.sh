rc-service nginx start

sleep 5

while [ $(/usr/bin/pgrep nginx | wc -l)  -gt 0 ]
do
	sleep 2
done