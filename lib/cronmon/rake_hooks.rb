# frozen_string_literal: true

require 'rake'
require_relative '../helpers/cron_helper'

# This is adding hooks for rake task at global level of application.
# This hooks will only applied for rake task which are under schedule namespace.
task :before_hook do
  include CronHelper

  add_cron_log(ARGV&.first)
end

task :after_hook do
  include CronHelper

  at_exit do
    update_cron_log(Time.now)
  end
end
