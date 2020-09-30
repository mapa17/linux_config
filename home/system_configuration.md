# This documents includes serveral system configurations

** store installed packages **
```
pacman -Qqen > ~/compile/linux_config/home/pkglist.txt
pacman -Qqem > ~/compile/linux_config/home/pkglist-aur.txt
```

** install from package list **
```
pacman -S --needed - < ~/compile/linux_config/home/pkglist.txt
yay -S --needed --noconfirm $(< ~/compile/linux_config/home/pkglist.txt)
```

** cron job for wallpaper switching **
```
echo "*/3 * * * * env DISPLAY=:0 /usr/bin/feh --recursive --bg-max --randomize  /data/OneDrive/Imagenes/Arte/" >> /var/spool/cron/manuel.pasieka
```

** Add udev rules for backlight modifications **
``
echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"' > /etc/udev/rules.d/50-backlight.rules 
``
