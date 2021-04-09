rc-service nginx start

while [ $(/usr/bin/pgrep nginx | wc -l)  -gt 0 ]
do
	sleep 2
done