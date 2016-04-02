#!/bin/bash
LOG=/root/setup.log
DISPLAY=$DISPLAY
$DISPLAY Started
ip=$(hostname -I) || true
if [ ! "$ip" ]; then
    $DISPLAY No IP
    exit 1
fi
$DISPLAY 'IP ='
echo $ip | $DISPLAY

$DISPLAY upgrade please wait...
git clone https://github.com/petrum/rpi.git /home/pi/git/rpi

if [[ -f /root/setup.done ]] ; then
    $DISPLAY all looks fine already
    exit 0
fi
$DISPLAY update please wait...
if ! apt-get update --fix-missing >> $LOG 2>&1 ; then
   $DISPLAY failed to update
   exit 2
fi
$DISPLAY done
$DISPLAY install please wait...
if ! apt-get install python-pip python-dev vim git -y >> $LOG 2>&1 ; then
    $DISPLAY failed to install
    exit 3
fi
$DISPLAY done
$DISPLAY pip installing spidev please wait...
if ! pip install spidev >> $LOG 2>&1 ; then
    $DISPLAY failed to install spidev
    exit 3
fi
 
$DISPLAY setup done
touch /root/setup.done
exit 0

