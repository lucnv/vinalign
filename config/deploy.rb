# config valid only for current version of Capistrano
require "capistrano"
require "capistrano/deploy"

set :application, "vinalign"
set :repo_url, "git@github.com:otchoo/vinalign.git"
set :pty, true
set :linked_files, %w(config/database.yml config/application.yml)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
set :keep_releases, 3
set :rvm_type, :user

set :puma_rackup, -> {File.join(current_path, "config.ru")}
set :puma_state, -> {"#{shared_path}/tmp/pids/puma.state"}
set :puma_pid, -> {"#{shared_path}/tmp/pids/puma.pid"}
set :puma_bind, -> {"unix://#{shared_path}/tmp/sockets/puma.sock"}
set :puma_conf, -> {"#{shared_path}/puma.rb"}
set :puma_access_log, -> {"#{shared_path}/log/puma_access.log"}
set :puma_error_log, -> {"#{shared_path}/log/puma_error.log"}
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, "production"))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

set :sidekiq_role, :app
set :sidekiq_config, -> {File.join(current_path, "config", "sidekiq.yml")}
set :sidekiq_env, "production"
set :sidekiq_pid, -> {"#{shared_path}/tmp/pids/sidekiq.pid"}
set :sidekiq_log, -> {"#{shared_path}/log/sidekiq.log"}
set :pty, false
SSHKit.config.command_map[:sidekiq] = "source ~/.bash_profile && RAILS_ENV=production bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "source ~/.bash_profile && RAILS_ENV=production bundle exec sidekiqctl"
