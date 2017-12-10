# environment
# -----------

set -x VIM_BINARY vim
if type -q nvim
    set -x VIM_BINARY "/usr/local/bin/nvim"
end

set -x FISH_CONFIG_DIR "$HOME/.config/fish"
set -x DOTFILES_DIR "$HOME/dotfiles"
set -x CODE_DIR "$HOME/code"
set -x NOTES_DIR "$HOME/notes"

set -x ME 'Nick Reynolds'
set -x AUTHOR $ME

set -x EDITOR $VIM_BINARY
set -x ELIXIR_EDITOR "$VIMR_BINARY --nvim '+__LINE__' __FILE__"

set -x FZF_DEFAULT_COMMAND 'rg --files'


# PATH config
# -----------

set -x PATH /usr/local/bin /usr/local/sbin $HOME/dotfiles/bin $HOME/bin $PATH


# aliases
# -------

alias c 'clear'
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'

alias vim $VIM_BINARY
alias edit $EDITOR
alias e edit
alias ev 'edit ~/.config/nvim/init.vim'
alias ef 'edit ~/.config/fish/config.fish'
alias el 'edit ~/.config/fish/local.fish'
alias eg 'edit ~/.gitconfig'

abbr be 'bundle exec'
abbr br 'bin/rails'
abbr r 'bin/rails spec'
abbr rs 'bin/rails server'
abbr rc 'bin/rails console'
abbr rk 'bin/rake'
abbr rspec-without-features 'bundle exec rspec --exclude-pattern "spec/features/**/*"'

abbr g 'git'
abbr gs 'git s'
abbr gc 'git commit'
abbr gcs git-commit-with-branch-prefix

abbr dc 'docker-compose'
abbr dcr 'docker-compose run --rm'
abbr dcu 'docker-compose pull --parallel; and docker-compose up -d'


# functions
# ---------

complete -x -c spotify -c a -a "play next prev pos pause quit vol status share toggle"


# source local config
# -------------------

if test -s $FISH_CONFIG_DIR/local.fish
    source $FISH_CONFIG_DIR/local.fish
end

if test -s $FISH_CONFIG_DIR/functions/fish_user_key_bindings.fish
    source $FISH_CONFIG_DIR/functions/fish_user_key_bindings.fish
end


# startup
# -------

# if status --is-interactive
#     bash ~/dotfiles/bin/dotfiles-update
# end
