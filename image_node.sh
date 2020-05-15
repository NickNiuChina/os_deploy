#!/bin/bash

#echo "Autotest ENV is as below!"
#echo "started for mark"
MYTTY=`tty`
#echo "MYTTY is $MYTTY"
[ $? -eq 0 ] || return
TTYSHELL=/root/.TEST_${MYTTY//\/}
#echo "TTYSHELL is $TTYSHELL"
#echo ==== $MYTTY ==== $TTYSHELL ========
#[ -x $TTYSHELL ] && $TTYSHELL
#sleep 10 # For debug only
[ -x $TTYSHELL ] && screen -s -m -S TEST $TTYSHELL

