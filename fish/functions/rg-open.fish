function rg-open --description "Search for pattern and open with fzf & editor"
    set choice (rg -il $argv | fzf -0 -1 --ansi --preview "cat {} | rg -i $argv --pretty --context 3")
    if [ $choice ]
        edit '+/\c'$argv $choice
    end
end
