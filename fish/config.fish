# aliases
# -------

alias c 'clear'
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'

alias ev 'vim ~/.vimrc'
alias ef 'vim ~/.config/fish/config.fish'
alias el 'vim ~/.config/fish/local.fish'
alias et 'vim ~/.tmux.conf'
alias eg 'vim ~/.gitconfig'

abbr r 'bundle exec rspec'
abbr rs 'bundle exec rails server'
abbr rc 'bundle exec rails console'
abbr rk 'bundle exec rake'
abbr rspec-without-features 'bundle exec rspec --exclude-pattern "spec/features/**/*"'
abbr rails-db-console 'bundle exec rails dbconsole'
abbr rails-open-last-migration "$EDITOR (ls db/migrate/* | tail -n1)"

abbr g 'git'
abbr gs 'git s'
abbr gc 'git commit'
alias gcd 'cd (git rev-parse --show-toplevel)'

alias serve 'python -m SimpleHTTPServer'
alias pj 'python -m json.tool | pygmentize -l json'
alias bigfiles "tree -ah --du $argv | ack \"\[(\d{3,}M|\d+.*G)\]\""
alias wordfreq "perl -0777 -lape's/\s+/\n/g' $1 | sort | uniq -c | sort -nr"


# environment
# -----------

set -x VIM_BINARY vim
set -x MVIM_BINARY mvim

if contains (command uname) 'Darwin'
    # set -x VIM_BINARY "$HOME/Applications/MacVim.app/Contents/MacOS/Vim"
    set -x VIM_BINARY "/usr/local/bin/nvim"
    set -x MVIM_BINARY "$HOME/Applications/MacVim.app/Contents/MacOS/MacVim"
    alias vim $VIM_BINARY
    alias mvim $MVIM_BINARY
end

set -x EDITOR $VIM_BINARY
set -x AUTHOR 'Nick Reynolds'


# functions
# ---------

function bigfiles
    tree -ah --du $argv | ack "\[(\d{3,}M|\d+.*G)\]"
end

function notes --description "open a note"
    vim $HOME/repos/notes/$argv[1]
end

complete -x -c notes -c n -a "(ls $HOME/repos/notes)"

function journal --description "open a journal entry"
    if count $argv >/dev/null
        if [ $argv[1] = "read" ]
            cd "$HOME/repos/journal"; rake
        else if [ $argv[1] = "yesterday" ]
            set yesterday (date -v -1d "+%Y-%m-%d")
            vim "$HOME/repos/journal/entries/$yesterday.md"
        else
            vim "$HOME/repos/journal/entries/$argv[1]"
        end
    else
        set today (date "+%Y-%m-%d")
        vim "$HOME/repos/journal/entries/$today.md"
    end
end

complete -x -c journal -a "read yesterday (ls $HOME/repos/journal/entries)"

complete -x -c spotify -c a -a "play next prev pos pause quit vol status share toggle"

# PATH config
# -----------

set PATH /usr/local/bin $PATH
set PATH /usr/local/sbin $PATH
set PATH $HOME/dotfiles/bin $PATH


# local config
# ------------

if test -s $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

source $HOME/.config/fish/functions/fish_user_key_bindings.fish

# startup
# -------

if status --is-interactive
    bash ~/dotfiles/bin/dotfiles-update
end
