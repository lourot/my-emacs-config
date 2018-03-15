#!/bin/sh

# Returns a positive number if a git process is running, 0 otherwise.  
num=`pgrep -lfa git | grep -v gitrunning | grep -v daemon | grep -v emacsclient | wc -l`
exit $num
