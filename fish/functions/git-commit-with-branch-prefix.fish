function git-commit-with-branch-prefix
    git commit -em (git symbolic-ref HEAD | grep -oE "STEEL-\d{3,4}")
end
