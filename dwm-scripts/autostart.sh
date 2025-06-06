#!/bin/bash

# xmodmap ~/.my_hkkb_keymap &
feh --recursive --randomize --bg-fill ~/.local/share/dwm/wallpaper.png &
picom -b &
bash ~/.local/share/dwm/tap-to-click.sh  &
bash ~/.local/share/dwm/inverse-scroll.sh &
bash ~/.local/share/dwm/statusbar_refresh.sh &
fcitx5 &

