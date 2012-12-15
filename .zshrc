# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
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

plugins=(git git-flow github brew ruby bundler cloudapp npm pip vi-mode)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_local

if [[ -f ~/dotfiles/bin/update ]]; then
  ~/dotfiles/bin/update
fi

# Customize to your needs...
export PATH=/Users/ndreynolds/.rbenv/shims:/Users/ndreynolds/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/ndreynolds/dotfiles/bin:/usr/texbin:/usr/local/share/npm/bin
