#!/bin/sh

# Opens a file without specifying its path. 
echo "Searching..."
for i in $(find . -name $1)
do
    echo "Found: $i"
    ~/.emacs.d/bin/emacsclient.sh $i
    exit 0
done
echo "Not found."
