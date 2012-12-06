# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="ndr"

# Aliases
alias c='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias s='git status'
# tmux color fix
alias tmux="TERM=screen-256color-bce tmux"
# serve the cur dir using python's SimpleHTTP
alias webshare="python -m SimpleHTTPServer"
alias sp='vim -c "OpenScratchpad" -c only'

gg_replace() {
    if [[ "$#" == "0" ]]; then
        echo 'Usage:'
        echo '  gg_replace term replacement file_mask'
        echo
        echo 'Example:'
        echo '  gg_replace cappuchino cappuccino *.html'
        echo
    else
        find=$1; shift
        replace=$1; shift

        ORIG_GLOBIGNORE=$GLOBIGNORE
        GLOBIGNORE=*.*

        if [[ "$#" = "0" ]]; then
            set -- ' ' $@
        fi

        while [[ "$#" -gt "0" ]]; do
            for file in `git grep -l $find -- $1`; do
                sed -e "s/$find/$replace/g" -i'' $file
            done
            shift
        done

        GLOBIGNORE=$ORIG_GLOBIGNORE
    fi
}

gg_dasherize() {
    gg_replace $1 `echo $1 | sed -e 's/_/-/g'` $2
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow github brew ruby bundler cloudapp npm pip vi-mode)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_local

# Customize to your needs...
export PATH=/Users/ndreynolds/.rbenv/shims:/Users/ndreynolds/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/ndreynolds/dotfiles/bin:/usr/texbin:/usr/local/share/npm/bin
