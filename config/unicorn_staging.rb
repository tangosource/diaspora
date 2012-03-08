rails_env = ENV['RAILS_ENV'] || 'staging'

# Enable and set these to run the worker as a different user/group
#user  = 'diaspora'
#group = 'diaspora'

worker_processes 10

## Load the app before spawning workers
#preload_app true

# How long to wait before killing an unresponsive worker
#timeout 30

pid 'tmp/pids/staging.pid'
#listen '/var/run/diaspora/diaspora.sock', :backlog => 2048
listen '/var/run/gtb/staging0.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging1.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging2.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging3.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging4.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging5.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging6.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging7.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging8.sock', :backlog => 2048, :tcp_nodelay => true
listen '/var/run/gtb/staging9.sock', :backlog => 2048, :tcp_nodelay => true

# Ruby Enterprise Feature
if GC.respond_to?(:copy_on_write_friendly=)
  GC.copy_on_write_friendly = true
end


before_fork do |server, worker|
  # If using preload_app, enable this line
  #ActiveRecord::Base.disconnect!

  old_pid = '/var/run/diaspora/diaspora.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
  # If using preload_app, enable this line
  # ActiveRecord::Base.establish_connection

  # Enable this line to have the workers run as different user/group
  #worker.user(user, group)
end
