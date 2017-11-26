function big-files --description "Shows large files in a directory (or cwd)"
    tree -ah --du $argv | ack "\[(\d{3,}M|\d+.*G)\]"
end
