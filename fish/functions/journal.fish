function journal --description "open a journal entry"
    if count $argv >/dev/null
        if [ $argv[1] = "read" ]
            cd $JOURNAL_DIR; rake
        else if [ $argv[1] = "yesterday" ]
            set yesterday (date -v -1d "+%Y-%m-%d")
            vim "$JOURNAL_DIR/entries/$yesterday.md"
        else
            vim "$JOURNAL_DIR/entries/$argv[1]"
        end
    else
        set today (date "+%Y-%m-%d")
        vim "$JOURNAL_DIR/entries/$today.md"
    end
end

complete -x -c journal -a "read yesterday (ls $JOURNAL_DIR/entries)"
