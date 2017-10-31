# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# run this task only on servers with the :app role in Capistrano
# see Capistrano roles section below

#job_type :awesome, '/usr/local/bin/awesome :task :fun_level'
#RAILS_ROOT = File.dirname(__FILE__) + '/..'
require File.expand_path(File.dirname(__FILE__) + "/environment")

# User command to set environment = whenever --update-crontab appname --set environment=development
every :day, :at => '09:00am', :roles => [:app] do
  runner "Article.parse_rss", :output => 'log/whenever.log'
end

every :day, :at => '18:00am', :roles => [:app] do
  runner "Article.parse_rss", :output => 'log/whenever.log'
end

#set :output, 'log/whenever.log'