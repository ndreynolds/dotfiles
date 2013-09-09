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
alias mux=tmuxinator
alias serve='python -m SimpleHTTPServer'
alias sp='vim ~/repos/scratchpad/scratchpad.md'
alias n=notes
alias r=repo
alias splive='vim -c "OpenScratchpad" -c only'
alias todo='vim "$HOME/repos/todo/todo.txt"'
alias rpry='pry -r ./config/environment'
alias bigfiles='tree -ah --du . | ack "\[(\d{3,}M|\d+.*G)\]"'

if [[ "$OSTYPE" =~ ^darwin ]]; then
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias mvim='/Applications/MacVim.app/Contents/MacOS/MacVim'
fi

# Functions
# ---------
notes() {
  vim $HOME/repos/notes/$1
}
_notes() {
  reply=(`ls "$HOME/repos/notes"`)
}
compctl -K _notes notes

repo() {
  cd $HOME/repos/$1
}
_repo() {
  reply=(`ls "$HOME/repos"`)
}
compctl -K _repo repo

journal() {
  if (( $# == 0 )) then
    vim "$HOME/repos/journal/entries/$(date "+%Y-%m-%d").md"
  else
    if [[ "$1" = "yesterday" ]] then
      vim "$HOME/repos/journal/entries/$(date -v -1d "+%Y-%m-%d").md"
    else
      vim "$HOME/repos/journal/entries/$1"
    fi
  fi
}
_journal() {
  reply=(yesterday `ls "$HOME/repos/journal/entries"`)
}
compctl -K _journal journal


# Plugins
# -------
plugins=(git git-extras git-flow github brew ruby rails3 bundler 
         cloudapp npm pip pass vagrant tmuxinator gem zsh-syntax-highlighting)

# Env
# ---
export EDITOR=vim
export VISUAL=vim
export DISABLE_AUTO_TITLE=true

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
