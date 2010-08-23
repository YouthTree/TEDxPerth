require 'rvm/capistrano'

load 'deploy' if respond_to?(:namespace) 
set :application, "tedxperth"

# Default is staging
set :rails_env, "staging"
set :use_sudo,  false

# Setup users.
set(:user)   { application }
set(:runner) { user }
set(:group)  { user }

set :server_hosts, :staging    => "dracorex.youthtree.org.au",
                   :production => "dryptosaurus.youthtree.org.au"

# Set where it is deployed.
set(:deploy_to) { "/opt/#{application}/#{rails_env}" }

# Set how it is deployed
set :scm,             :git
set :repository_name, "TEDxPerth"
set :copy_exclude,     %w(config/database.yml config/settings.yml test spec .git doc)

set(:deploy_via) { defined?(Capistrano::Deploy::Strategy::FastRemoteCache) ? :fast_remote_cache : :remote_cache }
set(:repository) { "git://github.com/YouthTree/#{repository_name}.git" }

# Setup dynamic roles.
role(:web)                  { server_hosts[rails_env.to_sym] }
role(:app)                  { server_hosts[rails_env.to_sym] }
role(:db, :primary => true) { server_hosts[rails_env.to_sym] }

set(:rvm_ruby_string) { "ree@#{application}" }

def bundle_exec(command)
  run "cd '#{latest_release}' && RAILS_ENV='#{rails_env}' bundle exec #{command}"
end

namespace :unicorn do
  
  def signal!(signal)
    pid_file = "tmp/pids/unicorn.pid"
    run "cd '#{current_path}' && [ -f #{pid_file} ] && kill -#{signal} `cat #{pid_file}`"
  end
  
  task :configure, :roles => :app do
    run "rm -rf '#{latest_release}/config/unicorn.rb'"
    run "ln -s '#{shared_path}/unicorn.rb' '#{latest_release}/config/unicorn.rb'"
    run "rm -rf '#{latest_release}/tmp/sockets'"
    run "ln -s '#{shared_path}/sockets' '#{latest_release}/tmp/sockets'"
  end
  
  task :start, :roles => :app do
    run "cd '#{current_path}' && unicorn_rails -D -E #{rails_env} -c '#{current_path}/config/unicorn.rb'"
  end
  
  task :stop, :roles => :app do
    signal! :QUIT
  end
  
  task :restart, :roles => :app do
    signal! :USR2
  end
  
end

namespace :app do
  task :setup do
    run "touch '#{shared_path}/unicorn.rb'"
    run "touch '#{shared_path}/database.yml'"
    run "touch '#{shared_path}/settings.yml'"
    run "mkdir -p '#{shared_path}/uploads' '#{shared_path}/sockets'"
  end
end

after 'deploy:setup', 'app:setup'

namespace :barista do
  task :prepare do
    bundle_exec "rake barista:brew"
  end
end

namespace :jammit do
  task :prepare do
    bundle_exec "jammit -f" 
  end
end

namespace :compass do
  task :prepare do
    bundle_exec "compass compile ."
  end
end

namespace :uploads do
  task :symlink do
    run "rm -rf '#{latest_release}/public/uploads'"
    run "ln -s '#{shared_path}/uploads' '#{latest_release}/public/uploads'"
  end
end

namespace :settings do
  task :symlink do
    run "rm -rf '#{latest_release}/settings.yml'"
    run "ln -s '#{shared_path}/settings.yml' '#{latest_release}/config/settings.yml'"
  end
end

namespace :db do
  task :symlink do
    run "rm -rf '#{latest_release}/config/database.yml'"
    run "ln -s '#{shared_path}/database.yml' '#{latest_release}/config/database.yml'"
  end
end

namespace :bundle do
  task :install do
    run "cd '#{latest_release}' && bundle install --path '#{shared_path}/bundle' --deployment --without development:test"
  end
end

namespace :app do
  task :prepare do
    unicorn.configure
    barista.prepare
    compass.prepare
    jammit.prepare
    uploads.symlink
  end
end

namespace :deploy do
  task :start, :roles => :app do
    unicorn.start
  end
  task :stop, :roles => :app do
    unicorn.stop
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    unicorn.restart
  end
end

after "deploy:update_code", "bundle:install"
after "deploy:update_code", "db:symlink"
after "deploy:update_code", "settings:symlink"
after "deploy:update_code", "app:prepare"