function restic-aws --argument-names "subcommand" --description "Wrapper around restic with AWS config"
    begin
        set -lx AWS_ACCESS_KEY_ID (gopass show restic-aws | jq -r .accessKeyId)
        set -lx AWS_SECRET_ACCESS_KEY (gopass show restic-aws | jq -r .secretAccessKey)

        set -lx RESTIC_REPOSITORY (gopass show restic-aws | jq -r .backupBucketUrl)
        set -lx RESTIC_PASSWORD (gopass show restic)

        if test -n "$subcommand"
            if [ $subcommand = 's3-backup' ]
                restic backup --files-from ~/.restic-file-spec
            end
        else
            restic "$argv"
        end
    end
end
