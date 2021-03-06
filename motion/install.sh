#!/bin/bash
. "$(dirname $0)/../install-reuse.sh"
READER=$(selectMicroSD)
diskcopy /home/petrum/Downloads/2016-09-23-raspbian-jessie-lite.img $READER
DEST=$(mountFS $READER 2)
generic_setup $DEST $READER
sethostname motion $DEST
dynamic_ip 192.168.1.1 255.255.255.0 $DEST
sudo sed -i 's|^exit 0|/home/pi/git/rpi/motion/startup.sh petru.marginean@gmail.com >> /root/motion.log 2>\&1\nexit 0|g' $DEST/etc/rc.local
sudo cp -v /home/petrum/rpi-private/ssmtp.conf $DEST/home/pi/ssmtp.conf
umountFS $DEST

