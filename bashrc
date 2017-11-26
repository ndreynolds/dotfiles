# ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


### HISTORY ###

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000


### MISC ###

# extended globbing
shopt -s extglob

# vi mode
set -o vi

# Window size after commands
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


### ALIASES ###

alias c='clear'


### PATH/SOURCES ###

# Check for .bash_local
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi

# Add personal bin
if [ -d ~/dotfiles/bin ]; then
    export PATH=$PATH:~/dotfiles/bin
fi
