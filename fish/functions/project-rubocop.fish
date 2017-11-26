function project-rubocop --description "Runs version of rubocop specified by .gitlab-ci.yml"
    set rubocop_version (rg -o -r '$1' "rubocop -v (.*)" .gitlab-ci.yml)
    echo "Found rubocop v$rubocop_version in .gitlab-ci.yml..."
    rubocop "_"$rubocop_version"_"
end
