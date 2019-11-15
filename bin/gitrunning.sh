#!/bin/sh

# Returns a positive number if a git process is running, 0 otherwise.  
num=`pgrep -lfa git | grep -v gitrunning | grep -v daemon | grep -v emacsclient | grep -v reframe.start | grep -v openvpn | wc -l`
exit $num
