#!/bin/bash
# This script is a easy way to change directory in st

dirlist=$HOME/.local/share/dwm/dmenu/dirlink.conf
dir=$(awk '{print $1}' $dirlist|dmenu -p 'Which folder do you wanna go')
#path=$(grep -i '^'$dir'' $dirlist|awk '{print $2}')
path=$(awk '/^'$dir'/ {print $2}' $dirlist)
[ $path ] && eval cd $path && st
