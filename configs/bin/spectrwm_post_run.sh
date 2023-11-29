#!/bin/bash
# @dualfade

# conected displays --
# xrandr | grep -w connected | cut -f '1' -d ' '

# laptop; primary --
/usr/bin/xrandr --output eDP-1 --primary
/usr/bin/xrandr --output eDP-1 --mode 1920x1080 --auto
/usr/bin/xrandr --output eDP-1 --brightness 1.0

# Desktop main --
/usr/bin/xrandr --output DP-1 --right-of eDP-1 --mode 3440x1440 --auto
# /usr/bin/xrandr --output DP-1 --right-of eDP-1 --mode 3440x1440 --rate 59.97
/usr/bin/xrandr --output DP-1 --brightness 1.0

# Decgear overhead --
/usr/bin/xrandr --output DP-3 --left-of eDP-1 --mode 2560x1440 --auto
/usr/bin/xrandr --output DP-3 --brightness 1.0

# start other shit --
# /usr/bin/feh --bg-fill ~/.wallpaper/232568_scaled.jpg
# /usr/bin/feh --bg-fill ~/.wallpaper/retina.jpg
# /usr/bin/feh --bg-fill ~/.wallpaper/wp6621664.jpg
# /usr/bin/feh --bg-fill ~/.wallpaper/2592550.png
# /usr/bin/feh --bg-fill ~/.wallpaper/cyberpunk-astronaut-minimal.jpg
# /usr/bin/feh --bg-scale ~/.wallpaper/minimal_gas_mask.jpg
# /usr/bin/feh --bg-scale ~/.wallpaper/future-buildings-minimal-ve-2560x1080.jpg
# /usr/bin/feh --bg-scale ~/.wallpaper/abstract.jpg
# /usr/bin/feh --bg-scale ~/.wallpaper/stroke-minimalism-4k-ic.jpg
/usr/bin/feh --bg-scale ~/.wallpaper/minimalistic-abstract-colors.jpg
/usr/bin/xrdb -merge ~/.Xresources

# Load .Xmodmap if it exists --
# failing; call from ~/.zshrc --
# [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
