# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Start tmux
alias tmux="TERM=screen-256color-bce tmux"
tmux 2> /dev/null


### HISTORY ###

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000


### MISC ###

# vi mode
set -o vi

# Window size after commands
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

# Bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# greeting (why not?)
function get_time_period {
    hour=$(date +"%k")
    if [ $hour -lt 12 ]; then
        echo "Morning"
    elif [ $hour -ge 12 ] && [ $hour -lt 17 ]; then
        echo "Afternoon"
    else
        echo "Evening"
    fi
}

echo "--------------------------------"
echo "Good $(get_time_period), Nick"
echo "--------------------------------"


### PROMPT ###

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "!"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}

ESC="\[\e[0;0m\]"
BOLD="\[\e[0;1m\]"
export PS1="\u@\h:\w${BOLD}\$(parse_git_branch)${ESC} $ "


### ALIASES ###

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# tmux color fix
alias tmux="TERM=screen-256color-bce tmux"
# serve the cur dir using python's SimpleHTTP
alias webshare="python -m SimpleHTTPServer"


### PATH ###

# add personal bin
if [ -d ~/dotfiles/bin ]; then
    export PATH=$PATH:~/dotfiles/bin
fi

# node
if [ -d ~/local/node/bin ]; then
    export PATH=$PATH:~/local/node/bin
fi
