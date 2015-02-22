#!/bin/env/ruby
#
# Backup selected directories to Amazon S3 using duplicity.
#
# Usage:
#   backup sync
#   backup restore /restore/path
#
# The following should be set up as environment variables:
#   $AWS_ACCESS_KEY_ID       (AWS access key)
#   $AWS_SECRET_ACCESS_KEY   (AWS secret access key)
#   $DUPLICITY_DIRS          ($PATH-like colon-separated string of directories)
#   $DUPLICITY_KEY           (symmetric encryption passphrase)
#   $DUPLICITY_BUCKET_ID     (AWS S3 bucket id)

require 'pp'

USAGE = %(
Usage:
  backup sync
  backup restore /path/to/an/existing/directory
)

REQUIRED_ENV_VARIABLES = %w(
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  DUPLICITY_DIRS
  DUPLICITY_KEY
  DUPLICITY_BUCKET_ID
)

DEFAULTS = {
  duplicity_path: '/usr/local/bin/duplicity',
  duplicity_options: [
    '--volsize 250',
    '--allow-source-mismatch',
    '--full-if-older-than 30D'
  ],
  includes: [],
  excludes: ['*', '/.*']
}

def abort(msg)
  $stderr.puts "Error: #{msg}"
  $stderr.puts USAGE
  exit 1
end

def setup_env
  REQUIRED_ENV_VARIABLES.each do |var|
    abort "$#{var} is not set." if ENV[var].nil?
  end

  ENV['PASSPHRASE'] = ENV['DUPLICITY_KEY']
end

def s3_url(bucket)
  "s3+http://#{bucket}"
end

def restore(bucket, path, options = {})
  options = DEFAULTS.merge(options)
  `#{options[:duplicity_path]} restore "#{s3_url(options[:bucket])}" #{path}`
end

def sync(bucket, options = {})
  options = DEFAULTS.merge(options)
  includes = options[:includes].map { |d| "--include '#{d}'" }.join(' ')
  excludes = options[:excludes].map { |d| "--exclude '#{d}'" }.join(' ')
  duplicity_options = options[:duplicity_options].join(' ')
  pp options

  `ulimit -n 1024`
  `#{options[:duplicity_path]} #{includes} #{excludes} #{duplicity_options} / "#{s3_url(bucket)}"`
end

setup_env

case ARGV[0]
when 'restore'
  abort "'restore' requires a restore path" unless ARGV.count == 2
  restore ENV['DUPLICITY_BUCKET_ID'], ARGV[1]
when 'sync'
  sync ENV['DUPLICITY_BUCKET_ID'], includes: ENV['DUPLICITY_DIRS'].split(':')
else
  abort 'incorrect usage'
end
