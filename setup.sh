#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if test -z $(which python2); then
  echo "- Err! Not found (python2). Exit."
  exit 1
else
  echo "- Detecting python2. Ok."
fi

echo "Copying files..."
wget https://raw.githubusercontent.com/pierce403/keyhunter/master/keyhunter.py;
chmod +x ./*;

cp ./restore.sh /usr/local/bin/;
cp ./keyhunter.py /usr/local/bin;
cp ./60-detect.rules /etc/udev/rules.d/;

echo "Restart service..."
systemctl restart systemd-udevd.service;

echo "Enable beep-boop..."
modprobe pcspkr
usermod -a -G input root

echo "Done!"
