if ENV['RAILS_ENV'] == 'production'
  application_path = ENV['PWD']
  directory application_path
  environment ENV['RAILS_ENV']
  pidfile "#{application_path}/tmp/pids/puma.pid"
  stdout_redirect "#{application_path}/tmp/log/stdout", "#{application_path}/tmp/log/stderr"
  threads 2, 16
  workers 2
  bind 'tcp://0.0.0.0:9292'
  daemonize true
  preload_app!
end
