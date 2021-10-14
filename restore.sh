#!/bin/bash
DATE=$(date +%F_%T)
NAME=$1
SERIAL=$(udevadm info --query=all --name=/dev/$NAME | grep -o "ID_SERIAL_SHORT=.*" | grep -oE '[0-9]' | tr -d '\n')
LOG="/usr/local/etc/${SERIAL}-${DATE}"

echo "START...\n" > $LOG;

beep -f 1000 -l 400
echo "1" | tee -a /sys/class/leds/input*::capslock/brightness > /dev/null;
sleep 3;
echo "0" | tee -a /sys/class/leds/input*::capslock/brightness > /dev/null;

/bin/python2 /usr/local/bin/keyhunter.py /dev/$NAME > $LOG;

LINES=$(wc -l < $LOG)

if (($LINES > 1)); then
	mv $LOG $LOG.true
	beep -f 5000 -l 400 -r 4
	echo "1" | tee -a /sys/class/leds/input*::numlock/brightness > /dev/null;
	sleep 3;
	echo "0" | tee -a /sys/class/leds/input*::numlock/brightness > /dev/null;
else
	mv $LOG $LOG.false
	beep -f 1000 -l 400
fi
