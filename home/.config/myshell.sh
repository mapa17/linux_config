# Enable dwblock scripts
export PATH=$HOME/.config/dwmblocks:$PATH
export PATH=$HOME/.config/bin:$PATH

alias xrandr_right='xrandr --output DP1 --right-of eDP1 --mode 3840x2160'
alias xrandr_left='xrandr --output DP1 --left-of eDP1 --mode 3840x2160'
alias xrandr_reset='xrandr --output eDP1 --mode 2560x1600'
alias batstat='cat /sys/class/power_supply/BAT0/capacity'
#alias selShot='sleep 2; scrot '/tmp/screenshot-%F:%T.png' -s'
alias zsh_settings="vim ~/.config/myshell.sh"
alias view='sxiv'
alias code='code --disable-gpu'
alias lt='ls -hartl'
alias reset_time='sudo ntpd -qg && sudo hwclock --systohc'
alias n='nnn -cdH -P p'
alias down='shutdown -h now'
alias mpd_speaker='pkill mpd ; sleep 0.5 ; mpd ~/.config/mpd/mpd-speakers.conf'
alias mpd_headphones='pkill mpd ; sleep 0.5 ; mpd ~/.config/mpd/mpd-headphones.conf'
#alias worklogs='code --disable-gpu ~/code/manuel-pasieka'

# nnn variables
export NNN_PLUG='p:preview-tabbed;f:fzd'
export NNN_BMS='u:/home/manuel.pasieka;d:~/Downloads/;w:~/WD;c:~/code'

## Enable settings for nuke
export GUI=1
export EDITOR=vim
#export PAGER="bat --paging=always"
export NNN_OPENER="/home/manuel.pasieka/.config/nnn/plugins/nuke"
export TERMINAL=st
export NNN_FIFO="/tmp/nnn.fifo"
export LC_COLLATE="C"
# dwm fix for pycharm
export _JAVA_AWT_WM_NONREPARENTING=1

selShot () {
	if [ -z "$1" ]
	  then
		PREFIX='screenshot'
	  else
		PREFIX=$1
	fi	
	scrot "/tmp/${PREFIX}-%F:%T.png" -s
}

brightUp () {
	current=$(((`cat /sys/class/backlight/intel_backlight/brightness` * 10) / `cat /sys/class/backlight/intel_backlight/max_brightness`))
	stepsize=$((`cat /sys/class/backlight/intel_backlight/max_brightness` / 10))
	if [ $current -lt 10 ]
	then
		current=$(($current + 1))
		new_value=$(($current * $stepsize))
		echo "current: $current, new_value: $new_value"
		echo $new_value > /sys/class/backlight/intel_backlight/brightness
	fi
}

brightDown () {
	current=$(((`cat /sys/class/backlight/intel_backlight/brightness` * 10) / `cat /sys/class/backlight/intel_backlight/max_brightness`))
	stepsize=$((`cat /sys/class/backlight/intel_backlight/max_brightness` / 10))
	if [ $current -gt 0 ]
	then
		current=$(($current - 1))
		new_value=$(($current * $stepsize))
		echo "current: $current, new_value: $new_value"
		echo $new_value > /sys/class/backlight/intel_backlight/brightness
	fi
} 

is_ip(){
	IP=`echo "$1" | grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"`
        if [ -z "$IP" ]
        then
		ret=0
	else
	        ret=1
	fi
	return $ret
}

gssh (){
	ssh -i ~/.ssh/google_compute_engine manuel.pasieka@${1}
}

gsshs () {
	IP=$(gip | awk {'print $2'})
	gssh ${IP}
}

gscp (){
	if is_ip ${1} ; then
		echo 'Copy to machine ...'
		scp -i ~/.ssh/google_compute_engine ${1} manuel.pasieka@${2}
	else
		echo "Copy from machine ..."
		scp -i ~/.ssh/google_compute_engine manuel.pasieka@${1} ${2}
	fi
}


gip (){
	MACHINES=$(gcloud compute instances list | grep RUNNING)
	SELECTED=$(echo "${MACHINES}" | tail +2 | awk '{ print $1 }' | dmenu)
	IP=$(echo "${MACHINES}" | grep ${SELECTED} | awk '{ print $5 }')
	echo "${SELECTED} ${IP}"	
}

gstart (){
	MACHINES=$(gcloud compute instances list | grep TERMINATED)
	SELECTED=$(echo "${MACHINES}" | tail +2 | awk '{ print $1 }' | dmenu)
	ZONE=$(echo "${MACHINES}" | grep ${SELECTED} | awk '{ print $2 }')
	echo "Starting ${SELECTED} in zone ${ZONE} ..."
	gcloud compute instances start ${SELECTED} --zone=${ZONE}
}

gstop (){
	MACHINES=$(gcloud compute instances list | grep RUNNING)
	SELECTED=$(echo "${MACHINES}" | tail +2 | awk '{ print $1 }' | dmenu)
	ZONE=$(echo "${MACHINES}" | grep ${SELECTED} | awk '{ print $2 }')
	echo "Stopping ${SELECTED} in zone ${ZONE} ..."
	gcloud compute instances stop ${SELECTED} --zone=${ZONE}
}

VMStart() {
	echo "Starting VM ${1} in headless mode ..."
	VBoxHeadless -s ${1} &
	echo "Trying rdp connection ..."
	sleep 3

	# Get the resolution of the last active monitor
	# Remove a bit of the higth and width to account for the window manger
	RESOLUTION=$(xrandr --listactivemonitors  | awk -F '[ /x]' '{print $4-20 "x" $6-60}' | tail -n1)
	xfreerdp /size:${RESOLUTION} /v:127.0.0.1
}

win10() {
	VMStart Win10
}

kali() {
	VMStart Kali-Linux-2020.4-vbox-amd64
}




