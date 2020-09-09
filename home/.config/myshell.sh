# Enable dwblock scripts
export PATH=$HOME/.config/dwmblocks:$PATH

alias xrandr_work='xrandr --output DP1 --right-of eDP1 --mode 3840x2160'
alias xrandr_reset='xrandr --output eDP1 --mode 2560x1600'
alias batstat='cat /sys/class/power_supply/BAT0/capacity'
alias selShot='sleep 2; scrot '/tmp/screenshot-%F:%T.png' -s'
alias zsh_settings="vim ~/.config/myshell.sh"
alias view='sxiv'
alias code='code --disable-gpu'

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

