setxkbmap -layout fr -variant bepo
eval $(ssh-agent) 
xscreensaver -no-splash &
exec stack exec xmonad
