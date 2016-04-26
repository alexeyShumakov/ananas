set :output, "log/cron_log.log"
env :PATH, ENV['PATH']

every :friday, at: '8am' do
  rake 'utils:weekly_email'
end
# every 1.minute do
#   rake 'utils:weekly_email', :environment => 'development' 
# end
