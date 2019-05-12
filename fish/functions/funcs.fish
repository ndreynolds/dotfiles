function funcs --description "manage user-defined funcs"
    set funcs_dir $DOTFILES_DIR/fish/functions

    pushd $PWD
    cd $funcs_dir

    if count $argv >/dev/null
        if [ $argv[1] = "edit" ]
            if test (count $argv) -gt 1
                vim $argv[2]
            else
                vim (fd --type f . | fzf)
            end
        else if [ $argv[1] = "link" ]
            eval $DOTFILES_DIR/bin/dotfiles-link
        end
    else
        rg --only-matching \
           --regexp 'function ([\w-_]+)( --description(.*))?' \
           --replace ' $3' \
           --no-line-number \
           --sort-files \
           --no-heading \
           .
    end

    popd
end

complete -c funcs -a "edit"
