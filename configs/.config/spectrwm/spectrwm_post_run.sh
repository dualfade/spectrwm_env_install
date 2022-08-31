#!/bin/bash
# download and adjust to your needs --
# @dualfade

/usr/bin/xrandr --output eDP-1 --primary
/usr/bin/xrandr --output eDP-1 --mode 1920x1080 --auto
/usr/bin/xrandr --output DP-1 --left-of eDP-1 --auto
/usr/bin/xrandr --output DP-3 --right-of eDP-1 --mode 3440x1440 --auto

# start other shit --
# -> yain network-manager-applet
# required by protonvpn-cli; stupid dep  --
# /usr/bin/nm-applet &

# set wallpaper; anything else ??
#/usr/bin/feh --bg-fill ~/.wallpaper/dark-cubes-hd-wallpaper.jpg &
#/usr/bin/xrdb -merge ~/.Xresources &

# update xps display --
# xrandr | grep -w connected | cut -f '1' -d ' '
/usr/bin/xrandr --output eDP-1 --brightness 1.2
