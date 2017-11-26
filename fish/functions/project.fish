function project
    cd (cd $CODE_DIR; and fd --type d --max-depth 3 | fzf)
    commandline -f repaint
end
