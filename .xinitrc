xsetroot -cursor_name left_ptr
setxkbmap -layout fr -variant bepo
amixer sset Master unmute
xrdb -merge ~/.Xresources
exec xmonad
