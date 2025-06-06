#!/bin/bash
# This script is to confirm some command on dmenu.

[ $(echo -e 'No\nYes' |dmenu -p 'Do you want to '$1'') \
== 'Yes' ] && $1
