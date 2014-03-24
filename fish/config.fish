# aliases
# -------

alias c 'clear'
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'

alias n notes
alias r repo
alias a ankid

alias v vim

alias ev 'vim ~/.vimrc'
alias ef 'vim ~/.config/fish/config.fish'
alias et 'vim ~/.tmux.conf'
alias eg 'vim ~/.gitconfig'

alias tmux 'env TERM=screen-256color-bce tmux'
alias mux tmuxinator
alias serve 'python -m SimpleHTTPServer'
alias sp 'vim ~/repos/scratchpad/scratchpad.md'
alias wordfreq "perl -0777 -lape's/\s+/\n/g' $1 | sort | uniq -c | sort -nr"
alias splive 'vim -c "OpenScratchpad" -c only'
alias todo 'vim "$HOME/repos/todo/todo.txt"'
alias rpry 'pry -r ./config/environment'

alias ..    'cd ..'
alias ...   'cd ../..'
alias ....  'cd ../../..'
alias ..... 'cd ../../../..'

alias l1 'tree --dirsfirst -ChFL 1'
alias l2 'tree --dirsfirst -ChFL 2'
alias l3 'tree --dirsfirst -ChFL 3'
alias l4 'tree --dirsfirst -ChFL 4'
alias l5 'tree --dirsfirst -ChFL 5'
alias l6 'tree --dirsfirst -ChFL 6'

alias ll1 'tree --dirsfirst -ChFupDaL 1'
alias ll2 'tree --dirsfirst -ChFupDaL 2'
alias ll3 'tree --dirsfirst -ChFupDaL 3'
alias ll4 'tree --dirsfirst -ChFupDaL 4'
alias ll5 'tree --dirsfirst -ChFupDaL 5'
alias ll6 'tree --dirsfirst -ChFupDaL 6'


# environment
# -----------

set -x VIM_BINARY vim
set -x MVIM_BINARY mvim 

if contains (command uname) 'Darwin'
    set -x VIM_BINARY '/Applications/MacVim.app/Contents/MacOS/Vim'
    set -x MVIM_BINARY '/Applications/MacVim.app/Contents/MacOS/MacVim'
    alias vim $VIM_BINARY
    alias mvim $MVIM_BINARY
end

set -x EDITOR $VIM_BINARY


# functions
# ---------

function pj
    python -m json.tool | pygmentize -l json
end

function bigfiles 
    tree -ah --du $argv | ack "\[(\d{3,}M|\d+.*G)\]"
end

function notes --description "open a note"
    vim $HOME/repos/notes/$argv[1]
end

complete -x -c notes -c n -a "(ls $HOME/repos/notes)"

function journal --description "open a journal entry"
    if count $argv >/dev/null
        if [ $argv[1] = "yesterday" ]
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

complete -x -c journal -a "yesterday (ls $HOME/repos/journal/entries)"

function repo
    cd "$HOME/repos/$argv[1]"
end

complete -x -c repo -a "(ls $HOME/repos)"

function ankid
    vim "$HOME/repos/anki-imports/$argv[1]"
end

complete -x -c ankid -c a -a "(ls $HOME/repos/anki-imports)"


# PATH config
# -----------

set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH $HOME/dotfiles/bin $PATH


# local config
# ------------

if test -s $HOME/.config/fish/local.fish
    . $HOME/.config/fish/local.fish
end


# oh-my-fish config
# -----------------

set fish_path $HOME/.oh-my-fish
set fish_theme idan
set fish_plugins git brew rake rbenv rails bundler
. $fish_path/oh-my-fish.fish


# startup
# -------

bash ~/dotfiles/bin/dotfiles-update
