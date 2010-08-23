# unicorn_rails -c /opt/tedxperth/staging/config/unicorn.rb -E production -D
require 'pathname'

app_name   = ENV['USER']
rails_env  = ENV['RAILS_ENV'] || 'staging'
rails_root = Pathname(ENV['HOME']).join(rails_env).expand_path

timeout           30
worker_processes  2
preload_app       true
working_directory rails_root.to_s
listen            "/var/run/unicorn/#{app_name}_#{rails_env}.sock", :backlog => 256
pid               rails_root.join("tmp/pids/unicorn.pid").to_s

stderr_path rails_root.join("log/unicorn.stderr.log").to_s
stdout_path rails_root.join("log/unicorn.stdout.log").to_s

GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

before_fork do |server, worker|
  old_pid = rails_root.join("tmp/pids/unicorn.pid.oldbin")
  if File.exists?(old_pid) && server.pid != File.read(old_pid).to_i
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
  worker.user(app_name, app_name) if Process.euid == 0
end