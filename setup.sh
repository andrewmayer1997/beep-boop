#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if test -f /bin/python2; then
    echo "- Detecting python2. Ok."
else
    echo "- Detecting python2. Not found"
    exit 1
fi

echo "Copying files..."
wget https://raw.githubusercontent.com/pierce403/keyhunter/master/keyhunter.py;
chmod +x ./*;

cp ./restore.sh /usr/local/bin/;
cp ./keyhunter.py /usr/local/bin;
cp ./60-detect.rules /etc/udev/rules.d/;

echo "Restart service..."
systemctl restart systemd-udevd.service;

echo "Done!"
