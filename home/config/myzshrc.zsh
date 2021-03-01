# Enable powerline: https://wiki.archlinux.org/index.php/Powerline
powerline-daemon -q
. /usr/lib/python3.9/site-packages/powerline/bindings/zsh/powerline.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/manuel.pasieka/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

