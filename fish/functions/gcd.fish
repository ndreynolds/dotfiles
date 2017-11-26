function gcd --description "Navigate to the root of the current Git repository"
    cd (git rev-parse --show-toplevel)
end
