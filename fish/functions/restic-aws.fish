function restic-aws --argument-names "subcommand" --description "Wrapper around restic with AWS config"
    set pass_restic_aws_key "personal/restic-aws"
    set pass_restic_key "personal/restic"

    begin
        set -lx AWS_ACCESS_KEY_ID (gopass show $pass_restic_aws_key_ | jq -r .accessKeyId)
        set -lx AWS_SECRET_ACCESS_KEY (gopass show $pass_restic_aws_key | jq -r .secretAccessKey)

        set -lx RESTIC_REPOSITORY (gopass show $pass_restic_aws_key | jq -r .backupBucketUrl)
        set -lx RESTIC_PASSWORD (gopass show $pass_restic_key)

        if test -n "$subcommand"
            if [ $subcommand = 's3-backup' ]
                restic backup --files-from ~/.restic-file-spec
            end
        else
            restic "$argv"
        end
    end
end
