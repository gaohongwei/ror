# config valid only for Capistrano 3.1
lock '3.3.5'

set :rvm_type, :user # Defaults to: :auto
set :rvm_ruby_version, '2.1.2' # Defaults to: 'default'

set :bundle_without, 'test'

set :application, 'myapp'
set :repo_url, 'git@github.com:cirroscope/myapp.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/mongoid.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  # after :restart, :indexes do
  #   on roles(:app) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, 'elasticsearch:import:all'
  #       end
  #     end
  #   end
  # end

  desc 'import elasticsearch indexes'
  task :import_elasticesearch_indexes do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'elasticsearch:import:all'
        end
      end
    end
  end

  after :publishing, :restart
  # after :restart, :import_elasticesearch_indexes

  desc 'Rebuild assets'
  task :rebuild_assets_risks_messages do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "test_data:rebuild_assets_risks_messages #{data_config}"
        end
      end
    end
  end

  desc 'Increase assets'
  task :increase_data do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "test_data:increase_data #{data_config}"
        end
      end
    end
  end

  desc 'Rebuild All'
  task :rebuild_all do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "test_data:rebuild_all #{data_config}"
        end
      end
    end
  end

  desc 'Cleanup and Users'
  task :clean_and_setup_users do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'test_data:setup_users'
        end
      end
    end
  end

  desc 'Fake policies'
  task :rebuild_policies do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'test_data:fake_policies'
        end
      end
    end
  end

  # after :rebuild_assets_risks_messages, :import_elasticesearch_indexes
  # after :rebuild_all, :import_elasticesearch_indexes
  # after :rebuild_policies, :rebuild_assets_risks_messages

  # after :restart, :clear_cache do
  #   on roles(:app), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #  with :rails_env => fetch(:rails_env) do
  #     #    execute :rake, 'mongoid_search:index'
  #     #  end
  #     # end
  #   end
  # end
end

def data_config
  [:people, :assets, :raw_assets, :collaborators, :risks, :messages, :events].map do |var|
    "#{var}=#{ENV[var.to_s] || -1}"
  end.join(' ')
end

namespace :message do
  desc 'update Message attachments to a Hash'
  task :update_attachments do
    on primary(:db) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'message:update_attachments'
        end
      end
    end
  end
end
