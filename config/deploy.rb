# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

require 'dotenv'
Dotenv.load

set :application,       'torrent_panic'
set :repo_url,          'git@github.com:jurgens/torrent-panic.git'

# Default branch is :master
set :branch,            `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to,         (proc { "/home/panic/#{fetch :application}_#{fetch :stage}" })
set :deploy_via,        :remote_cache
set :format,            :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :log_level,         :info
set :pty,               false

append :linked_files, 'config/database.yml', 'config/secrets.yml', '.env'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :ssh_options,       forward_agent: true

set :rvm_type,          :user
set :rvm_ruby_version,  '2.4.6'

set :rollbar_token, ENV['ROLLBAR_ACCESS_TOKEN']
set :rollbar_env, -> { fetch :stage }
set :rollbar_role, -> { :app }

# set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
