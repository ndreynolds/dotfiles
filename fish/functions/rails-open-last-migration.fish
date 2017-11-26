function rails-open-last-migration
    edit (ls db/migrate/* | tail -n1)
end
