require 'pathname'
 
rails_env  = ENV['RAILS_ENV'] || 'development'
rails_root = Pathname(__FILE__).dirname.dirname.expand_path

pid               rails_root.join("tmp/pids/unicorn.pid").to_s
working_directory rails_root.to_s
worker_processes  2
timeout           30
listen            3000
preload_app       false
 
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
  # Reestablish the rails connection
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end