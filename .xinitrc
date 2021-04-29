setxkbmap -option "caps:escape"
xset r rate 180 40
sxhkd &
picom &
dwmblocks &
dunst &
pidof mpd || mpd
mpstatus &
randwp
exec dwm
