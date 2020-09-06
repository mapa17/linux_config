xcompmgr -c & 
sleep 2 && xrandr --output eDP1 --mode 2560x1600
dwmblocks &
#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
exec dwm
