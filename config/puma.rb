environment ENV['RAILS_ENV'] || 'production'
pidfile Rails.root.join("tmp/pids/puma.pid").to_s
stdout_redirect Rails.root.join("tmp/log/stdout").to_s, Rails.root.join("tmp/log/stderr").to_s
threads 2, 16
workers 2
bind 'tcp://0.0.0.0:9292'
daemonize true
