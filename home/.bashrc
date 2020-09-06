#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/manuel.pasieka/google-cloud-sdk/path.bash.inc' ]; then . '/home/manuel.pasieka/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/manuel.pasieka/google-cloud-sdk/completion.bash.inc' ]; then . '/home/manuel.pasieka/google-cloud-sdk/completion.bash.inc'; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/manuel.pasieka/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/manuel.pasieka/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/manuel.pasieka/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/manuel.pasieka/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias ls='ls --color=auto'
alias ll='ls -hal'
alias lt='ls -hartl'
PS1='[\u@\h \W]\$ '
alias xrandr_work='xrandr --output DP1 --right-of eDP1 --mode 3840x2160'
alias xrandr_reset='xrandr --output eDP1 --mode 2560x1600'
alias batstat='cat /sys/class/power_supply/BAT0/capacity'
alias selShot='sleep 2; scrot '/tmp/screenshot-%F:%T.png' -s'

# Load fzf settings
source ~/.config/fzf/key-bindings.bash
source ~/.config/fzf/completion.bash

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
