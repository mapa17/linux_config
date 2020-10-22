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

```
sudo systemctl enable NetworkManager.service
```

** cron job for wallpaper switching **
```
fcrontab -e

# Add
"*/3 * * * * env DISPLAY=:0 /usr/bin/feh --recursive --bg-max --randomize  /home/manuel.pasieka/OneDrive/Imagenes/Arte/"

sudo systemctl enable fcron.service
```

** Add udev rules for backlight modifications **
``
echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"' > /etc/udev/rules.d/50-backlight.rules 
``
