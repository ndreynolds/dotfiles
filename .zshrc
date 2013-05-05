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

alias tmux='TERM=screen-256color-bce tmux'
alias serve='python -m SimpleHTTPServer'
alias sp='vim ~/repos/scratchpad/scratchpad.md'
alias splive='vim -c "OpenScratchpad" -c only'
alias journal='vim "$HOME/repos/journal/$(date "+%Y-%m-%d").md"'

# Plugins
# -------
plugins=(git git-extras git-flow github brew ruby rails3 bundler 
         cloudapp npm pip vi-mode vagrant)

# Env
# ---
export EDITOR=vim
export VISUAL=vim

# $PATH
# -----
# Basics + dotfiles scripts. Others (npm, rvm, etc.) should be added in .zsh_local
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

# Sources
# -------
source $ZSH/oh-my-zsh.sh
source ~/.zsh_local

# Run the dotfiles updater
if [[ -f ~/dotfiles/bin/update ]]; then
  ~/dotfiles/bin/dotfiles-update
fi
