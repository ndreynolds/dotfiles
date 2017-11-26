function mix-format
    docker run --rm -it -v (pwd):/app -w /app leifg/elixir:edge mix format $argv[1]
end
