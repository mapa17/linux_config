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

# Load fzf settings
source ~/.config/fzf/key-bindings.bash
source ~/.config/fzf/completion.bash

source ~/.config/myshell.sh
