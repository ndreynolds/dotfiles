# .zshrc
# ------

# oh-my-zsh
# ---------
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ndr"

# Aliases
# -------
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

# Plugins
# -------
plugins=(git git-flow github brew ruby bundler cloudapp npm pip vi-mode)

# $PATH
# -----
# Basics + dotfiles scripts. Others (npm, rvm, etc.) should be added in .zsh_local
export PATH="/usr/local/bin:/usr/bin:/usr/sbin:/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

# Sources
# -------
source $ZSH/oh-my-zsh.sh
source ~/.zsh_local

# Run the dotfiles updater
if [[ -f ~/dotfiles/bin/update ]]; then
  ~/dotfiles/bin/update
fi
