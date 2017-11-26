function notes --description "open a note"
    if test (count $argv) -gt 0
        if [ $argv[1] = "search" ]
            if test (count $argv) -gt 1
                rg $argv[2] $NOTES_DIR
            else
                set choice (rg -i --vimgrep '.+' $NOTES_DIR | fzf)
                if [ $choice ]
                    set path (echo $choice | rg --only-matching -e '[^:]+:\d+:\d+')
                    edit $path
                end
            end
        else
            edit $NOTES_DIR/$argv[1]
        end
    else
        fd --type f . $NOTES_DIR | fzf --bind "enter:execute(edit {})+abort"
    end
end

complete -x -c notes -c n -a "(ls $NOTES_DIR)"
