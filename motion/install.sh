#!/bin/bash
. "$(dirname $0)/../install-reuse.sh"
READER=$(selectMicroSD)
#diskcopy /home/petrum/Downloads/2016-03-18-raspbian-jessie.img $READER
diskcopy /home/petrum/Downloads/2016-03-18-raspbian-jessie-lite.img $READER
expandFS $READER
DEST=$(mountFS $READER 2)
sethostname motion $DEST
get_rpi $DEST
sudo sed -i 's|^exit 0|/home/pi/git/rpi/motion/motion.sh >> /root/motion.log 2>\&1\nexit 0|g' $DEST/etc/rc.local
sudo cp -v /home/petrum/rpi-private/ssmtp.conf $DEST/home/pi/ssmtp.conf
umountFS $DEST
