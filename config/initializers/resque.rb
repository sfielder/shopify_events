require 'resque'
require 'resque/server'
require 'resque_scheduler'
require 'resque_scheduler/server'

Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60) # 24hrs in seconds
Resque::Scheduler.dynamic = true
